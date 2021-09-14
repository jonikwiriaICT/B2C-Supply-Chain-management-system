<%@ Page Title="" Language="C#" MasterPageFile="~/ClientMaster.master" AutoEventWireup="true" CodeFile="ConsumerCart.aspx.cs" Inherits="ConsumerCart" ValidateRequest ="false"  %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="content">
        <div class=" panel ">
            <div class="panel-heading ">
                <div class="panel-title ">
                    <h4>My Cart</h4>
                </div>
            </div>
            <div class="panel-body">
                <div class="Shopping-cart-area pt-60 pb-60">
                    <div class="container">
                        <div class="row">
                            <div class="col-12">

                                <div class="table-content table-responsive">


                                    <asp:GridView runat="server" ID="GVCart" CssClass=" table-responsive-sm table-bordered table product-list " BackColor="White" CellPadding="4" ForeColor="Black" GridLines="Vertical" HorizontalAlign="Center" AutoGenerateColumns="false" OnRowCommand="GVCart_RowCommand">
                                        <AlternatingRowStyle HorizontalAlign="Center" />
                                        <HeaderStyle Font-Bold="True" ForeColor="Black" />
                                        <RowStyle HorizontalAlign="Center" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="Product Image">
                                                <ItemTemplate>
                                                    <p>
                                                        <img class="img-fluid" src='<%# Eval("ProductProfile") %>' runat="server" alt="ProductImage" style="width: 4em; height: 4em" />

                                                    </p>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Manufacturer">
                                                <ItemTemplate>
                                                    <p>
                                                        <%# Eval("RetailerID") %>
                                                    </p>
                                                </ItemTemplate>

                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Product Name">
                                                <ItemTemplate>
                                                    <p><%# Eval("ProductName") %></p>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Product Price">
                                                <ItemTemplate>
                                                    <p><%# (Eval("SellingPrice")) %></p>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Quantity (Per Carton)">
                                                <ItemTemplate>
                                                    <p><%# Eval("softwarequantity")%></p>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Price Total">
                                                <ItemTemplate>
                                                    <p><%# (Eval("softwareTotalAmount")) %></p>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:LinkButton runat="server" ID="BtnRemoveFromCart" CssClass=" btn btn-sm btn-outline-danger" CommandArgument='<%# Eval("ProductID") %>' CommandName="Remove From Cart"><i class ="fa fa-trash "></i></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                        </Columns>
                                    </asp:GridView>
                                </div>

                                <div class="row" runat="server" id="idTotal">
                                    <div class="col-md-5 ml-auto  pull-right">
                                        <div class="cart-page-total">
                                            <h2>Cart totals</h2>
                                            <ul>
                                                <li>Subtotal <span>N<%=totalAmount %></span></li>
                                                <li>Total <span>N<%=totalAmount %></span></li>
                                            </ul>

                                        </div>
                                        <div class="cart-page-total">
                                            <ul>
                                                
                                                <li>
                                                    <asp:LinkButton ID="lnkPay" OnClick="NavigateToPayOut" CssClass="btn btn-sm btn-primary pull-right  " runat="server"><i class="fa fa-paypal "></i>&nbsp Buy Goods</asp:LinkButton>
                                                    <br />
                                                    <br />
                                                    <br />
                                                </li>
                                            </ul>

                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

</asp:Content>


