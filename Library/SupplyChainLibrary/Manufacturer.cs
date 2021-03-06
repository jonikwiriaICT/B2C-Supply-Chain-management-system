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
    public partial class SysAdminModel: _Database 
    {
        public bool CRUDManufacturer(string RecID, string UserTypeID, string FirstName, string Email, string TelephoneNo, string Country, string State, string Address, string StatementType)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("CRUDManufacturer", con);
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
        public DataSet getMessage()
        {
            try
            {
                SqlCommand objCmd = new SqlCommand();
                string sSQL = "select * from tbl_message_log";
                objCmd.CommandText = sSQL;
                return ExecuteDataSet(objCmd);
            }
            catch (Exception ex)
            {
                ErrorMessage += ex.Message;
                return null;
            }
        }
        public DataSet getUserType()
        {
            try
            {
                SqlCommand objCmd = new SqlCommand();
                string sSQL = "select UserTypeID as [Code], user_type as [Desc] from tbl_userType";
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
