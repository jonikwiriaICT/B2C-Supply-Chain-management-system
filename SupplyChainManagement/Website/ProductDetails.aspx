<%@ Page Title="" Language="C#" MasterPageFile="~/SupplyChainMaster.master" AutoEventWireup="true" CodeFile="ProductDetails.aspx.cs" Inherits="ProductDetails" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

     <link rel="stylesheet" href="css/jquery-ui.min.css"/>
   
      <link rel="stylesheet" href="style.css"/>
        <!-- Responsive CSS -->
        <link rel="stylesheet" href="css/responsive.css"/>
    <section class=" content">
      
            <div class=" card">
                <div class="card-header ">
                    <h4>Product Details</h4>
                </div>
                <div class="card-body">
                    <div class="breadcrumb-area">
                        <div class="container">
                            <div class="breadcrumb-content">
                                <ul>
                                    
                                    <li class="active">Single Product</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <!-- Li's Breadcrumb Area End Here -->
                    <!-- content-wraper start -->
                    <div class="content-wraper">
                        <div class="container">
                            <div class="row single-product-area">
                                 <asp:listView ID="LVProducts" runat="server">
                                <ItemTemplate>
                              
                                
                                            <div class="col-lg-5 col-md-6">
                                            <!-- Product Details Left -->
                                            <div class="product-details-left">
                                                <div class="product-details-images slider-navigation-1">
                                                    <div class="lg-image">
                                                        <a class="popup-img venobox vbox-item" href="#" data-gall="myGallery">
                                                            <img src="<%#Eval("product_profile") %>"  alt="product image">
                                                        </a>
                                                    </div>
                                                    <div class="lg-image">
                                                        <a class="popup-img venobox vbox-item" href="#" data-gall="myGallery">
                                                            <img src="<%#Eval("product_profile") %>"   alt="product image">
                                                        </a>
                                                    </div>
                                                    <div class="lg-image">
                                                        <a class="popup-img venobox vbox-item" href="#" data-gall="myGallery">
                                                            <img src="<%#Eval("product_profile") %>"  alt="product image">
                                                        </a>
                                                    </div>
                                                    <div class="lg-image">
                                                        <a class="popup-img venobox vbox-item" href="#" data-gall="myGallery">
                                                            <img src="<%#Eval("product_profile") %>"   alt="product image">
                                                        </a>
                                                    </div>
                                                    <div class="lg-image">
                                                        <a class="popup-img venobox vbox-item" href="#" data-gall="myGallery">
                                                            <img src="<%#Eval("product_profile") %>"   alt="product image">
                                                        </a>
                                                    </div>
                                                    <div class="lg-image">
                                                        <a class="popup-img venobox vbox-item" href="#" data-gall="myGallery">
                                                            <img src="<%#Eval("product_profile") %>"   alt="product image">
                                                        </a>
                                                    </div>
                                                </div>
                                                <div class="product-details-thumbs slider-thumbs-1">
                                                    <div class="sm-image">
                                                        <img src="<%#Eval("product_profile") %>"   alt="product image thumb">
                                                    </div>
                                                    <div class="sm-image">
                                                        <img src="<%#Eval("product_profile") %>"   alt="product image thumb">
                                                    </div>
                                                    <div class="sm-image">
                                                        <img src="<%#Eval("product_profile") %>"   alt="product image thumb">
                                                    </div>
                                                    <div class="sm-image">
                                                        <img src="<%#Eval("product_profile") %>"   alt="product image thumb">
                                                    </div>
                                                    <div class="sm-image">
                                                        <img src="<%#Eval("product_profile") %>"   alt="product image thumb">
                                                    </div>
                                                    <div class="sm-image">
                                                        <img src="<%#Eval("product_profile") %>"   alt="product image thumb">
                                                    </div>
                                                </div>
                                            </div>
                                            <!--// Product Details Left -->
                                        </div>

                                        <div class="col-lg-7 col-md-6 white  ">
                                            <div class="card-body ">
                                                <div class="product-details-view-content pt-60">
                                                    <div class="product-info">
                                                        <h2><%#Eval("product_name") %></h2>


                                                        <div class="price-box pt-20">
                                                            <span class="new-price new-price-2">N<%#Eval("buying_price") %></span>
                                                        </div>
                                                        <div class="product-desc">
                                                            <p>
                                                                <span>
                                                                    <%#Eval("product_description") %>
                                                                </span>
                                                            </p>
                                                        </div>


                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                             
                                  
                                </ItemTemplate>
                            </asp:listView>
                            </div>
                           



                        </div>
                    </div>
                </div>
            </div>
      
    </section>
    <script src="js/vendor/jquery-1.12.4.min.js"></script>
    <!-- Popper js -->
    <script src="js/vendor/popper.min.js"></script>
    <!-- Bootstrap V4.1.3 Fremwork js -->
    <script src="js/bootstrap.min.js"></script>
    <!-- Ajax Mail js -->
    <script src="js/ajax-mail.js"></script>
    <!-- Meanmenu js -->
    <script src="js/jquery.meanmenu.min.js"></script>
    <!-- Wow.min js -->
    <script src="js/wow.min.js"></script>
    <!-- Slick Carousel js -->
    <script src="js/slick.min.js"></script>
    <!-- Owl Carousel-2 js -->
    <script src="js/owl.carousel.min.js"></script>
    <!-- Magnific popup js -->
    <script src="js/jquery.magnific-popup.min.js"></script>
    <!-- Isotope js -->
    <script src="js/isotope.pkgd.min.js"></script>
    <!-- Imagesloaded js -->
    <script src="js/imagesloaded.pkgd.min.js"></script>
    <!-- Mixitup js -->
    <script src="js/jquery.mixitup.min.js"></script>
    <!-- Countdown -->
    <script src="js/jquery.countdown.min.js"></script>
    <!-- Counterup -->
    <script src="js/jquery.counterup.min.js"></script>
    <!-- Waypoints -->
    <script src="js/waypoints.min.js"></script>
    <!-- Barrating -->
    <script src="js/jquery.barrating.min.js"></script>
    <!-- Jquery-ui -->
    <script src="js/jquery-ui.min.js"></script>
    <!-- Venobox -->
    <script src="js/venobox.min.js"></script>
    <!-- Nice Select js -->
    <script src="js/jquery.nice-select.min.js"></script>
    <!-- ScrollUp js -->
    <script src="js/scrollUp.min.js"></script>
    <!-- Main/Activator js -->
    <script src="js/main.js"></script>
</asp:Content>

