using System;
using System.Data;
using System.Data.Entity;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Net;
using System.Net.Mime;
using System.Reflection;
using System.Text;
using System.Web.Configuration;
using System.Web.Mvc;
using System.Xml.Linq;
using EnergyTechAudit.PowerAccounting.Common.Resources;
using EnergyTechAudit.PowerAccounting.DataAccess;
using EnergyTechAudit.PowerAccounting.Domain.Models.Admin;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;
using EnergyTechAudit.PowerAccounting.Domain.Models.WebApi;
using EnergyTechAudit.PowerAccounting.Infrastructure.Helpers;
using EnergyTechAudit.PowerAccounting.Infrastructure.Security;
using EnergyTechAudit.PowerAccounting.Web.Common.Controllers;
using EnergyTechAudit.PowerAccounting.Web.Common.Filters;
using EnergyTechAudit.PowerAccounting.Web.Resources;
using Microsoft.Scripting.Utils;
using System.Threading.Tasks;
using EnergyTechAudit.PowerAccounting.Common.Helpers;
using EnergyTechAudit.PowerAccounting.Web.Models.WebApi;

namespace EnergyTechAudit.PowerAccounting.Web.Areas.Api.Controllers
{
    [NonBrowserAuthorize
    (        
        PrincipalExtension.RoleNames.Admin,
        PrincipalExtension.RoleNames.ArchiveDownloader, 
        PrincipalExtension.RoleNames.OperAdmin, 
        PrincipalExtension.RoleNames.LeadOperAdmin
    )]
    
    [ErrorLog]
    public class PackageController : ApplicationControllerBase
    {
        private class ActionRequestStatisticInfo
        {
            public long Elapsed { get; set; }

            public long Length { get; set; }

            public string Message { get; set; }

            public SqlParameter[] Parameters { get; set; }
        }

        private readonly ApplicationDatabaseContext _dbContext;

        public PackageController()
        {
            _dbContext = new ApplicationDatabaseContext();
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                if (_dbContext != null)
                {
                    _dbContext.Dispose();
                }
            }

            base.Dispose(disposing);
        }


        [HttpGet, NoScheduleAction]
        public ActionResult ScheduleInfo()
        {
            return GetXmlResponse(
                new[]
                {
                    new SqlParameter(SqlParameterResources.UserName, HttpContext.User.GetUserName())                     
                }, false
            ); 
        }

        [HttpGet]
        public ActionResult MeasurementDeviceArchive(ArchiveRequest archiveRequest, bool responseToFile = false)
        {
            return GetXmlResponse(
                new[]
                {
                    new SqlParameter(SqlParameterResources.UserName, HttpContext.User.GetUserName()), 
                    new SqlParameter(SqlParameterResources.MeasurementDeviceId, archiveRequest.MeasurementDeviceId),
                    new SqlParameter(SqlParameterResources.ChannelId, archiveRequest.ChannelId),
                    new SqlParameter(SqlParameterResources.PeriodBegin, archiveRequest.PeriodBegin),
                    new SqlParameter(SqlParameterResources.PeriodEnd, archiveRequest.PeriodEnd),                    
                    new SqlParameter(SqlParameterResources.PeriodTypeId, archiveRequest.PeriodTypeId),                    
                    new SqlParameter("@withDictionaries", archiveRequest.WithDictionaries)
                }, responseToFile
            ); 
        }

        [HttpGet]                    
        public ActionResult Dictionary(string name, bool responseToFile = false)
        {                      
            return GetXmlResponse(
                new[]
                {
                    new SqlParameter(SqlParameterResources.UserName, HttpContext.User.GetUserName()), 
                    new SqlParameter(SqlParameterResources.Name, name)               
                }, responseToFile
            );
        }

        [HttpGet]
        public ActionResult MeasurementDeviceInfo(bool responseToFile = false)
        {
            return GetXmlResponse
            (
                new[]
                {
                    new SqlParameter(SqlParameterResources.UserName, HttpContext.User.GetUserName())                              
                }, responseToFile
            );
        }

        [HttpGet]
        public ActionResult Schema(bool responseToFile = false)
        {
            return GetXmlResponse(
                new[]
                {
                    new SqlParameter(SqlParameterResources.UserName, HttpContext.User.GetUserName()),                          
                }, responseToFile
            );
        }

        [HttpGet]
        public ActionResult NativeDatabaseStructureExample(int entityId, string entityTypeName, bool responseToFile = false)
        {
            return GetXmlResponse(
                new[]
                {
                    new SqlParameter(SqlParameterResources.UserName, HttpContext.User.GetUserName()),
                    new SqlParameter(SqlParameterResources.EntityId, entityId),
                    new SqlParameter(SqlParameterResources.EntityTypeName, entityTypeName)
                }, responseToFile
            );
        }

        private ActionResult BuildErrorXmlResponse(string actionName, string errorMessage)
        {
            actionName = actionName ?? ControllerContext.RouteData.Values["action"].ToString();

            actionName = actionName.Capitalize();

            var errorResponse = new XElement
                (
                "Error",
                new XElement("DateTime", DateTime.Now),
                new XElement("MethodName", actionName),
                new XElement
                    (
                    "Message",
                    errorMessage
                    )
                );

            return Content
                (
                    errorResponse.ToString(SaveOptions.DisableFormatting),
                    MimeType.TextXml,
                    Encoding.UTF8
                );
        }

        /// <summary>
        /// Проверка доступа по расписанию 
        /// </summary>

        private bool CheckAccessBySchedule()
        {
            var user = _dbContext
                .Set<User>()
                .Include(u => u.ArchiveDownloader)
                .FirstOrDefault(u => u.UserName == UserName);

            _dbContext.Set<ScheduleType>().Load();

            var scheduleItems = _dbContext
                .Set<ArchiveDownloaderLinkScheduleItem>()
                .Include(l => l.ScheduleItem)                
                .Where(l => l.ArchiveDownloaderId == user.Id)
                .Select(l => l.ScheduleItem)
                .ToList();

            return ScheduleItem.CheckSchelude(scheduleItems);            
        }

        private bool CheckAccessByUser()
        {
            var user = _dbContext
                .Set<User>()
                .Include(u => u.ArchiveDownloader)
                .FirstOrDefault(u => u.UserName == UserName);

            return user?.ArchiveDownloader != null;
        }

        private void CollectActionRequestStatistic(ActionRequestStatisticInfo actionRequestStatisticInfo)
        {
            var actionName = ControllerContext.RouteData.Values["action"].ToString().Capitalize();

            var xmlActionStatisticItemInfo =
                new XElement
                    (
                    "ActionStatisticItemInfo",
                    new XElement
                        (
                        "RequestParameters",
                        actionRequestStatisticInfo.Parameters.Select
                            (rp =>
                            {
                                var parameterName = rp.ParameterName
                                    .Substring(1, rp.ParameterName.Length - 1)
                                    .Capitalize();

                                var sqlDbTypeAttr = new XAttribute("SqlDbType", rp.SqlDbType.ToString());
                                return rp.SqlDbType == SqlDbType.UniqueIdentifier 
                                    ? new XElement
                                            (
                                                parameterName, 
                                                rp.Value.ToString().ToUpperInvariant(),
                                                sqlDbTypeAttr
                                            ) 
                                    : new XElement
                                        (
                                            parameterName, 
                                            rp.Value,
                                            sqlDbTypeAttr
                                        );
                            })
                        )
                    );
            
            xmlActionStatisticItemInfo.Add
                (
                    new XElement("ActionParameters",
                        new XElement("PerformanceTime", actionRequestStatisticInfo.Elapsed)
                        )
                );

            if (actionRequestStatisticInfo.Message.IsNotNullOrEmpty())
            {
                xmlActionStatisticItemInfo.Add(new XElement("Message", actionRequestStatisticInfo.Message));
            }

            var user = _dbContext
                .Set<User>()
                .Include(u => u.ArchiveDownloader)
                .FirstOrDefault(u => u.UserName == UserName);

            if (user != null)
            {
                var actionUid =
                    actionRequestStatisticInfo.Parameters.FirstOrDefault(p => p.ParameterName == SqlParameterResources.ActionUid);

                _dbContext.Set<ActionRequestStatisticItem>().Add(
                    new ActionRequestStatisticItem
                    {
                        ArchiveDownloaderId = user.ArchiveDownloader.Id,
                        ActionName = actionName,
                        Time = DateTime.Now,
                        DataSize = actionRequestStatisticInfo.Length,
                        ActionRequestStatisticInfo = xmlActionStatisticItemInfo.ToString(),
                        Uid = (actionUid != null && actionUid.Value != null) ? actionUid.Value.ToString() : null
                    });

                _dbContext.SaveChanges();
            }
        }

       private ActionResult GetXmlResponse(SqlParameter[] parameters, bool responseToFile)
        {
            ActionResult actionResult;

            var watcher = Stopwatch.StartNew();

            var actionName = ControllerContext.RouteData.Values["action"].ToString().Capitalize();
            var spName = string.Format(InternalResources.WebApiSqlQueryTemplate, actionName);

           string msg = null;

           var actionMethodInfo = this.GetType().GetMethod(actionName);

           var bySchedule = !(actionMethodInfo != null && actionMethodInfo.GetCustomAttribute<NoScheduleActionAttribute>() != null);
           
           var accessResolved = false;
 
            if (!CheckAccessByUser())
            {
                msg = MessagesResource.WebApiArchiveDownloaredNotFound;                
            }
            else if (bySchedule && !CheckAccessBySchedule())
            {
                msg = MessagesResource.WebApiDeniedBySchedule ;                
            }
            else
            {
                accessResolved = true;
            }
           
           if (!accessResolved)
           {
               var result = BuildErrorXmlResponse(msg, actionName);

               CollectActionRequestStatistic(new ActionRequestStatisticInfo
               {
                   Length = Encoding.ASCII.GetBytes(((ContentResult) result).Content).LongLength,
                   Parameters = parameters,
                   Elapsed = default(int),
                   Message = msg
               });
               return result;
           }

           var lenght = default(long);
           string xml = null;

            try
            {
                var connectionString = WebConfigurationManager
                    .ConnectionStrings["DatabaseContext"]
                    .ConnectionString;

                using (var connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    using (var sqlCommand = new SqlCommand(spName, connection))
                    {
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.CommandTimeout = 3600;
                        
                        sqlCommand.Parameters.AddRange(parameters);
                        
                        var actionUid = new SqlParameter
                        {
                            ParameterName = SqlParameterResources.ActionUid,
                            Direction = ParameterDirection.Output,
                            SqlDbType = SqlDbType.UniqueIdentifier
                        };

                        sqlCommand.Parameters.Add(actionUid);

                        var xmlReader = sqlCommand.ExecuteXmlReader();

                        xmlReader.Read();

                        xml = xmlReader.ReadOuterXml();
                        lenght = Encoding.ASCII.GetBytes(xml).LongLength;

                        actionResult = Content
                            (
                                xml,
                                MimeType.TextXml,
                                Encoding.UTF8                                
                            );

                        if (responseToFile)
                        {
                            Response.AppendHeader(InternalResources.ContentDisposition, new ContentDisposition
                            {
                                FileName = string.Format("{0} Package ({1:s}).xml",
                                    actionName.Replace("Get", string.Empty),
                                    DateTime.Now),
                                CreationDate = DateTime.Now
                            }.ToString());
                        }
                        parameters = sqlCommand.Parameters.Select(p => (SqlParameter)p).ToArray();
                    }
                }
            }
            catch
            {
                return new HttpStatusCodeResult(HttpStatusCode.InternalServerError);
            }

            watcher.Stop();

            if (xml.IsNotNullOrEmpty() && xml.IndexOf("Error", 0, xml.Length < 128 ? xml.Length : 128, StringComparison.InvariantCulture) != -1)
           {
               var x = XElement.Parse(xml);
               var xElement = x.Element("Message");
               if (xElement != null)
               {
                   msg = xElement.Value;
               }
           }

           CollectActionRequestStatistic(new ActionRequestStatisticInfo
            {
                Length = lenght,
                Elapsed = watcher.ElapsedMilliseconds,
                Parameters = parameters,
                Message = msg
            });
                        
            return actionResult;
        }
      
       public async Task<ActionResult> DoTestActionByActionRequestStatisticItem(int actionRequestStatisticItemId)
       {
           using (var context = new ApplicationDatabaseContext())
           {
               var actionRequestStatisticItem = await context
                   .Set<ActionRequestStatisticItem>()
                   .FindAsync(actionRequestStatisticItemId);

               if (actionRequestStatisticItem != null)
               {
                   Exception exception;

                   try
                   {
                       var xActionStatisticItemInfo =
                           XDocument.Parse(actionRequestStatisticItem.ActionRequestStatisticInfo);

                       var sqlParameters = xActionStatisticItemInfo
                           .Descendants("RequestParameters")
                           .Elements()
                           .Select(rp =>
                           {
                               var sqlDbType =
                                   (SqlDbType)
                                       Enum.Parse(typeof (SqlDbType), rp.Attribute(typeof (SqlDbType).Name).Value);
                               return new SqlParameter
                               {
                                   ParameterName = string.Format("@{0}", rp.Name.ToString().Decapitalize()),
                                   SqlDbType = sqlDbType,
                                   Direction =
                                       sqlDbType != SqlDbType.UniqueIdentifier
                                           ? ParameterDirection.Input
                                           : ParameterDirection.Output,
                                   Value = rp.Value
                               };
                           }
                           ).ToArray();

                       var connection = (SqlConnection) context.Database.Connection;

                       var query = string.Format(InternalResources.WebApiSqlQueryTemplate,
                           actionRequestStatisticItem.ActionName);

                       if (connection.State != ConnectionState.Open)
                       {
                           connection.Open();
                       }

                       using (var sqlCommand = new SqlCommand(query, connection))
                       {
                           sqlCommand.CommandType = CommandType.StoredProcedure;

                           sqlCommand.Parameters.AddRange(sqlParameters);

                           var xmlReader = await sqlCommand.ExecuteXmlReaderAsync();

                           xmlReader.Read();

                           Response.AppendHeader(InternalResources.ContentDisposition, new ContentDisposition
                           {
                               FileName = string.Format
                                   (
                                       "{0}_ActionRequestStatisticItemId_{1}.xml",
                                       actionRequestStatisticItem.ActionName,
                                       actionRequestStatisticItem.Id
                                   ),
                               CreationDate = DateTime.Now
                           }.ToString());

                           return new ContentResult
                           {
                               Content = await xmlReader.ReadOuterXmlAsync(),
                               ContentType = MimeType.TextXml,
                               ContentEncoding = Encoding.UTF8
                           };

                       }
                   }
                   catch (Exception ex)
                   {
                       exception = ex;
                   }

                   return BuildErrorXmlResponse(actionRequestStatisticItem.ActionName, exception.Message);

               }

               return BuildErrorXmlResponse(null, MessagesResource.WepApiActionRequestStatisticItemNotFound);               
           }
       }
    }
}