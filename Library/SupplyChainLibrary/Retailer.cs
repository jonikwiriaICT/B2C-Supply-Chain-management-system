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
        public string Email = string.Empty;
        public string telephone_no = string.Empty;
        public bool getRetailerEmail(string RecID)
        {
            try
            {
                string sPasswordDB = string.Empty;
                DataSet ds = new DataSet();
                string sSQL = "SELECT * FROM tbl_retailer WHERE rec_id=@RecID ";
                SqlCommand objCmd = new SqlCommand();
                objCmd.Parameters.Clear();
                objCmd.Parameters.AddWithValue("@RecID", RecID);
                objCmd.CommandText = sSQL;
                ds = ExecuteDataSet(objCmd);
                if (ds.Tables[0].Rows.Count <= 0)
                {
                    ErrorMessage = "Invalid User. Contact Administrator.";
                    return false;
                }
           
               
                Email  = ds.Tables[0].Rows[0]["email"].ToString();
                telephone_no  = ds.Tables[0].Rows[0]["telephone_no"].ToString();

                return true;
            }
            catch (Exception ex)
            {
                ErrorMessage = "No Login Connection.";
                return false;
            }
        }
        public bool CRUDRetailer(string RecID, string UserTypeID, string FirstName, string Email, string TelephoneNo, string Country, string State, string Address, string StatementType)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("CRUDRetailer", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@RecID", RecID);
            cmd.Parameters.AddWithValue("@UserTypeID", UserTypeID);
            cmd.Parameters.AddWithValue("@FirstName", FirstName);
            cmd.Parameters.AddWithValue("@Email", Email);
            cmd.Parameters.AddWithValue("@TelephoneNo", TelephoneNo);
            cmd.Parameters.AddWithValue("@Country", Country);
            cmd.Parameters.AddWithValue("@State", State);
            cmd.Parameters.AddWithValue("@Address", Address);
            cmd.Parameters.AddWithValue("@StatementType", StatementType);
            if (ExecuteNonQuery(cmd) <= 0)
            {
                ErrorMessage = "Unable to process transaction";
                return false;
            }
            ErrorMessage = "Record executed successfully .";
            return true;
        }
        public DataSet getRetailerID()
        {
            try
            {
                SqlCommand objCmd = new SqlCommand();
                string sSQL = "select manufacturer_id as [Code], first_name as [Desc] from tbl_retailer";
                objCmd.CommandText = sSQL;
                return ExecuteDataSet(objCmd);
            }
            catch (Exception ex)
            {
                ErrorMessage += ex.Message;
                return null;
            }
        }

    }
}
