<%@ Page Title="" Language="C#" MasterPageFile="~/ClientMaster.master" AutoEventWireup="true" CodeFile="ConsumerLogin.aspx.cs" Inherits="ConsumerLogin" ValidateRequest ="false"  %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class=" container ">
        <div class="row">
            <div class="col-md-12">
                <div id="formView" runat="server">
                    <div class="panel">
                        <div class="panel-heading ">
                            <div class="panel-title ">
                                <h4>Sign in</h4>
                             
                            </div>
                        </div>
                        <div class="panel-body">
                            <div class="box box-primary">
                                <div class="box-body box-profile">
                                    <br />
                                    <asp:Panel ID="PnlCurrency" runat="server">
                                        <asp:HiddenField ID="rec_id" runat="server" />
                                        <asp:HiddenField ID="currency_description" runat="server" />
                                        <div class="row">
                                            <div class="col-md-3">
                                                <label style="font-size: 12px">Email</label>
                                            </div>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="username" CssClass="form-control "  runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-3">
                                                <label style="font-size: 12px">Phone Number</label>
                                            </div>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="PhoneNumber" CssClass="form-control " TextMode="Password" runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                      
                                        <div class="row">
                                            <div class="col-md-12">
                                                <asp:LinkButton ID="lnkSaveChanges" OnClick="ChangePasswordClicked" CssClass="btn btn-sm btn-primary pull-right  " runat="server"><i class="fa fa-save "></i>&nbsp Save Changes</asp:LinkButton>
                                            </div>
                                        </div>
                                    </asp:Panel>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>

