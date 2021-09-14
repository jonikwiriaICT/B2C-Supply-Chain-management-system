<%@ Page Title="" Language="C#" MasterPageFile="~/SupplyChainMaster.master" AutoEventWireup="true" CodeFile="OrderProduct.aspx.cs" Inherits="OrderProduct" ValidateRequest ="false"  %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     
     
    <section class="content ">
        <div class="row">
            <div class="col-md-12">
                <div class="panel ">
                    <div class="panel-heading ">
                        <div class="panel-title ">
                            <h4>Order Product</h4>
                        </div>
                    </div>
                    <div class="panel-body">
                        <div class="slider-with-banner">
                            <div class="container">
                                <div class="row">
                                    <!-- Begin Slider Area -->
                                    <div class="col-lg-12 col-md-12">
                                        <div class="slider-area">
                                            <div class="slider-active owl-carousel">
                                                <!-- Begin Single Slide Area -->
                                                <div class="single-slide align-center-left  animation-style-01 bg-1">
                                                    <div class="slider-progress"></div>
                                                    <div class="slider-content">
                                                        <h5>Sale Offer <span>-20% Off</span> This Week</h5>
                                                        <h2>Chamcham Galaxy S9 | S9+</h2>
                                                        <h3>Starting at <span>N120955.00</span></h3>
                                                        <div class="default-btn slide-btn">
                                                            <a class="links" href="#">Shopping Now</a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- Single Slide Area End Here -->
                                                <!-- Begin Single Slide Area -->
                                                <div class="single-slide align-center-left animation-style-02 bg-2">
                                                    <div class="slider-progress"></div>
                                                    <div class="slider-content">
                                                        <h5>Sale Offer <span>Black Friday</span> This Week</h5>
                                                        <h2>Work Desk Surface Studio 2021</h2>
                                                        <h3>Starting at <span>N82455.00</span></h3>
                                                        <div class="default-btn slide-btn">
                                                            <a class="links" href="#">Shopping Now</a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- Single Slide Area End Here -->
                                                <!-- Begin Single Slide Area -->
                                                <div class="single-slide align-center-left animation-style-01 bg-3">
                                                    <div class="slider-progress"></div>
                                                    <div class="slider-content">
                                                        <h5>Sale Offer <span>-10% Off</span> This Week</h5>
                                                        <h2>Phantom 4 Pro+ Obsidian</h2>
                                                        <h3>Starting at <span>N184955.00</span></h3>
                                                        <div class="default-btn slide-btn">
                                                            <a class="links" href="#">Shopping Now</a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- Single Slide Area End Here -->
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Slider Area End Here -->
                                    <!-- Begin Li Banner Area -->

                                    <!-- Li Banner Area End Here -->
                                </div>
                            </div>
                        </div>
                        <section class="product-area li-laptop-product pt-60 pb-45">
                            <div class="container">
                                <div class="row">
                                    <!-- Begin Li's Section Area -->
                                    <div class="col-lg-12">
                                        <div class="shop-products-wrapper">
                                            <div class="tab-content">
                                                <div id="grid-view" class="tab-pane fade active show" role="tabpanel">
                                                    <div class="product-area shop-product-area">
                                                        <div class="row">
                                                            <asp:DataList ID="LVProducts" runat="server"  OnItemCommand="dtSpouse_itemCommand" CssClass="row" RepeatColumns ="4">
                                                                <ItemTemplate>
                                                                    <div class="col-lg-12 col-md-12 col-sm-12 mt-40">
                                                                        <!-- single-product-wrap start -->
                                                                        <div class="single-product-wrap">
                                                                            <div class="product-image">
                                                                                <a href="Product-Details?ID=<%#Eval("RecID")%>">
                                                                                    <img src='<%#Eval("Product Profile") %>' style="width:20em; height:20em" runat ="server"  alt="Li's Product Image">
                                                                                </a>

                                                                            </div>
                                                                            <div class="product_desc">
                                                                                <div class="product_desc_info">
                                                                                    <div class="product-review">
                                                                                        <h5 class="manufacturer">
                                                                                            <a href="Product-Details?ID=<%#Eval("RecID")%>"><%#Eval("Manufacturer Name") %></a>
                                                                                        </h5>

                                                                                    </div>
                                                                                    <h4><a class="product_name" href="Product-Details?ID=<%#Eval("RecID")%>"><%#Eval("Product Name") %></a></h4>
                                                                                    <div class="price-box">
                                                                                        <span class="new-price">N<%#Eval("Buying Price") %></span>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="add-actions">
                                                                                    <ul class="add-actions-link">
                                                                                        <li class="add-cart active">
                                                                                            <asp:LinkButton ID="lnkAddToCart" runat="server" CssClass=" add-to-cart"
                                                                                                CommandName="btnAddToCart" CommandArgument='<%#Eval("RecID")%>'>
                                                                                            <i class=" fa fa-shopping-cart"></i>&nbsp Add to Cart
                                                                                            </asp:LinkButton>
                                                                                        </li>

                                                                                    </ul>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <!-- single-product-wrap end -->
                                                                    </div>
                                                                </ItemTemplate>
                                                            </asp:DataList>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="paginatoin-area">
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <asp:DataList CellPadding="5" RepeatDirection="Horizontal" runat="server" ID="dlPager"
                                                        OnItemCommand="dlPager_ItemCommand">
                                                        <ItemTemplate>
                                                            <nav aria-label="Page navigation example" class="mt-50">
                                                                <ul class="pagination justify-content-center">
                                                                    <li class="page-item ">
                                                                        <asp:LinkButton Enabled='<%#Eval("Enabled") %>' CssClass="page-link bg-dark text-white" runat="server" ID="lnkPageNo" Text='<%#Eval("Text") %>' CommandArgument='<%#Eval("Value") %>' CommandName="PageNo"></asp:LinkButton>

                                                                    </li>
                                                                </ul>
                                                            </nav>

                                                        </ItemTemplate>
                                                    </asp:DataList>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- Li's Section Area End Here -->
                            </div>
                            </section>
                    </div>

                    <!-- Li's Laptop Product Area End Here -->

                </div>
            </div>

        </div>
    </section>

</asp:Content>

