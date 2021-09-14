<%@ Page Title="" Language="C#" MasterPageFile="~/ClientMaster.master" AutoEventWireup="true" CodeFile="ConsumerPaymentSuccess.aspx.cs" Inherits="ConsumerPaymentSuccess" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
       <section class="content">
      <div class="error-page">
        <h2 class="headline text-success"><i class=" fa fa-tasks fa-2x"></i></h2>
        <div class="error-content">
          <h3> Transaction was successful.</h3>
          <p>
             You may <a href="Index">return to dashboard</a>
          </p>
        </div>
      </div>
    </section>
</asp:Content>

