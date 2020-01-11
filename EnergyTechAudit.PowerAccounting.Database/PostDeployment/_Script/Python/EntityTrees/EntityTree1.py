
objNode = None
treeViewNode = None
objParentNode = None


class EntityTreeNodeCustomCollector(object):
        
    @staticmethod
    def cityNodePicker():
        treeViewNode.Text = System.String.Format("{0}", objNode.Description);


    @staticmethod
    def districtNodePicker():
        treeViewNode.Text = objNode.Description


    @staticmethod
    def buildingNodePicker():
        treeViewNode.Text = Regex.Replace(objNode.Description, "(улица|ул\\.|проспект|пр\\.|\\s+улица)", String.Empty) \
            .Replace(objNode.District.City.Description, String.Empty) \
            .TrimEnd(",", " ")
     
        
    @staticmethod
    def placementNodePicker():

        treeViewNode.Text = System.String.Format(
            "{0}{1} {2}", \
            objNode.PlacementPurpose.ToString(), \
            ":" if not System.String.IsNullOrEmpty(objNode.Number) else System.String.Empty, objNode.Number
        )

    
    @staticmethod
    def channelNodePicker():
        treeViewNode.Text = System.String.Format("{0}", objNode.Description)

    
    @staticmethod
    def measurementDeviceNodePicker():
        treeViewNode.Text = System.String.Format("{0}", objNode.Description);
        