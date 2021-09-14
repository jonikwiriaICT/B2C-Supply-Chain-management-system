<%@ Page Title="" Language="C#" MasterPageFile="~/SupplyChainMaster.master" AutoEventWireup="true" CodeFile="Cart.aspx.cs" Inherits="Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
                                                        <%# Eval("ManufacturerID") %>
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
                                                    <p><%# (Eval("BuyingPrice")) %></p>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Quantity">
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
                                                    <asp:LinkButton runat="server" ID="BtnRemoveFromCart" CssClass=" btn btn-sm btn-outline-danger" CommandArgument='<%# Eval("RecID") %>' CommandName="Remove From Cart"><i class ="fa fa-trash "></i></asp:LinkButton>
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
                                                <li>Goods to Warehouse <span>
                                                    <asp:DropDownList ID="warehouse" CssClass="form-control " runat="server"></asp:DropDownList>
                                                </span>

                                                </li>
                                                <li>Purchase Type 
                                                    <span>
                                                        <asp:DropDownList ID="PurchaseType" CssClass="form-control " runat="server"></asp:DropDownList>
                                                    </span>

                                                </li>
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

