using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using _Foundation;
using System.Data.SqlClient;
using System.Configuration;
using System.Security.Cryptography;
using System.IO;
using System.Data;

namespace SupplyChainLibrary
{
    public partial class SysAdminModel: _Database 
    {
        public int pageSize = 10;
        public int _TotalRowCount = 0;
        public string connectionstring = ConfigurationManager.ConnectionStrings["mssqlConnectionString"].ToString();
        public SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["mssqlConnectionString"].ToString());

        public DataTable PopulateViewCart(string sParamaterProcedures)
        {

            DataTable ds = new DataTable();
            con.Open();
            SqlCommand cmd = new SqlCommand(sParamaterProcedures, con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(ds);
            con.Close();
            return ds;
        }
        public DataTable PopulateData(int currentPage, string sParameterProcedure)
        {
            DataTable ds = new DataTable();
            con.Open();
            SqlCommand cmd = new SqlCommand(sParameterProcedure, con);
            cmd.CommandType = CommandType.StoredProcedure;
            int startRowNumber = ((currentPage - 1) * pageSize) + 1;
            cmd.Parameters.AddWithValue("@StartIndex", startRowNumber);
            cmd.Parameters.AddWithValue("@PageSize", pageSize);
            SqlParameter parTotalCount = new SqlParameter("@TotalCount", SqlDbType.Int);
            parTotalCount.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(parTotalCount);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(ds);
            _TotalRowCount = Convert.ToInt32(parTotalCount.Value);
            con.Close();
            return ds;
        }
        public DataTable PopulateDatas(int currentPage, string sParameterProcedure, int RetailerID, int FlagOn)
        {
            DataTable ds = new DataTable();
            con.Open();
            SqlCommand cmd = new SqlCommand(sParameterProcedure, con);
            cmd.CommandType = CommandType.StoredProcedure;
            int startRowNumber = ((currentPage - 1) * pageSize) + 1;
            cmd.Parameters.AddWithValue("@StartIndex", startRowNumber);
            cmd.Parameters.AddWithValue("@PageSize", pageSize);
            cmd.Parameters.AddWithValue("@RetailerID", RetailerID);
            cmd.Parameters.AddWithValue("@FlagOn", FlagOn);
            SqlParameter parTotalCount = new SqlParameter("@TotalCount", SqlDbType.Int);
            parTotalCount.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(parTotalCount);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(ds);
            _TotalRowCount = Convert.ToInt32(parTotalCount.Value);
            con.Close();
            return ds;
        }

        public DataTable PopulateData(int currentPage, string sParameterProcedure, int CourierID, int FlagOn)
        {
            DataTable ds = new DataTable();
            con.Open();
            SqlCommand cmd = new SqlCommand(sParameterProcedure, con);
            cmd.CommandType = CommandType.StoredProcedure;
            int startRowNumber = ((currentPage - 1) * pageSize) + 1;
            cmd.Parameters.AddWithValue("@StartIndex", startRowNumber);
            cmd.Parameters.AddWithValue("@PageSize", pageSize);
            cmd.Parameters.AddWithValue("@CourierID", CourierID );
            cmd.Parameters.AddWithValue("@FlagOn", FlagOn );
            SqlParameter parTotalCount = new SqlParameter("@TotalCount", SqlDbType.Int);
            parTotalCount.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(parTotalCount);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(ds);
            _TotalRowCount = Convert.ToInt32(parTotalCount.Value);
            con.Close();
            return ds;
        }
        public DataTable PopulateDataConsumer(int currentPage, string sParameterProcedure, int Number)
        {
            DataTable ds = new DataTable();
            con.Open();
            SqlCommand cmd = new SqlCommand(sParameterProcedure, con);
            cmd.CommandType = CommandType.StoredProcedure;
            int startRowNumber = ((currentPage - 1) * pageSize) + 1;
            cmd.Parameters.AddWithValue("@StartIndex", startRowNumber);
            cmd.Parameters.AddWithValue("@PageSize", pageSize);
            cmd.Parameters.AddWithValue("@Number", Number);
            SqlParameter parTotalCount = new SqlParameter("@TotalCount", SqlDbType.Int);
            parTotalCount.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(parTotalCount);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(ds);
            _TotalRowCount = Convert.ToInt32(parTotalCount.Value);
            con.Close();
            return ds;
        }

        public DataTable PopulateDataReport(int currentPage, string sParameterProcedure, int Search)
        {
            DataTable ds = new DataTable();
            con.Open();
            SqlCommand cmd = new SqlCommand(sParameterProcedure, con);
            cmd.CommandType = CommandType.StoredProcedure;
            int startRowNumber = ((currentPage - 1) * pageSize) + 1;
            cmd.Parameters.AddWithValue("@StartIndex", startRowNumber);
            cmd.Parameters.AddWithValue("@PageSize", pageSize);
            cmd.Parameters.AddWithValue("@Search", Search);
            SqlParameter parTotalCount = new SqlParameter("@TotalCount", SqlDbType.Int);
            parTotalCount.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(parTotalCount);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(ds);
            _TotalRowCount = Convert.ToInt32(parTotalCount.Value);
            con.Close();
            return ds;
        }

        public DataTable PopulateData(int currentPage, string sParameterProcedure, int  Search)
        {
            DataTable ds = new DataTable();
            con.Open();
            SqlCommand cmd = new SqlCommand(sParameterProcedure, con);
            cmd.CommandType = CommandType.StoredProcedure;
            int startRowNumber = ((currentPage - 1) * pageSize) + 1;
            cmd.Parameters.AddWithValue("@StartIndex", startRowNumber);
            cmd.Parameters.AddWithValue("@PageSize", pageSize);
            cmd.Parameters.AddWithValue("@RetailerID", Search);
            SqlParameter parTotalCount = new SqlParameter("@TotalCount", SqlDbType.Int);
            parTotalCount.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(parTotalCount);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(ds);
            _TotalRowCount = Convert.ToInt32(parTotalCount.Value);
            con.Close();
            return ds;
        }
        public bool DeleteRecord(string rec_id, string tbl_name)
        {
            try
            {
                string sSQL = "DELETE FROM  " + tbl_name + "  WHERE  rec_id=@rec_id";
                SqlCommand objCmd = new SqlCommand();
                objCmd.CommandText = sSQL;
                objCmd.Parameters.Clear();
                objCmd.Parameters.AddWithValue("@rec_id", rec_id);
                if (ExecuteNonQuery(objCmd) <= 0)
                {
                    ErrorMessage = "Unable to delete transaction";
                    return false;
                }
                ErrorMessage = "Record successfully deleted.";
                return true;
            }
            catch (Exception ex)
            {
                ErrorMessage = ex.ToString();
                return false;
            }
        }


        public bool CancelRetailerOrder(string rec_id, string tbl_name)
        {
            try
            {
                string sSQL = "update  " + tbl_name + " set flag_on=0  WHERE  rec_id=@rec_id";
                SqlCommand objCmd = new SqlCommand();
                objCmd.CommandText = sSQL;
                objCmd.Parameters.Clear();
                objCmd.Parameters.AddWithValue("@rec_id", rec_id);
                if (ExecuteNonQuery(objCmd) <= 0)
                {
                    ErrorMessage = "Unable to delete transaction";
                    return false;
                }
                ErrorMessage = "Record successfully deleted.";
                return true;
            }
            catch (Exception ex)
            {
                ErrorMessage = ex.ToString();
                return false;
            }
        }
        public bool DeleteMessageLog(string rec_id, string tbl_name)
        {
            try
            {
                string sSQL = "DELETE FROM  " + tbl_name + "  WHERE  client_id=@rec_id";
                SqlCommand objCmd = new SqlCommand();
                objCmd.CommandText = sSQL;
                objCmd.Parameters.Clear();
                objCmd.Parameters.AddWithValue("@rec_id", rec_id);
                if (ExecuteNonQuery(objCmd) <= 0)
                {
                    ErrorMessage = "Unable to delete transaction";
                    return false;
                }
                ErrorMessage = "Record successfully deleted.";
                return true;
            }
            catch (Exception ex)
            {
                ErrorMessage = ex.ToString();
                return false;
            }
        }
        public string UpdateCancelOrder(string text)
        {
           
                string sSQL = "update tbl_transaction_stock set flag_on=0 where order_id ='" + text + "'";
                SqlCommand objCmd = new SqlCommand();
                objCmd.CommandText = sSQL;
                objCmd.Parameters.Clear();
                if (ExecuteNonQuery(objCmd) <= 0)
                {
                return "success";
                }
                return "error";
        }
       
        public string Encrypt(string clearText)
        {
            string EncryptionKey = "5475595ghfjfkldgkks64849404bhcmjhfbgfdkd";
            byte[] clearBytes = Encoding.Unicode.GetBytes(clearText);
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                encryptor.Key = pdb.GetBytes(32);
                encryptor.IV = pdb.GetBytes(16);
                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(), CryptoStreamMode.Write))
                    {
                        cs.Write(clearBytes, 0, clearBytes.Length);
                        cs.Close();
                    }
                    clearText = Convert.ToBase64String(ms.ToArray());
                }
            }
            return clearText;
        }

        public string Decrypt(string cipherText)
        {
            string EncryptionKey = "5475595ghfjfkldgkks64849404bhcmjhfbgfdkd";
            byte[] cipherBytes = Convert.FromBase64String(cipherText);
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                encryptor.Key = pdb.GetBytes(32);
                encryptor.IV = pdb.GetBytes(16);
                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateDecryptor(), CryptoStreamMode.Write))
                    {
                        cs.Write(cipherBytes, 0, cipherBytes.Length);
                        cs.Close();
                    }
                    cipherText = Encoding.Unicode.GetString(ms.ToArray());
                }
            }
            return cipherText;
        }
    }
}
