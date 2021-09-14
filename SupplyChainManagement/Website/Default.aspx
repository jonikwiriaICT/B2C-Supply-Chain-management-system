<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" ValidateRequest="false" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Sini Electronic Supply Chain Management</title>
    <link rel="icon" href="twitterbot.png" />
    <!-- Bootstrap 3.3.7 -->
    <link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.min.css" />
    <!-- Font Awesome -->
    <link rel="stylesheet" href="bower_components/font-awesome/css/font-awesome.min.css" />
    <!-- Ionicons -->
    <link rel="stylesheet" href="bower_components/Ionicons/css/ionicons.min.css" />
    <!-- jvectormap -->
    <link rel="stylesheet" href="bower_components/jvectormap/jquery-jvectormap.css" />
    <!-- Theme style -->
    <link rel="stylesheet" href="dist/css/AdminLTE.min.css" />
    <link href="style.css" rel="stylesheet" />
    <!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
    <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css" />
    <link rel="stylesheet" href="plugins/iCheck/flat/blue.css" />
    <!-- owl carousel CSS -->
    <link rel="stylesheet" href="css/owl.carousel.min.css" />
    <!-- Slick Carousel CSS -->
    <link rel="stylesheet" href="css/slick.css" />
    <!-- Animate CSS -->
    <link rel="stylesheet" href="css/animate.css" />
    <!-- Jquery-ui CSS -->
    <!-- Venobox CSS -->
    <link rel="stylesheet" href="css/venobox.css" />
    <!-- Nice Select CSS -->
    <link rel="stylesheet" href="css/nice-select.css" />
    <!-- Magnific Popup CSS -->
    <link rel="stylesheet" href="css/magnific-popup.css" />
    <!-- Bootstrap V4.1.3 Fremwork CSS -->
    <!-- Helper CSS -->
    <link rel="stylesheet" href="css/helper.css" />
    <!-- Main Style CSS -->
    <!-- Responsive CSS -->
    <link rel="stylesheet" href="css/responsive.css" />
    <!-- Modernizr js -->
    <script src="js/vendor/modernizr-2.8.3.min.js"></script>
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->
    <link href="floating-whatsapp-master/floating-wpp.css" rel="stylesheet" />
    <!-- Google Font -->
    <link rel="stylesheet"
        href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic" />
    <style type="text/css">
        a.gflag {
            vertical-align: middle;
            font-size: 16px;
            padding: 1px 0;
            background-repeat: no-repeat;
            background-image: url(//gtranslate.net/flags/16.png);
        }

            a.gflag img {
                border: 0;
            }

            a.gflag:hover {
                background-image: url(//gtranslate.net/flags/16a.png);
            }

        #goog-gt-tt {
            display: none !important;
        }

        .goog-te-banner-frame {
            display: none !important;
        }

        .goog-te-menu-value:hover {
            text-decoration: none !important;
        }

        body {
            top: 0 !important;
        }

        #google_translate_element2 {
            display: none !important;
        }
        -->
    </style>
    <style>
        body, html {
            height: 100%;
            /* Full height */
            height: 100%;
            /* Center and scale the image nicely */
        }

        ::-webkit-scrollbar {
            width: 20px;
        }


        /* Track */
        ::-webkit-scrollbar-track {
            box-shadow: inset 0 0 5px grey;
            border-radius: 10px;
        }

        /* Handle */
        ::-webkit-scrollbar-thumb {
            background: white;
            border-radius: 10px;
        }

            /* Handle on hover */
            ::-webkit-scrollbar-thumb:hover {
                background: #4fc1f0;
            }
    </style>
</head>
<!-- ADD THE CLASS layout-boxed TO GET A BOXED LAYOUT -->
<body class="hold-transition skin-blue layout-boxed sidebar-mini">
    <!-- Site wrapper -->
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="wrapper layout-top-nav">

            <header class="main-header">
                <!-- Logo -->
                <nav class="navbar navbar-static-top">
                    <div class="container">
                        <div class="navbar-header">
                            <a href="index" class="navbar-brand"><b>SINI B2C</b>&nbsp SCM</a>
                            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-collapse">
                                <i class="fa fa-bars"></i>
                            </button>
                        </div>

                        <!-- Collect the nav links, forms, and other content for toggling -->
                        <div class="collapse navbar-collapse pull-left" id="navbar-collapse">

                            <div class="navbar-form navbar-left" role="search">
                                <div class="form-group">
                                    <input type="text" class="form-control" id="navbarsearchinput" runat="server" placeholder="Search" />
                                </div>
                            </div>
                        </div>
                        <div class="navbar-custom-menu">
                            <ul class="nav navbar-nav">
                                <li class="dropdown messages-menu">
                                    <asp:LinkButton ID="lnkCartCheck" OnClick="CartCheck" runat="server">
                                      <i class=" fa fa-cart-plus"></i>
              <span class="label label-success"><%=sCountCart  %></span>
                                    </asp:LinkButton>


                                </li>

                                <li class="dropdown user user-menu">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                        <img runat="server" id="UserImage" src="dist/img/avatar.png" class="user-image" alt="User Image" />
                                        <span class="hidden-xs">
                                            <asp:Label ID="lblUsername" runat="server" Text=""></asp:Label>
                                        </span>
                                    </a>
                                    <ul class="dropdown-menu">
                                        <!-- User image -->
                                        <li class="user-header">
                                            <img runat="server" id="UserImage1" src="dist/img/avatar.png" class="img-circle" alt="User Image" />


                                        </li>
                                        <!-- Menu Body -->

                                        <!-- Menu Footer-->
                                        <li class="user-footer">
                                            <div class="pull-right">
                                                <%
                                                    if (Session["users"] == null)
                                                    {
                                                %>
                                                <asp:LinkButton ID="lnkSignin" OnClick="SignOut" CssClass="btn btn-default btn-flat" runat="server"><i class="fa fa-sign-in"></i>&nbsp Sign in</asp:LinkButton>
                                                <%
                                                    }
                                                    else
                                                    {

                                                %>
                                                <asp:LinkButton ID="lnkSignOut" OnClick="SignOut" CssClass="btn btn-default btn-flat" runat="server"><i class="fa fa-sign-out"></i>&nbsp Sign Out</asp:LinkButton>

                                                <%
                                                    }
                                                %>
                                            </div>
                                        </li>
                                    </ul>
                                </li>
                                <!-- Control Sidebar Toggle Button -->
                                <li>
                                    <div id="google_translate_element" class="input-sm"></div>
                                </li>
                            </ul>
                        </div>
                        <!-- /.navbar-collapse -->
                        <!-- Navbar Right Menu -->

                        <!-- /.navbar-custom-menu -->
                    </div>
                    <!-- /.container-fluid -->
                </nav>
            </header>

            <div class="content-wrapper">
                <div class="container">


                    <!-- Main content -->
                    <section class="content ">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="panel ">
                                    <div class="panel-heading ">
                                        <div class="panel-title ">
                                            <h4>Products</h4>
                                        </div>
                                    </div>
                                    <div class="panel-body table-responsive">
                                        <div id="WAButton"></div>
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

                                                            <div class="product-area shop-product-area">
                                                                <div class="row">
                                                                    <asp:DataList ID="LVProducts" runat="server" OnItemCommand="dtSpouse_itemCommand" CssClass="row" RepeatColumns="4">
                                                                        <ItemTemplate>
                                                                            <div class="col-lg-12 col-md-12 col-sm-12 mt-40">
                                                                                <!-- single-product-wrap start -->
                                                                                <div class="single-product-wrap">
                                                                                    <div class="product-image">
                                                                                        <a href="#">
                                                                                            <img src='<%#Eval("ProductProfile") %>' style="width: 20em; height: 20em" runat="server" alt="Li's Product Image">
                                                                                        </a>

                                                                                    </div>
                                                                                    <div class="product_desc">
                                                                                        <div class="product_desc_info">
                                                                                            <div class="product-review">
                                                                                                <h5 class="manufacturer">
                                                                                                    <a href="#"><%#Eval("RetailerName") %></a>
                                                                                                </h5>

                                                                                            </div>
                                                                                            <h4><a class="product_name" href="#"><%#Eval("ProductName") %></a></h4>
                                                                                            <div class="price-box">
                                                                                                <span class="new-price"><%#Eval("SellingPrice") %></span>
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="add-actions">
                                                                                            <ul class="add-actions-link">
                                                                                                <li class="add-cart active">
                                                                                                    <asp:LinkButton ID="lnkAddToCart" runat="server" CssClass=" add-to-cart"
                                                                                                        CommandName="btnAddToCart" CommandArgument='<%#Eval("ProductID")%>'>
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
                    <!-- /.content -->
                </div>
                <!-- /.container -->
            </div>
            <!-- /.content-wrapper -->
            <footer class="main-footer">
                <div class="container">
                    <div class="pull-right hidden-xs">
                        <b>Version</b> 1.0
                    </div>
                    <strong>Copyright &copy; <%=DateTime .UtcNow .Year  %> <a href="https://veritas.edu.ng">Designed by Sini Isaac | Department of Computer and Information Technology, Veritas University.</a>.</strong> All rights
                    reserved.
                </div>
                <!-- /.container -->
            </footer>
        </div>
    </form>
    <script src="bower_components/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap 3.3.7 -->
    <script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- FastClick -->
    <script src="bower_components/fastclick/lib/fastclick.js"></script>
    <!-- AdminLTE App -->
    <script src="dist/js/adminlte.min.js"></script>
    <!-- Sparkline -->
    <script src="bower_components/jquery-sparkline/dist/jquery.sparkline.min.js"></script>
    <!-- jvectormap  -->
    <script src="plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
    <script src="plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
    <!-- SlimScroll -->
    <script src="bower_components/datatables.net/js/jquery.dataTables.min.js"></script>
    <script src="bower_components/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
    <script src="bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
    <!-- ChartJS -->
    <script src="bower_components/chart.js/Chart.js"></script>
    <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
    <script src="dist/js/pages/dashboard2.js"></script>
    <!-- AdminLTE for demo purposes -->
    <script src="dist/js/demo.js"></script>
    <script src="plugins/iCheck/icheck.min.js"></script>
    <script src="floating-whatsapp-master/floating-wpp.js"></script>

    <!-- Page Script -->
    <script>
        $(function () {
            //Enable iCheck plugin for checkboxes
            //iCheck for checkbox and radio inputs
            $('.mailbox-messages input[type="checkbox"]').iCheck({
                checkboxClass: 'icheckbox_flat-blue',
                radioClass: 'iradio_flat-blue'
            });

            //Enable check and uncheck all functionality
            $(".checkbox-toggle").click(function () {
                var clicks = $(this).data('clicks');
                if (clicks) {
                    //Uncheck all checkboxes
                    $(".mailbox-messages input[type='checkbox']").iCheck("uncheck");
                    $(".fa", this).removeClass("fa-check-square-o").addClass('fa-square-o');
                } else {
                    //Check all checkboxes
                    $(".mailbox-messages input[type='checkbox']").iCheck("check");
                    $(".fa", this).removeClass("fa-square-o").addClass('fa-check-square-o');
                }
                $(this).data("clicks", !clicks);
            });

            //Handle starring for glyphicon and font awesome
            $(".mailbox-star").click(function (e) {
                e.preventDefault();
                //detect type
                var $this = $(this).find("a > i");
                var glyph = $this.hasClass("glyphicon");
                var fa = $this.hasClass("fa");

                //Switch states
                if (glyph) {
                    $this.toggleClass("glyphicon-star");
                    $this.toggleClass("glyphicon-star-empty");
                }

                if (fa) {
                    $this.toggleClass("fa-star");
                    $this.toggleClass("fa-star-o");
                }
            });
        });
    </script>
    <script>
        $(function () {
            $('.catr').DataTable()
            $('.catrdd').DataTable({
                'paging': true,
                'lengthChange': false,
                'searching': false,
                'ordering': true,
                'info': true,
                'autoWidth': false
            })
        })
    </script>
    <script type="text/javascript">
        $(function () {
            $('#WAButton').floatingWhatsApp({
                phone: '<%=Session ["consumer"].ToString ()%>', //WhatsApp Business phone number
                    headerTitle: ' Chat with us on our AI!', //Popup Title
                    popupMessage: 'Welcome to Supply Chain Management System., how can we help you?', //Popup Message
                    showPopup: true, //Enables popup display
                    buttonImage: '<img src="twitterbot.png" />', //Button Image
                    headerColor: 'white', //Custom header color
                    backgroundColor: 'crimson', //Custom background button color
                    position: "left" //Position: left | right

                });
            });
    </script>
    <script type="text/javascript">
        (function () {
            var scriptElement = document.createElement('script');
            scriptElement.type = 'text/javascript';
            scriptElement.async = false;
            scriptElement.src = '/BotService.aspx?Get=Script';
            (document.getElementsByTagName('head')[0] ||
             document.getElementsByTagName('body')[0]).appendChild(scriptElement);
        })();
    </script>
    <!--End of Tawk.to Script-->
    <script type="text/javascript">
        function googleTranslateElementInit() {
            new google.translate.TranslateElement({ pageLanguage: 'en', layout: google.translate.TranslateElement.InlineLayout.SIMPLE }, 'google_translate_element');
        }
    </script>
    <script>
        function isNumber(evt, element) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (
                (charCode != 45 || $(element).val().indexOf('-') != -1) &&      // “-” CHECK MINUS, AND ONLY ONE.
                (charCode != 46 || $(element).val().indexOf('.') != -1) &&      // “.” CHECK DOT, AND ONLY ONE.
                (charCode < 48 || charCode > 57))
                return false;

            return true;
        }
    </script>
    <script>
        $('.decimal').keypress(function (event) {
            return isNumber(event, this)
        });
    </script>
    <script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
    <script src="js/jquery.meanmenu.min.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <!-- Main/Activator js -->
    <script src="js/main.js"></script>
</body>
</html>
