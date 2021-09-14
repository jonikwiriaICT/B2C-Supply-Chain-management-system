<%@ Application Language="C#" %>
<%@ Import Namespace="System.Web.Routing" %>

<script RunAt="server">

    static void RegisterRoutes(RouteCollection routes)
    {
        //first param is unique, second param is the expected url, thrid param is the actual file/page
        //general root menu
        routes.MapPageRoute("rtencf", "en", "~/Error.aspx");
        routes.MapPageRoute("rten", "error", "~/Default.aspx");
        routes.MapPageRoute("rtIndex", "Index", "~/Default.aspx");
        routes.MapPageRoute("rtHome", "Home", "~/Default.aspx");
        routes.MapPageRoute("rtForgetPassword", "Forget-Password", "~/ForgetPassword.aspx");
        routes.MapPageRoute("rtRegister", "Register", "~/Register.aspx");
        routes.MapPageRoute("rtDashboard", "Dashboard", "~/Dashboard.aspx");
        routes.MapPageRoute("rtSCM", "SCM", "~/Signin.aspx");
        routes.MapPageRoute("rtChangePassword", "Change-Password", "~/ChangePassword.aspx");

        ;
        //References
        routes.MapPageRoute("rtCurrency", "Currency", "~/Currency.aspx");
        routes.MapPageRoute("rtBranch", "Branch", "~/Branch.aspx");
        routes.MapPageRoute("rtRoleType", "Role-Type", "~/RoleType.aspx");
        routes.MapPageRoute("rtUserManagement", "User-Management", "~/UserManagement.aspx");

        //Inventory
        routes.MapPageRoute("rtProductType", "Product-Type", "~/ProductType.aspx");
        routes.MapPageRoute("rtUnitType", "Unit-Type", "~/UnitType.aspx");
        routes.MapPageRoute("rtWarehouse", "Ware-House", "~/Warehouse.aspx");
        routes.MapPageRoute("rtProduct", "Product", "~/Product.aspx");
        //Actor
        routes.MapPageRoute("rtManufacturer", "Manufacturer", "~/Manufacturer.aspx");
        routes.MapPageRoute("rtRetailer", "Retailer", "~/Retailer.aspx");
        routes.MapPageRoute("rtConsumer", "Consumer", "~/Consumer.aspx");
        routes.MapPageRoute("rtAdministrator", "Administrator", "~/Administrator.aspx");
        routes.MapPageRoute("rtCourier", "Courier", "~/Courier.aspx");


        //Purchase Type
        routes.MapPageRoute("rtPurchaseType", "Purchase-Type", "~/PurchaseType.aspx");
        routes.MapPageRoute("rtOrderProduct", "Order-Product", "~/OrderProduct.aspx");
        routes.MapPageRoute("rtProductDetails", "Product-Details", "~/ProductDetails.aspx");
        routes.MapPageRoute("rtCart", "Cart", "~/Cart.aspx");
        routes.MapPageRoute("rtCheckOut", "Check-Out", "~/CheckOut.aspx");
        routes.MapPageRoute("rtPaymentSuccess", "Payment-Success", "~/PaymentSuccess.aspx");
        routes.MapPageRoute("rtEmailError", "Email-Error", "~/EmailError.aspx");
        routes.MapPageRoute("rtPaymentFailure", "Payment-Failure", "~/PaymentFailure.aspx");
        routes.MapPageRoute("rtCheck", "Check", "~/Check.aspx");
        routes.MapPageRoute("rtEmptyCart", "Empty-Cart", "~/EmptyCart.aspx");
        routes.MapPageRoute("rtStockIssued", "Stock-Issued", "~/StockIssued.aspx");
        routes.MapPageRoute("rtStockReceived", "Stock-Received", "~/StockReceived.aspx");
        routes.MapPageRoute("rtChatBot", "Chat-Bot", "~/ChatBot.aspx");

        //Customer
        routes.MapPageRoute("rtClientPay", "Client-Pay", "~/ClientPay.aspx");
        routes.MapPageRoute("rtConsumerRegister", "Consumer-Register", "~/ConsumerRegister.aspx");
        routes.MapPageRoute("rtConsumerLogin", "Consumer-Login", "~/ConsumerLogin.aspx");
        routes.MapPageRoute("rtConsumerCart", "Consumer-Cart", "~/ConsumerCart.aspx");
        routes.MapPageRoute("rtConsumerEmptyCart", "Consumer-Empty-Cart", "~/ConsumerEmptyCart.aspx");
        routes.MapPageRoute("rtConsumerCheck", "Consumer-Check", "~/ConsumerCheck.aspx");

        routes.MapPageRoute("rtConsumerCheckOut", "Consumer-Check-Out", "~/ConsumerCheckOut.aspx");
        routes.MapPageRoute("rtConsumerPaymentSuccess", "Consumer-Payment-Success", "~/ConsumerPaymentSuccess.aspx");


        //AdminCustomerOrders
        routes.MapPageRoute("rtCustomerOrders", "Consumer-Orders", "~/CustomerOrders.aspx");
        routes.MapPageRoute("rtCancelCustomerOrders", "Cancel-Consumer-Orders", "~/CancelCustomerOrders.aspx");
        routes.MapPageRoute("rtCourierService", "Courier-Service", "~/CourierService.aspx");
        routes.MapPageRoute("rtUpdateLocation", "Update-Location", "~/UpdateLocation.aspx");
        routes.MapPageRoute("rtSubmitOrder", "Submit-Order", "~/SubmitOrder.aspx");

        //Reports
        routes.MapPageRoute("rtManufacturerReport", "Manufacturer-Report", "~/ManufacturerReport.aspx");
        routes.MapPageRoute("rtRetailerStock", "Retailer-Stock", "~/RetailerStock.aspx");
        routes.MapPageRoute("rtRetailerSalebsReport", "Retailer-Sales-Report", "~/RetailerSalesReport.aspx");
        routes.MapPageRoute("rtCourierShippedReport", "Courier-Shipped-Report", "~/CourierShippedReport.aspx");
        routes.MapPageRoute("rtAuditTrail", "Audit-Trail", "~/AuditTrail.aspx");

        //ConsumerReport
        routes.MapPageRoute("rtConsumerReport", "Consumer-Report", "~/ConsumerReport.aspx");
        routes.MapPageRoute("rtConsumerPaymentFailure", "Consumer-Payment-Failure", "~/ConsumerPaymentFailure.aspx");
        

        //ChatReport
        routes.MapPageRoute("rtChatHistory", "Chat-History", "~/ChatHistory.aspx");
        routes.MapPageRoute("rtFeedback", "Feedback", "~/Feedback.aspx");
         routes.MapPageRoute("rtCustomerSentiment", "Consumer-Sentiment", "~/CustomerSentiment.aspx");

           routes.MapPageRoute("rtCancelledIssuedOrder", "Cancelled-Issued-Order", "~/CancelledIssuedOrder.aspx");
        routes.MapPageRoute("rtStockReceivedCancelled", "Stock-Received-Cancelled", "~/StockReceivedCancelled.aspx");

        

        
        
        
        
































    }
    void Application_Start(object sender, EventArgs e)
    {
        // Code that runs on application startup
        RegisterRoutes(RouteTable.Routes);
        //SqlServerTypes.Utilities.LoadNativeAssemblies(Server.MapPath("~/bin"));
    }
</script>
