<%@ Page Title="" Language="C#" MasterPageFile="~/ClientMaster.master" AutoEventWireup="true" CodeFile="ConsumerPaymentFailure.aspx.cs" Inherits="ConsumerPaymentFailure" ValidateRequest ="false"  %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
       <section class="content">

      <div class="error-page">
        <h2 class="headline text-red">502</h2>

        <div class="error-content">
          <h3><i class="fa fa-warning text-red"></i> Oops! Your Payment was not successful. You can try again</h3>

          <p>
         
            Meanwhile, you may <a href="Index">return to Index</a>
          </p>

  
        </div>
      </div>
      <!-- /.error-page -->

    </section>
</asp:Content>


