<%@ Page Title="" Language="C#" MasterPageFile="~/SupplyChainMaster.master" AutoEventWireup="true" CodeFile="Error.aspx.cs" Inherits="Error" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
       <section class="content">

      <div class="error-page">
        <h2 class="headline text-red">500</h2>

        <div class="error-content">
          <h3><i class="fa fa-warning text-red"></i> Oops! Something went wrong.</h3>

          <p>
            You are not authorized to use this page
            Meanwhile, you may <a href="Dashboard">return to dashboard</a>
          </p>

  
        </div>
      </div>
      <!-- /.error-page -->

    </section>
</asp:Content>

