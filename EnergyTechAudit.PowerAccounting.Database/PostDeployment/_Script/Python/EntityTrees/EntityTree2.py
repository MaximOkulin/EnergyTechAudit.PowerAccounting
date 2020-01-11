
objNode = None
treeViewNode = None
objParentNode = None


class EntityTreeNodeCustomCollector(object):
        
   
    @staticmethod
    def buildingNodePicker():
        treeViewNode.Text = objNode.Description;
     
        
    @staticmethod
    def accessPointNodePicker():
        treeViewNode.Text = System.String.Format("{0}", objNode.Description)

    
    @staticmethod
    def measurementDeviceNodePicker():
        treeViewNode.Text = System.String.Format("{0}", objNode.Description);
        
   