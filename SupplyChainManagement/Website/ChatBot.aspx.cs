using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SupplyChainLibrary;
using System.Data;

public partial class ChatBot : System.Web.UI.Page
{
    SysAdminModel objAdm = new SysAdminModel();
    public string ConsumerName = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
           if(!this.IsPostBack)
            {
                if (Request.QueryString["ID"] == "0")
                {
                    Response.Redirect("Consumer-Login");
                }
                else
                {
                
                    ConsumerName = "Welcome to Sini B2C Electronic Supply Chain Management System." + "  " + Session["ConsumerName"] + "," + " " + "Please after our conversation, do not forget to give us your feedback on how you feel about our service. This will enable my developer to make me more intelligent. Click the red button at the top right corner to write your feedback. Thank you. So, How can i help you?";
                }
            }
        }
        catch(Exception ex)
        {

        }
    }

    protected void NavigateClicked(object sender, EventArgs e)
    {
        try
        {
            if(sender.Equals(lnkSessChatHistory))
            {
                Response.Redirect("Chat-History");
            }
            if(sender.Equals(lnkGiveFeedback))
            {
                Response.Redirect("Feedback");
            }
        }
        catch(Exception ex)
        {

        }
    }
    private void getMessageLog()
    {
        try
        {
            DataSet ds = objAdm.getMessage();
            dtMessageLog .DataSource = ds;

            dtMessageLog.DataBind();
        }
        catch (Exception ex)
        {

        }
    }
    protected void SignIn(object sender, EventArgs e)
    {
        try
        {
            
            Response.Redirect("Index");
        }
        catch(Exception ex)
        {

        }
    }
}