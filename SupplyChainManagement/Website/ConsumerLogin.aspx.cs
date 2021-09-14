using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SupplyChainLibrary;

public partial class ConsumerLogin : System.Web.UI.Page
{
    SysAdminModel objAdm = new SysAdminModel();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!this.IsPostBack)
            {
                
            }
        }
        catch (Exception ex)
        {

        }
    }
    protected void Page_UnLoad(object sender, EventArgs e)
    {
        try
        {
            objAdm.CloseConnection();
        }
        catch (Exception ex)
        {

        }
    }
    private void DisplaySuccess(String sMessage)
    {
        try
        {
            (this.Master as ClientMaster ).DisplayMessage(sMessage, ClientMaster.MsgType.Success);
        }
        catch (Exception ex)
        {
            Session["msg"] = ex.Message.ToString();
            Response.Redirect("~/en");
        }
    }
    private void DisplayError(String sMessage)
    {
        try
        {
            (this.Master as ClientMaster).DisplayMessage(sMessage, ClientMaster.MsgType.Error);
        }
        catch (Exception ex)
        {
            Session["msg"] = ex.Message.ToString();
            Response.Redirect("~/en");
        }
    }

    private void DisplayWarning(String sMessage)
    {
        try
        {
            (this.Master as ClientMaster).DisplayMessage(sMessage, ClientMaster.MsgType.Warning);
        }
        catch (Exception ex)
        {
            Session["msg"] = ex.Message.ToString();
            Response.Redirect("~/en");
        }
    }
    protected void Page_Init(object sender, EventArgs e)
    {

    }
    protected void ChangePasswordClicked(object sender, EventArgs e)
    {
        try
        {
            if (string.IsNullOrEmpty(username.Text) || string.IsNullOrWhiteSpace(username.Text))
            {
                DisplayError("Please enter your email address.");
            }
            if (string.IsNullOrWhiteSpace(PhoneNumber .Text) || string.IsNullOrEmpty(PhoneNumber.Text))
            {
                DisplayError("Please enter your New Password.");
            }
            
            else
            {
                if(objAdm .getConsumerProfile(username.Text , PhoneNumber .Text ) == true)
                {
                    Session["consumer"] = objAdm .ConsumerID;
                    Session["users"] = objAdm.ConsumerID;                   
                    Session["ConsumerName"] = objAdm.ConsumerName;
                    Session["ConsumerPhoneNumber"] = objAdm.ConsumerPhoneNumber;
                    Session["ConsumerEmail"] = objAdm.ConsumerEmail;
                    Session["ConsumerCreatedDate"] = objAdm.ConsumerCreatedDate ;
                    Session["ConsumerID"] = objAdm.ConsumerID ;
                    Response.Redirect("Chat-Bot?ID=" + Session["consumer"].ToString());
                }
            }
        }
        catch (Exception ex)
        {

        }
    }
}