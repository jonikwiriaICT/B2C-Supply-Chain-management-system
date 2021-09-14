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
        public bool CRUDBranch(string RecID, string BranchName , string BranchDescription, string ContactPerson, string Country , string State,  string City, string PhoneNo, string Email, string CurrencyID, string StatementType )
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("CRUDBranch", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@RecID", RecID);
            cmd.Parameters.AddWithValue("@BranchName", BranchName);
            cmd.Parameters.AddWithValue("@BranchDescription", BranchDescription);
            cmd.Parameters.AddWithValue("@ContactPerson", ContactPerson);
            cmd.Parameters.AddWithValue("@Country", Country);
            cmd.Parameters.AddWithValue("@State", State);
            cmd.Parameters.AddWithValue("@City", City);
            cmd.Parameters.AddWithValue("@PhoneNo", PhoneNo);
            cmd.Parameters.AddWithValue("@Email", Email);
            cmd.Parameters.AddWithValue("@CurrencyID", CurrencyID);
            cmd.Parameters.AddWithValue("@StatementType", StatementType);
            if (ExecuteNonQuery(cmd) <= 0)
            {
                ErrorMessage = "Unable to process transaction";
                return false;
            }
            ErrorMessage = "Record executed successfully .";
            return true;
        }

        public DataSet getCurrencyID()
        {
            try
            {
                SqlCommand objCmd = new SqlCommand();
                string sSQL = "select currency_id as [Code], currency_code + ':  '  + currency_name as [Desc]  from tbl_currency";
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
