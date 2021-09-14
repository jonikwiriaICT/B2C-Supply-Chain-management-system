using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using SupplyChainLibrary;
using System.Configuration;
using System.IO;
using System.Data;
using System.Data.SqlClient;


/// <summary>
/// Summary description for Chat
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
 [System.Web.Script.Services.ScriptService]
public class Chat : System.Web.Services.WebService
{
    public SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["mssqlConnectionString"].ToString());
    SysAdminModel objAdm = new SysAdminModel();
    public  string ProductAmount;
    public Chat()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    //[System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    [WebMethod(EnableSession = true)]
    public string RealTimeData(string text)
    {
        string sText = text.ToLower().ToString();
        string Number = new string(sText .Where(char.IsDigit).ToArray());


        
        if (sText .Contains ("cancel") && sText .Contains(Number))
        {
            KeepRecordwithBot(sText, CancelByOneOrder(Number));
            return CancelByOneOrder(Number);


        }
        if (sText.Contains("check") && sText.Contains(Number))
        {

            if (objAdm.GetShipmentAddress(Number) == true)
            {
                KeepRecordwithBot(sText, objAdm.Message);
                return objAdm.Message;
            };


        }
        if (sText.Contains("thank") )
        {
           

        }
        if (sText.Contains("Bye"))
        {
           

        }
        if (sText.Contains("okey"))
        {
        

        }
        if (sText.Contains("track") && sText.Contains(Number))
        {

            if (objAdm.GetShipmentAddress(Number) == true)
            {
                KeepRecordwithBot(sText, objAdm.Message);
                return objAdm.Message;
            };


        }

        if (sText.Contains("cancel"))
        {
            KeepRecordwithBot(sText, CancelAllOrders(Number));
            return CancelAllOrders(Number);

        }
      
        if (sText.Contains("buy") || sText .Contains ("want") || sText .Contains ("show"))
        {
            KeepRecordwithBot(sText, " This is the product that fits your description" + "<br/>" + objAdm.GetProduct(text));
            return " This is the product that fits your description" + "<br/>" + objAdm.GetProduct(text);

        }
       
       
      
        if (objAdm.GetMessage(text) == true)
        {
            KeepRecordwithBot(sText, objAdm.Message);
            return objAdm.Message;
        }
        return objAdm.ErrorMessage;

    }
    //[System.Web.Services.WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public  string CancelByOneOrder(string text)
    {
        string r = string.Empty;
    
        try
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                con.Open();
                cmd.CommandText = "update tbl_transaction_stock set flag_on=0 where order_id=@orderID AND consumer_id=@uid";
                cmd.Parameters.AddWithValue("@orderID", text );
                cmd.Parameters.AddWithValue("@uid", HttpContext.Current.Session["ConsumerID"].ToString());
                cmd.Connection = con;
                cmd.ExecuteNonQuery();
                con.Close();
                
            }
            using (SqlCommand cmds = new SqlCommand())
            {
                con.Open();
                cmds.CommandText = "update tbl_shipment set flag_on=0 where order_id=@orderID AND consumer_id=@uid";
                cmds.Parameters.AddWithValue("@orderID", text);
                cmds.Parameters.AddWithValue("@uid", HttpContext.Current.Session["ConsumerID"].ToString());
                cmds.Connection = con;
                cmds.ExecuteNonQuery();
                con.Close();

            }
            return "Your order has been cancelled. Our Retailer will contact you soon.";
        }
        catch (SqlException exx)
        {
            string ab = string.Empty;
           
                r = "There is a problem cancelling your order. ";

            
            return r;

        }
        catch (Exception ex)
        {
            return ex.Message;
        }
        finally
        {
            if (con.State == ConnectionState.Open)
                con.Close();

        }


    }
    public void KeepFeedbackMessage(string ClientMessage, double positive, double negative, double neutral, double compound)
    {
        string r = string.Empty;

        try
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                con.Open();
                cmd.CommandText = "insert into tbl_feedbackMessage (Message, positive, negative, neutral, compound) values(@ClientMessage, @positive, @negative, @neutral, @compound)";
                cmd.Parameters.AddWithValue("@ClientMessage", ClientMessage);
                cmd.Parameters.AddWithValue("@positive", positive);
                cmd.Parameters.AddWithValue("@negative", negative);
                cmd.Parameters.AddWithValue("@neutral", neutral);
                cmd.Parameters.AddWithValue("@compound", compound);
                cmd.Connection = con;
                cmd.ExecuteNonQuery();
                con.Close();
            }

        }
        catch (SqlException exx)
        {
            string ab = string.Empty;

            r = "There is a problem cancelling your order. ";




        }
        catch (Exception ex)
        {

        }
        finally
        {
            if (con.State == ConnectionState.Open)
                con.Close();

        }


    }

    public void ScoreMessage(string ClientMessage, double positive)
    {
        string r = string.Empty;

        try
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                con.Open();
                cmd.CommandText = "insert into tbl_score (name, score) values(@ClientMessage, @positive)";
                cmd.Parameters.AddWithValue("@ClientMessage", ClientMessage);
                cmd.Parameters.AddWithValue("@positive", positive);

                cmd.Connection = con;
                cmd.ExecuteNonQuery();
                con.Close();
            }

        }
        catch (SqlException exx)
        {
            string ab = string.Empty;

            r = "There is a problem cancelling your order. ";




        }
        catch (Exception ex)
        {

        }
        finally
        {
            if (con.State == ConnectionState.Open)
                con.Close();

        }


    }

    public void KeepRecordwithBot(string ClientMessage, string botMessage)
    {
        string r = string.Empty;

        try
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                con.Open();
                cmd.CommandText = "insert into tbl_message_log (client_message, bot_message, client_id) values(@ClientMessage, @BotMessage, @uid)";
                cmd.Parameters.AddWithValue("@ClientMessage", ClientMessage );
                cmd.Parameters.AddWithValue("@BotMessage", botMessage);
                cmd.Parameters.AddWithValue("@uid", HttpContext.Current.Session["ConsumerID"].ToString());
                cmd.Connection = con;
                cmd.ExecuteNonQuery();
                con.Close();
            }
            
        }
        catch (SqlException exx)
        {
            string ab = string.Empty;

            r = "There is a problem cancelling your order. ";


           

        }
        catch (Exception ex)
        {
          
        }
        finally
        {
            if (con.State == ConnectionState.Open)
                con.Close();

        }


    }
    public string CancelAllOrders(string text)
    {
        string r = string.Empty;

        try
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                con.Open();
                cmd.CommandText = "update tbl_transaction_stock set flag_on=0 where consumer_id=@uid";
                cmd.Parameters.AddWithValue("@uid", HttpContext.Current.Session["ConsumerID"].ToString());
                cmd.Connection = con;
                cmd.ExecuteNonQuery();
                con.Close();
                
            }
            using (SqlCommand cmds = new SqlCommand())
            {
                con.Open();
                cmds.CommandText = "update tbl_shipment set flag_on=0 where consumer_id=@uid";
                cmds.Parameters.AddWithValue("@uid", HttpContext.Current.Session["ConsumerID"].ToString());
                cmds.Connection = con;
                cmds.ExecuteNonQuery();
                con.Close();

            }
            return "All your order that  has been cancelled. Our Retailer will contact you soon";
        }
        catch (SqlException exx)
        {
            string ab = string.Empty;
            if (exx.Number == 0)
            {
                r = "Order Code does not exist !!!";

            }
            return r;

        }
        catch (Exception ex)
        {
            return ex.Message;
        }
        finally
        {
            if (con.State == ConnectionState.Open)
                con.Close();

        }


    }









    [WebMethod(EnableSession = true)]
    public string GetFeedback(string text)
    {
        string sText = text.ToLower().ToString();
        string Number = new string(sText.Where(char.IsDigit).ToArray());
        
          
        
        if(sText .Contains ("yes") || sText .Contains ("Yes"))
        {
            return "Ok you can still write what you feel about us so as to improve our service.";
        }
       
        if (objAdm.GetSentiment (sText) == true)
        {
            ScoreMessage("Positive", objAdm .sPositiveScore );
            ScoreMessage("Negative", objAdm.sNegativeScore );
            ScoreMessage("Neutral", objAdm.sNeutralScore );
            KeepFeedbackMessage(sText, objAdm .sPositiveScore , objAdm .sNegativeScore , objAdm .sNeutralScore , objAdm .sCompoundScore );
        }
       
        return "Thank you for your time. We appreciate you. Did you want to still continue your review with us?";
    }


    [WebMethod]
    public string ProductFuzzyQuery(string text)
    {
        if (objAdm.GetMessage(text) == true)
        {
            return objAdm.Message;
        }
        return objAdm.ErrorMessage;

    }

}
