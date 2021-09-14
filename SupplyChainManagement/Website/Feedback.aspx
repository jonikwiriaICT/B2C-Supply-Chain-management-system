<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Feedback.aspx.cs" Inherits="Feedback" ValidateRequest="false" %>

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
                                    <input type="text" class="form-control" id="navbar-search-input" placeholder="Search" />
                                </div>
                            </div>
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
                    <section class="content">
                        <div class="row">
                            <div class="box box-success direct-chat direct-chat-success">
                                <div class="box-header with-border">
                                    <h3 class="box-title">SINI B2C Chatbot</h3>
                                    <div class="btn-group pull-right ">
                                        <button type="button" class="btn btn-info">Action</button>
                                        <button type="button" class="btn btn-info dropdown-toggle" data-toggle="dropdown">
                                            <span class="caret"></span>
                                            <span class="sr-only">Toggle Dropdown</span>
                                        </button>
                                        <ul class="dropdown-menu" role="menu">
                                            <li>
                                                <asp:LinkButton ID="lnkGoB" OnClick="NavigateClicked" runat="server"><i class=" fa fa-line-chart"></i>See Chat History</asp:LinkButton>

                                            </li>

                                        </ul>
                                    </div>
                                </div>
                                <!-- /.box-header -->
                                <div class="box-body">
                                    <!-- Conversations are loaded here -->
                                    <div class="direct-chat-messages" style="height: 100%">
                                        <div class="direct-chat-msg">
                                            <div class="direct-chat-info clearfix"><span class="direct-chat-name pull-left">SINI Bot</span><span class="direct-chat-timestamp pull-right"><%=DateTime .UtcNow .ToShortDateString () %></span></div>
                                            <img class="direct-chat-img" src="twitterbot.png" alt="Message User Image"><div class="direct-chat-text"><%=ConsumerName .ToString () %></div>
                                        </div>
                                    </div>
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            <asp:DataList ID="dtMessageLog" runat="server" CssClass="col-md-12">
                                                <ItemTemplate>

                                                    <div class="direct-chat-msg">
                                                        <div class="direct-chat-info clearfix"><span class="direct-chat-name pull-left">SINI Bot</span><span class="direct-chat-timestamp pull-right"><%#Eval("created_date") %></span></div>
                                                        <img class="direct-chat-img" src="twitterbot.png" alt="Message User Image"><div class="direct-chat-text">
                                                            <%#Eval("bot_message") %>
                                                        </div>
                                                    </div>
                                                    <div class="direct-chat-msg right">
                                                        <div class="direct-chat-info clearfix"><span class="direct-chat-name pull-right">Client</span><span class="direct-chat-timestamp pull-left"><%#Eval("created_date") %></span></div>
                                                        <img class="direct-chat-img" src="dist/img/user3-128x128.jpg" alt="Message User Image" /><div class="direct-chat-text"><%#Eval("client_message") %></div>
                                                    </div>

                                                </ItemTemplate>
                                            </asp:DataList>
                                        </ContentTemplate>
                                        <Triggers>
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </div>
                                <!-- /.box-body -->
                                <div class="box-footer">
                                    <div>
                                        <div class="input-group">
                                            <input type="text" id="data" name="message" placeholder="Type Message ..." class="form-control" />
                                            <span class="input-group-btn">
                                                <button type="button" id="send-btn" class="btn btn-success btn-flat">Send</button>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <!-- /.box-footer-->
                            </div>
                        </div>
                    </section>
                    <!-- /.content -->
                </div>
                <!-- /.container -->
            </div>
            <!-- /.content-wrapper -->
            <footer class="main-footer">
                <div id="divData">
                </div>
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

    <!-- ./wrapper -->

    <!-- jQuery 3 -->
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
    <script>
        $(document).ready(function () {
            $("#send-btn").on("click", function () {
                ShowTestMessage();
            }
            );
        });
        $("#data").keyup(function (event) {
            if (event.keyCode === 13) {

                $("#send-btn").click();
                $("#data").val('');
            }
        });
        function ShowTestMessage() {
            $value = $("#data").val();
            $msg = '<div class="direct-chat-msg right"><div class="direct-chat-info clearfix"><span class="direct-chat-name pull-right">Client</span><span class="direct-chat-timestamp pull-left"><%= DateTime .UtcNow.ToShortDateString()%></span></div><img class="direct-chat-img" src="dist/img/user3-128x128.jpg" alt="Message User Image"/><div class="direct-chat-text">' + $value + '</div></div>';
            $(".direct-chat-messages").append($msg);
            $("#data").val('');
            var obj = {};
            obj.text = $value;
            $.ajax({
                url: "Chat.asmx/GetFeedback",

                type: "POST",
                data: JSON.stringify(obj),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess

            });
        }
        function OnSuccess(response) {
            $Value = document.getElementById("divData").innerHTML = response.d;
            
                 $replay = '<div class="direct-chat-msg"><div class="direct-chat-info clearfix"><span class="direct-chat-name pull-left">SINI Bot</span><span class="direct-chat-timestamp pull-right"><%=DateTime .UtcNow .ToShortDateString()%></span></div><img class="direct-chat-img" src="twitterbot.png" alt="Message User Image"><div class="direct-chat-text">' + $Value + '</div></div>';
            $(".direct-chat-messages").append($replay);
            //// when chat goes down the scroll bar automatically comes to the bottom
            $(".direct-chat-messages").scrollTop($(".direct-chat-messages")[0].scrollHeight);
            $('#divData').hide();
          
           
        }
    </script>
    <script type="text/javascript">
        var searchTimeout;
        document.getElementById('data').onkeypress = function () {
            if (searchTimeout != undefined) clearTimeout(searchTimeout);
            searchTimeout = setTimeout(callServerScript, 250);
        };
        function callServerScript() {
            $("#Typing").hide();
        }
    </script>
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
