using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using _Foundation;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace SupplyChainLibrary
{
    public partial class SysAdminModel : _Database
    {
        public bool changePassword(string Username, string NewPassword)
        {
            try
            {
                

                string sSQL = "update tbl_usermanagement set user_password='" + NewPassword + "' where username='" +  Username   + "'";
                SqlCommand objCmd = new SqlCommand();
                objCmd.CommandText = sSQL;
                if (ExecuteNonQuery(objCmd) <= 0)
                {
                    ErrorMessage = "Unable to update transaction";
                    return false;
                }
                ErrorMessage = "Password Changed successfully .";
                return true;
            }
            catch (Exception ex)
            {
                ErrorMessage = ex.ToString();
                return false;
            }
        }
    }
}
