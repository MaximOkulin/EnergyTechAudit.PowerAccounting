
objNode = None
treeViewNode = None
objParentNode = None


class EntityTreeNodeCustomCollector(object):
        
    
    @staticmethod
    def accessPointNodePicker():
        treeViewNode.Text = System.String.Format("Точка: {0}", objNode.NetAddress)
        
   
    @staticmethod
    def buildingNodePicker():
        treeViewNode.Text = objNode.Description


    @staticmethod
    def placementNodePicker():
        treeViewNode.Text = System.String.Format(
            "{0}{1} {2}", 
            objNode.PlacementPurpose.ToString(), 
            ":" if not System.String.IsNullOrEmpty(objNode.Number) else System.String.Empty,
           objNode.Number
        )


    @staticmethod
    def measurementDeviceNodePicker():
        treeViewNode.Text = objNode.Description