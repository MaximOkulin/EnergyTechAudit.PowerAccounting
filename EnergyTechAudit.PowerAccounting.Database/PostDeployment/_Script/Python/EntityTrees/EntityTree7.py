clr.AddReference("EnergyTechAudit.PowerAccounting.Web.Common")
from EnergyTechAudit.PowerAccounting.Web.Common.Html import TreeViewNodeDataItem

objNode = None
treeViewNode = None
objParentNode = None


class EntityTreeNodeCustomCollector(object):
     
    class AggrKey(object):
     
        def __init__(self, key, iconClass, iconColor):
            self.key = key
            self.iconClass = iconClass
            self.iconColor = iconColor

    aggregation_keys = [ 
        AggrKey("ИТП", "font-icon-itp font-icon-x1_3", "font-icon-indigo"),
        AggrKey("ОФИС", "font-icon-office font-icon-x1_3", "font-icon-darkslategrey"),
        AggrKey("ДОМ", "font-icon-flat font-icon-x1_3", ""),
        AggrKey("подъезд", "font-icon-entrance font-icon-x1_3", "font-icon-black"),
        AggrKey("ВРУ", "font-icon-itp font-icon-x1_3", "font-icon-tomato"),

        AggrKey("ПОЛИКЛИНИКА", "font-icon-hospital font-icon-x1_3", "font-icon-red"),
        AggrKey("БОЛЬНИЦА", "font-icon-hospital font-icon-x1_3", "font-icon-red"),
    ]

    building_node_text_regex = re.compile(r"(улица|ул\.|проспект|пр\.|\s+улица)", re.IGNORECASE)


    @staticmethod
    def cityNodePicker():
        treeViewNode.Text = "{0}".format(objNode.Description);


    @staticmethod
    def districtNodePicker():
        treeViewNode.Text = objNode.Description


    @staticmethod
    def buildingNodePicker():

        placementWithIndividualAccountingCount = objNode.Placements.Where(lambda p: p.HasIndividualAccounting).Count()
        hasIndividualAccounting = placementWithIndividualAccountingCount > 0
        hasBoilerRoom = objNode.Placements.Where(lambda p: p.PlacementPurposeId == 4).Count()

        treeViewNode.ToolTip = String.Empty        
        treeViewNode.Text = EntityTreeNodeCustomCollector.building_node_text_regex.sub(String.Empty, objNode.Description) \
            .replace(objNode.District.City.Description, String.Empty) \
            .rstrip(", ") \
            .strip() \
            .replace(" ,", ",")


        if hasIndividualAccounting:
            buidingInfo = "{{\"entityId\": {0}, \"entityTypeName\": \"{1}\", \"hasIndividualAccounting\": true }}".format(objNode.Id, objNode.GetType().Name)
            treeViewNode.DataItem.CustomAttribute = "hasIndividualAccounting"
            treeViewNode.ToolTip = "Индивидуальный учет"	
            treeViewNode.DataItem.IconClass = "font-icon-building font-icon-orangered font-icon-x1_3"
            treeViewNode.AddNodeConditionally(hasIndividualAccounting, "Индивидуальный учет: {0} помещений".format(placementWithIndividualAccountingCount), "fake", "font-icon-flat font-icon-orangered font-icon-x1_3", buidingInfo, "Channel") 
        
    
            for p in objNode.Placements.Where(lambda p: p.HasIndividualAccounting):
                placementNode = treeViewNode.Nodes[0].Nodes.Add( "Квартира" + (String.Empty if p.Number == None else " {number}".format(number=p.Number) ) , "fake")		
                dt = TreeViewNodeDataItem()
                dt.DataItem = p
                dt.IconClass = "font-icon-placement font-icon-orangered font-icon-x1_3"
                placementNode.DataItem = dt
                
                for c in p.Channels:		
                    channelNode = placementNode.Nodes.Add( c.Description, "fake" )
                    dt = TreeViewNodeDataItem()
                    dt.DataItem = c
                    dt.IconClass = "font-icon-channel font-icon-orangered font-icon-x1_3"
                    channelNode.DataItem = dt

        if hasBoilerRoom:
            treeViewNode.ToolTip = "Промышленный учет"
            treeViewNode.DataItem.IconClass = "font-icon-building font-icon-color-black font-icon-x1_3"
            placements = objNode.Placements.Where(lambda p: p.PlacementPurposeId == 4)
            for placement in placements:
                placementInfo = "{{\"entityId\": {0}, \"entityTypeName\": \"{1}\", \"placementPurposeId\": \"{2}\", \"hasBoilerRoom\": true}}".format(placement.Id, placement.GetType().Name, placement.PlacementPurposeId)
                nodeCaption = placement.Description if placement.Comment is None else placement.Comment
                treeViewNode.AddNodeConditionally(hasBoilerRoom, nodeCaption, "fake", "font-icon-boilerroom font-icon-black font-icon-x1_3", placementInfo, "Channel")
                
        has_aggregation_channels = objNode.Placements \
            .SelectMany(lambda p: p.Channels) \
            .Where(lambda c: (EntityTreeNodeCustomCollector.aggregation_keys).Any(lambda k: c.Description.Contains(k.key))) \
            .Any()


        if has_aggregation_channels:    
   
            aggregation_node_descriptions = objNode.Placements \
                .SelectMany(lambda p: p.Channels) \
		        .SelectMany(lambda c: re.findall(r"\w+", c.Description)) \
                .Where(lambda d: (EntityTreeNodeCustomCollector.aggregation_keys).Any(lambda k:  d.Contains(k.key))) \
                .OrderBy(lambda d: d) \
                .Distinct()

            for nd in aggregation_node_descriptions:
                aggregation_node = treeViewNode.Nodes.Add(nd.upper(), "fake" )
                                
                aggr_key = next((o for o in EntityTreeNodeCustomCollector.aggregation_keys if nd.find(o.key) != -1), None)

                dt = TreeViewNodeDataItem()
                dt.DataItem = objNode
                dt.IconClass = aggr_key.iconClass + " " + aggr_key.iconColor
                aggregation_node.DataItem = dt

                aggregable_channels = objNode.Placements \
                    .SelectMany(lambda p: p.Channels) \
                    .Where(lambda c: c.Description.Contains(nd)) \
                    .OrderBy(lambda c: c.Order)

                for ac in aggregable_channels:
                    aggregable_channel_node = aggregation_node.Nodes.Add( ac.Description, "fake" )
                    dt = TreeViewNodeDataItem()
                    dt.DataItem = ac
                    dt.IconClass = "font-icon-channel font-icon-x1_3" + " " + aggr_key.iconColor
                    aggregable_channel_node.DataItem = dt
    

    @staticmethod
    def channelNodePicker():
        
        has_aggregation_channels = (EntityTreeNodeCustomCollector.aggregation_keys).Any(lambda k: objNode.Description.Contains(k.key))

        isHidden = objNode.Placement.HasIndividualAccounting == True or has_aggregation_channels
        treeViewNode.Visible = not isHidden
        treeViewNode.Text = objNode.Description


    @staticmethod
    def placementNodePicker():

        treeViewNode.Text = "{0}{1} {2}".format(objNode.PlacementPurpose.ToString(),
            ":" if not System.String.IsNullOrEmpty(objNode.Number) else System.String.Empty, 
			objNode.Number
        )