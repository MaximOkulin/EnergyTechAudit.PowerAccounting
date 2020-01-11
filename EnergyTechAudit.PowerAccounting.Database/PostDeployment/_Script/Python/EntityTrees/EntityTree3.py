
objNode = None
treeViewNode = None
objParentNode = None


class EntityTreeNodeCustomCollector(object):
           
    @staticmethod
    def buildingNodePicker():
        treeViewNode.Text = System.String.Join(", ", objNode.FullAddress.Split(",").Take(2).ToArray());

        
    @staticmethod
    def placementNodePicker():

        treeViewNode.Text = System.String.Format(
            "{0}{1} {2}", \
            objNode.PlacementPurpose.ToString(), \
            ":" if not System.String.IsNullOrEmpty(objNode.Number) else System.String.Empty, objNode.Number
        )        
    

    @staticmethod
    def userAdditionalInfoNodePicker():
        treeViewNode.Text = System.String.Format("{0}", objNode.Description)


    @staticmethod
    def userNodePicker():
        treeViewNode.Text = System.String.Format("Учетная запись: {0}", objNode.UserName)

    
   
        
   