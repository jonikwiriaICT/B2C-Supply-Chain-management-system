<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ConsumerCheckOut.aspx.cs" Inherits="ConsumerCheckOut" ValidateRequest ="false"  %>

<!DOCTYPE html>
<html>

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Ensures optimal rendering on mobile devices. -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <!-- Optimal Internet Explorer compatibility -->
</head>

<body>
      
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:Label ID="lblCheck" Visible="false" runat="server" Text=""></asp:Label>
        <asp:GridView  runat="server" ID="GVCart" CssClass=" table-responsive-sm table-bordered table product-list " BackColor="White" CellPadding="4" ForeColor="Black" GridLines="Vertical" HorizontalAlign="Center" AutoGenerateColumns="false" >
            <AlternatingRowStyle HorizontalAlign="Center" />
            <HeaderStyle Font-Bold="True" ForeColor="Black" />
            <RowStyle HorizontalAlign="Center" />
            <Columns>
                 <asp:TemplateField HeaderText="ProductID">
                    <ItemTemplate>
                        <p>
                              <asp:Label ID="RecID" runat="server" Text=' <%# Eval("ProductID") %>'></asp:Label>
                           
                        </p>
                    </ItemTemplate>

                </asp:TemplateField>
                <asp:TemplateField HeaderText="ProductImage">
                    <ItemTemplate>
                        <p>
                            <img class="img-fluid" src='<%# Eval("ProductProfile") %>' runat="server" alt="ProductImage" style="width: 4em; height: 4em" />
                            
                        </p>
                    </ItemTemplate>

                </asp:TemplateField>
                 <asp:TemplateField HeaderText="ManufacturerID">
                    <ItemTemplate>
                        <p>
                            <asp:Label ID="ManufacturerID" runat="server" Text=' <%# Eval("RetailerID") %>'></asp:Label>
                               
                        </p>
                    </ItemTemplate>

                </asp:TemplateField>

                <asp:TemplateField HeaderText="ProductName">
                    <ItemTemplate>
                        <p>
                            <asp:Label ID="ProductName" runat="server" Text=' <%# Eval("ProductName") %>'></asp:Label>
                            
                        </p>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="ProductPrice">
                    <ItemTemplate>
                        <p>
                             <asp:Label ID="BuyingPrice" runat="server" Text=' <%# Eval("SellingPrice") %>'></asp:Label>
                           
                        </p>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="QuantityByCarton">
                    <ItemTemplate>
                        <p> <asp:Label ID="softwarequantity" runat="server" Text=' <%# Eval("softwarequantity") %>'></asp:Label>
                           </p>
                       
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="PriceTotal">
                    <ItemTemplate>
                         <p> <asp:Label ID="softwareTotalAmount" runat="server" Text=' <%# Eval("softwareTotalAmount") %>'></asp:Label>
                           </p>
                
                    </ItemTemplate>
                </asp:TemplateField>
               

                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton runat="server" ID="BtnRemoveFromCart" CssClass=" btn btn-sm btn-outline-danger" CommandArgument='<%# Eval("ProductID") %>' CommandName="Remove From Cart"><i class ="fa fa-trash "></i></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>
        </asp:GridView>
    </form>



  
 
</body>
</html>

