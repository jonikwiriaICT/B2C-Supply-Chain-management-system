<%@ Page Title="" Language="C#" MasterPageFile="~/SupplyChainMaster.master" AutoEventWireup="true" CodeFile="PaymentFailure.aspx.cs" Inherits="PaymentFailure" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
       <section class="content">

      <div class="error-page">
        <h2 class="headline text-red">502</h2>

        <div class="error-content">
          <h3><i class="fa fa-warning text-red"></i> Oops! Your Payment was not successful. You can try again</h3>

          <p>
         
            Meanwhile, you may <a href="Dashboard">return to dashboard</a>
          </p>

  
        </div>
      </div>
      <!-- /.error-page -->

    </section>
</asp:Content>


