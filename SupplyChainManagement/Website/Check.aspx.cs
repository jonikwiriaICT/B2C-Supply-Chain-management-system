using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SupplyChainLibrary;
using System.Data.SqlClient;
using System.Configuration;

public partial class Check : System.Web.UI.Page
{
    SysAdminModel objAdm = new SysAdminModel();
    public string CustomerEmail = string.Empty;
    public string CustomerPhoneNumber = string.Empty;
    public string CustomerName = string.Empty;
    public string CustomerTotal = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlTransaction sqtr = null;
        SqlConnection con = new SqlConnection();
        con.ConnectionString = ConfigurationManager.ConnectionStrings["mssqlConnectionString"].ConnectionString;
        con.Open();
        sqtr = con.BeginTransaction();
        int orderNum = 0;
        string sql = "SELECT MAX(order_id) AS MAXORDNO FROM tbl_order";
        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.Transaction = sqtr;
        object obj = cmd.ExecuteScalar();
        if (obj == null)
        {
            orderNum = 1;
        }
        else
        {
            if (obj.ToString() != "")
                orderNum = int.Parse(obj.ToString()) + 1;
            else
                orderNum = 1;
        }
        Session["order"] = orderNum;

        CustomerEmail = Session["Email"].ToString();
        CustomerPhoneNumber = Session["Telephone"].ToString();
        CustomerName = Session["RetailerID"].ToString();
        CustomerTotal = HttpContext.Current.Session["total"].ToString();
        Response.Write("<script src='floating-whatsapp-master/jquery-3.3.1.min.js'></script>");
        Response.Write("<script src='floating-whatsapp-master/jquery-3.3.1.min.js'></script>");
        Response.Write("<script type='text/javascript' src='https://sdk.monnify.com/plugin/monnify.js'></script>");
        Response.Write("<script>");
        Response.Write("$(document).ready(function() {");
        Response.Write("payWithMonnify();");
        Response.Write("});");
        Response.Write("</script>");
        Response.Write("<script type ='text/javascript'>");
        Response.Write("function payWithMonnify() {");
        Response.Write("MonnifySDK.initialize({");
        Response.Write("amount: '" + CustomerTotal + "',");
        Response.Write("currency: 'NGN',");
        Response.Write("reference: '' + Math.floor((Math.random() * 1000000000) + 1),");
        Response.Write("customerName: '" + CustomerName + "',");
        Response.Write("customerEmail: '" + CustomerEmail + "',");
        Response.Write("customerMobileNumber: '" + CustomerEmail + "',");
        Response.Write("apiKey: 'MK_TEST_W7ZDX63292',");
        Response.Write("contractCode: '8326884197',");
        Response.Write("paymentDescription: 'Test Pay',");
        Response.Write("isTestMode: true,");
        Response.Write("metadata:");
        Response.Write("{");
        Response.Write("'name': 'Sini Isaac',");
        Response.Write("'age': 129");
        Response.Write("},");
        Response.Write("paymentMethods: ['CARD', 'ACCOUNT_TRANSFER'],");
        //incomeSplitConfig:  [
        //    {
        //        'subAccountCode': 'MFY_SUB_342113621921',
        //        'feePercentage': 50,
        //        'splitAmount': 1900,
        //        'feeBearer': true
        //    },
        //    {
        //        'subAccountCode': 'MFY_SUB_342113621922',
        //        'feePercentage': 50,
        //        'splitAmount': 2100,
        //        'feeBearer': true
        //    }
        //],
        Response.Write("onComplete: function(response) {");
        //Implement what happens when transaction is completed.
        Response.Write("window.location.replace('Check-Out');");
        Response.Write("},");
        Response.Write("onClose: function(data) {");
        //Implement what should happen when the modal is closed here
        Response.Write("window.location.replace('Payment-Failure');");
        Response.Write("}");
        Response.Write("});");
        Response.Write("}");
        Response.Write("</script>");
    }

}