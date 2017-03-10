using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using System.Collections.ObjectModel;
using System.Xml;
using System.Net;
using System.Web;
using System.Web.UI.WebControls;
using System.IO;

namespace SubmitDeploymentToNewRelic
{
    public partial class Default : System.Web.UI.Page
    {

        XmlDocument Clients = new XmlDocument();

        protected void Page_Load(object sender, EventArgs e)
        {
            lblError.ForeColor = System.Drawing.Color.Red;
            lblSuccess.ForeColor = System.Drawing.Color.Green;

            Clients.Load(Server.MapPath("~/App_Data/Clients.xml"));

            if (!Page.IsPostBack) // to avoid reloading your control on postback
            {
                XmlNodeList clientList = Clients.SelectNodes("/clients/client/Name");
                foreach (XmlNode Name in clientList)
                {
                    DropDownList1.Items.Add(Name.InnerText);
                }
            }
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            int selectedIndex = DropDownList1.SelectedIndex;

            XmlNodeList nodelist = Clients.SelectNodes("/clients/client");
            XmlNode xmlnode = nodelist.Item(selectedIndex);

            txtNewRelicApiKey.Text = xmlnode.SelectSingleNode("apiKey").InnerText;
            txtNewRelicAppName.Text = xmlnode.SelectSingleNode("applicationId").InnerText;

        }

        protected void btnSubmitNewRelicDeployment_Click(object sender, EventArgs e)
        {
            string apiUrl = "https://s2events.azure-automation.net/webhooks?token=iPgtnBmbB1n2MQJ5cwqzzgztOcPtvyBpNmySDFWNVaQ%3d";

            try
            {
                string apiKey = txtNewRelicApiKey.Text;
                string applicationId = txtNewRelicAppName.Text;
                string revision = txtNewRelicDeploymentRevision.Text;
                string user = txtNewRelicUser.Text;

                var httpWebRequest = (HttpWebRequest)WebRequest.Create(apiUrl);
                httpWebRequest.ContentType = "application/json";
                httpWebRequest.Method = "POST";

                using (var streamWriter = new StreamWriter(httpWebRequest.GetRequestStream()))
                {
                    string json = @"{'apiKey':'" + apiKey + "','applicationId':'" + applicationId + "','revision':'" + revision + "','user':'" + user + "'}";

                    streamWriter.Write(json);
                    streamWriter.Flush();
                    streamWriter.Close();
                }

                var httpResponse = (HttpWebResponse)httpWebRequest.GetResponse();
                using (var streamReader = new StreamReader(httpResponse.GetResponseStream()))
                {
                    var result = streamReader.ReadToEnd();
                }

                lblSuccess.Text = "Succesfully submitted deployment to NewRelic!";
            }
            catch (Exception)
            {

                Exception ex = new Exception();
                lblError.Text = ex.Message.ToString();
            }
            finally
            {
                
            }
        }
    }
}