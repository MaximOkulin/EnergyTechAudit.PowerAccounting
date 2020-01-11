import clr
import System

clr.AddReference(r"DevExpress.Web.Mvc5.v18.1")
clr.AddReference(r"DevExpress.Web.v18.1")
from DevExpress.Web.Mvc import MVCxGridViewColumn
from DevExpress.Web import GridViewCommandColumnCustomButton


gridSettings = None
ViewContext = None


class GridSettingsExtender(object):
    
    oldPreRenderEventHandler = None

    @staticmethod
    def Execute():        
        gridSettings.KeyFieldName = "MeasurementDeviceDeviceId"
        GridSettingsExtender.oldPreRenderEventHandler = gridSettings.PreRender           
        gridSettings.Columns["DistrictDescription"].GroupIndex = 0
        gridSettings.CustomColumnDisplayText = GridSettingsExtender.CustomColumnDisplayTextEventHandler
        gridSettings.PreRender = GridSettingsExtender.PreRenderEventHandler

        customButtonDetail = GridViewCommandColumnCustomButton();
        customButtonDetail.ID = "checkConnection"
        customButtonDetail.Index = 0
        customButtonDetail.Text = "<i title=''Проверка связи'' style=''cursor: pointer; margin-top: 1px;'' class=''font-icon-checkconnection font-icon-color-darkred''></i>"
        gridSettings.CommandColumn.CustomButtons.Add(customButtonDetail);

    
    @staticmethod
    def CustomColumnDisplayTextEventHandler(sender, args):
        args.EncodeHtml = False

        if args.Column.FieldName == "MeasurementDeviceDescription":
            args.DisplayText = "<div><i class=''font-icon-measurement-device font-icon-x1_2''></i> <span>{0}</span></div>".format(args.Value)    
        elif args.Column.FieldName == "AccessPointDescription":
            args.DisplayText = "<div><i class=''font-icon-access-point font-icon-x1_2''></i><span>{0}</span></div>".format(args.Value)
        elif args.Column.FieldName == "BuildingDescription":
            args.DisplayText = "<div><i class=''font-icon-building font-icon-x1_2''></i><span>{0}</span></div>".format(args.Value)

    @staticmethod
    def PreRenderEventHandler(sender, args):
        GridSettingsExtender.oldPreRenderEventHandler(sender, args)
        sender.ExpandAll()

           
class GridExportExtender(object):
    
    @staticmethod
    def Execute():
        pass