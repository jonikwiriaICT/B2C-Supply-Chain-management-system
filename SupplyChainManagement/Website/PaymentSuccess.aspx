<%@ Page Title="" Language="C#" MasterPageFile="~/SupplyChainMaster.master" AutoEventWireup="true" CodeFile="PaymentSuccess.aspx.cs" Inherits="PaymentSuccess" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
       <section class="content">
      <div class="error-page">
        <h2 class="headline text-success"><i class=" fa fa-tasks fa-2x"></i></h2>
        <div class="error-content">
          <h3> Transaction was successful.</h3>
          <p>
             You may <a href="Dashboard">return to dashboard</a>
          </p>
        </div>
      </div>
    </section>
</asp:Content>


