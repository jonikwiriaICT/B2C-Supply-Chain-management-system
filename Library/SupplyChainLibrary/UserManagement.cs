using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using _Foundation;
using System.Data.SqlClient;
using System.Data;

namespace SupplyChainLibrary
{
    public partial class   SysAdminModel: _Database 
    {
        public bool CRUDUserManagement( string RecID, string UserName, string UserPassword, string Manufacturer, string Retailer, string Consumer, string Administrator, string Courier, string ProfilePic, string UserTypeID, string StatementType)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("CRUDUserManagement", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@RecID", RecID);
            cmd.Parameters.AddWithValue("@UserName", UserName);
            cmd.Parameters.AddWithValue("@UserPassword", UserPassword);
            cmd.Parameters.AddWithValue("@Manufacturer", Manufacturer);
            cmd.Parameters.AddWithValue("@Retailer", Retailer);
            cmd.Parameters.AddWithValue("@Consumer", Consumer);
            cmd.Parameters.AddWithValue("@Administrator", Administrator);
            cmd.Parameters.AddWithValue("@Courier", Courier );
            cmd.Parameters.AddWithValue("@ProfilePic", ProfilePic);
            cmd.Parameters.AddWithValue("@UserTypeID", UserTypeID);
            cmd.Parameters.AddWithValue("@StatementType", StatementType);
            if (ExecuteNonQuery(cmd) <= 0)
            {
                ErrorMessage = "Unable to process transaction";
                return false;
            }
            ErrorMessage = "Record executed successfully .";
            return true;
        }
    }
}
