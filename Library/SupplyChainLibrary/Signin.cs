using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using _Foundation;
using System.Data;
using System.Data.SqlClient;

namespace SupplyChainLibrary
{
    public partial class SysAdminModel : _Database
    {
        public string Username = string.Empty;
        public string UserPassword = string.Empty;
        public string AdministratorID = string.Empty;
        public string ManufacturerID = string.Empty;
        public string RetailerID = string.Empty;
        public string Administrator = string.Empty;
        public string Manufacturer = string.Empty;
        public string Retailer = string.Empty;
        public string ProfilePic = string.Empty;
        public string UserType = string.Empty;
        public string CreatedDate = string.Empty;
        public string Courier = string.Empty;
        public string ConsumerEmail = string.Empty;
        public string ConsumerCreatedDate = string.Empty;
        public string ConsumerName = string.Empty;
        public string ConsumerPhoneNumber = string.Empty;
        public string ConsumerID = string.Empty;
        public string CourierID = string.Empty;
        public int flag_on;
        public bool getClientProfile(string username, string sPassword)
        {
            try
            {
                string sPasswordDB = string.Empty;
                DataSet ds = new DataSet();
                string sSQL = "SELECT * FROM qry_usermanagement WHERE [username]=@username ";
                SqlCommand objCmd = new SqlCommand();
                objCmd.Parameters.Clear();
                objCmd.Parameters.AddWithValue("@username", username);
                objCmd.CommandText = sSQL;
                ds = ExecuteDataSet(objCmd);
                if (ds.Tables[0].Rows.Count <= 0)
                {
                    ErrorMessage = "Invalid User. Contact Administrator.";
                    return false;
                }
                sPasswordDB =ds.Tables[0].Rows[0]["Password"].ToString();
                if (sPasswordDB.Trim() == string.Empty)
                {
                    ErrorMessage = "Password Not found in the database.";
                }
                else
                {
                    sPasswordDB = Decrypt(sPasswordDB);
                    if (sPassword != sPasswordDB)
                    {
                        ErrorMessage = "Invalid password.";
                        return false;
                    }
                }
                UserPassword  = sPasswordDB;
                Username = ds.Tables[0].Rows[0]["username"].ToString();
                AdministratorID  = ds.Tables[0].Rows[0]["AdministratorID"].ToString();
                ManufacturerID  = ds.Tables[0].Rows[0]["ManufacturerID"].ToString();
                RetailerID   = ds.Tables[0].Rows[0]["RetailerID"].ToString();
                Administrator  = ds.Tables[0].Rows[0]["Administrator"].ToString();
                Manufacturer  = ds.Tables[0].Rows[0]["Manufacturer"].ToString();
                Retailer  = ds.Tables[0].Rows[0]["Retailer"].ToString();
                UserType  = ds.Tables[0].Rows[0]["UserType"].ToString();
                ProfilePic  = ds.Tables[0].Rows[0]["ProfilePic"].ToString();
                CreatedDate  = ds.Tables[0].Rows[0]["CreatedDate"].ToString();
                Courier = ds.Tables[0].Rows[0]["Courier"].ToString();
                CourierID = ds.Tables[0].Rows[0]["CourierID"].ToString();
                return true;
            }
            catch (Exception ex)
            {
                ErrorMessage = "No Login Connection.";
                return false;
            }
        }

        public bool ConfirmRetailCancel(string RecID)
        {
            try
            {

                DataSet ds = new DataSet();
                string sSQL = "SELECT * FROM tbl_order WHERE rec_id=@RecID ";
                SqlCommand objCmd = new SqlCommand();
                objCmd.Parameters.Clear();
                objCmd.Parameters.AddWithValue("@RecID", RecID );
                objCmd.CommandText = sSQL;
                ds = ExecuteDataSet(objCmd);
                if (ds.Tables[0].Rows.Count <= 0)
                {
                    ErrorMessage = "Sorry Error occurred.";
                    return false;
                }
                flag_on  =int.Parse ( ds.Tables[0].Rows[0]["flag_on"].ToString());
                if (flag_on > 2)
                {
                    ErrorMessage = "Sorry you cannot cancel this product order.";
                    return false;
                }
                if(CancelRetailerOrder(RecID, "tbl_order") == true)
                {
                    ErrorMessage = "Order has been cancelled successfully.";
                    return true;
                }
               

                return true;
            }
            catch (Exception ex)
            {
                ErrorMessage = "No Login Connection.";
                return false;
            }
        }



        public bool getConsumerProfile(string username, string sPassword)
        {
            try
            {
               
                DataSet ds = new DataSet();
                string sSQL = "SELECT * FROM tbl_consumer WHERE [email]=@username ";
                SqlCommand objCmd = new SqlCommand();
                objCmd.Parameters.Clear();
                objCmd.Parameters.AddWithValue("@username", username);
                objCmd.CommandText = sSQL;
                ds = ExecuteDataSet(objCmd);
                if (ds.Tables[0].Rows.Count <= 0)
                {
                    ErrorMessage = "Invalid User. Contact Administrator.";
                    return false;
                }
                ConsumerPhoneNumber = ds.Tables[0].Rows[0]["telephone_no"].ToString();
                if (ConsumerPhoneNumber.Trim() == string.Empty)
                {
                    ErrorMessage = "Password Not found in the database.";
                }
                else
                {
                  
                    if (sPassword != ConsumerPhoneNumber)
                    {
                        ErrorMessage = "Invalid password.";
                        return false;
                    }
                }
                ConsumerPhoneNumber  = ds.Tables[0].Rows[0]["telephone_no"].ToString();
                ConsumerEmail = ds.Tables[0].Rows[0]["email"].ToString();
                ConsumerName=  ds.Tables[0].Rows[0]["first_name"].ToString();
                ConsumerCreatedDate = ds.Tables[0].Rows[0]["created_date"].ToString();
                ConsumerID = ds.Tables[0].Rows[0]["rec_id"].ToString();

                return true;
            }
            catch (Exception ex)
            {
                ErrorMessage = "No Login Connection.";
                return false;
            }
        }
    }
}