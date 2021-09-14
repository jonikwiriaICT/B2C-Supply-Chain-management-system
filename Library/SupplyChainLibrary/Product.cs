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
        public bool CRUDProduct(string RecID , string ProductName , string UnitTypeID, string ProductTypeID, string BuyingPrice, string SellingPrice, string ProductProfile, string ManufacturerID, string ProductDescription, string StatementType)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("CRUDProduct", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@RecID", RecID);
            cmd.Parameters.AddWithValue("@ProductName", ProductName);
            cmd.Parameters.AddWithValue("@UnitTypeID", UnitTypeID);
            cmd.Parameters.AddWithValue("@ProductTypeID", ProductTypeID);
            cmd.Parameters.AddWithValue("@BuyingPrice", BuyingPrice);
            cmd.Parameters.AddWithValue("@SellingPrice", SellingPrice);
            cmd.Parameters.AddWithValue("@ProductProfile", ProductProfile);
            cmd.Parameters.AddWithValue("@ManufacturerID", ManufacturerID);
            cmd.Parameters.AddWithValue("@ProductDescription", ProductDescription);
            cmd.Parameters.AddWithValue("@StatementType", StatementType);
            if (ExecuteNonQuery(cmd) <= 0)
            {
                ErrorMessage = "Unable to process transaction";
                return false;
            }
            ErrorMessage = "Record executed successfully .";
            return true;
        }
        public DataSet getProductDetails(string ProductID)
        {
            try
            {
                SqlCommand objCmd = new SqlCommand();
                string sSQL = "select * from tbl_product where product_id='" + ProductID + "'";
                objCmd.CommandText = sSQL;
                return ExecuteDataSet(objCmd);
            }
            catch (Exception ex)
            {
                ErrorMessage += ex.Message;
                return null;
            }
        }
        public DataSet getUnitType()
        {
            try
            {
                SqlCommand objCmd = new SqlCommand();
                string sSQL = "select rec_id as [Code], unit_type as [Desc] from tbl_unittype";
                objCmd.CommandText = sSQL;
                return ExecuteDataSet(objCmd);
            }
            catch (Exception ex)
            {
                ErrorMessage += ex.Message;
                return null;
            }
        }
        public DataSet getProductType()
        {
            try
            {
                SqlCommand objCmd = new SqlCommand();
                string sSQL = "select rec_id as [Code], product_type as [Desc] from tbl_productType";
                objCmd.CommandText = sSQL;
                return ExecuteDataSet(objCmd);
            }
            catch (Exception ex)
            {
                ErrorMessage += ex.Message;
                return null;
            }
        }
        public DataSet getManufacturerID()
        {
            try
            {
                SqlCommand objCmd = new SqlCommand();
                string sSQL = "SELECT rec_id as [Code], first_name as [Desc] from tbl_manufacturer";
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
