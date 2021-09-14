<%@ Page Title="" Language="C#" MasterPageFile="~/SupplyChainMaster.master" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="Dashboard" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!-- Content Header (Page header) -->
    <style>
        #container {
            height: 420px;
        }

        .highcharts-figure, .highcharts-data-table table {
            min-width: 360px;
            max-width: 600px;
            margin: 1em auto;
        }

        .highcharts-data-table table {
            font-family: Verdana, sans-serif;
            border-collapse: collapse;
            border: 1px solid #EBEBEB;
            margin: 10px auto;
            text-align: center;
            width: 100%;
            max-width: 500px;
        }

        .highcharts-data-table caption {
            padding: 1em 0;
            font-size: 1.2em;
            color: #555;
        }

        .highcharts-data-table th {
            font-weight: 600;
            padding: 0.5em;
        }

        .highcharts-data-table td, .highcharts-data-table th, .highcharts-data-table caption {
            padding: 0.5em;
        }

        .highcharts-data-table thead tr, .highcharts-data-table tr:nth-child(even) {
            background: #f8f8f8;
        }

        .highcharts-data-table tr:hover {
            background: #f1f7ff;
        }
    </style>
    <section class="content-header">
        <h1>Dashboard
       
            <small>Version 1.0</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="Dashboard"><i class="fa fa-dashboard"></i>Home</a></li>
            <li class="active">Dashboard</li>
        </ol>
    </section>

    <!-- Main content -->
    <section class="content">
        <!-- Info boxes -->
        <div class="row">
            <div class="col-md-3 col-sm-6 col-xs-12">
                <div class="info-box">
                    <span class="info-box-icon bg-aqua"><i class=" fa fa-home "></i></span>
                    <div class="info-box-content">
                        <span class="info-box-text">Manufacturer Sales</span>
                        <span class="info-box-number">N<small></small>
                            <asp:Label ID="lblManufacturerSales" CssClass ="counters" runat="server"></asp:Label>
                        </span>
                    </div>
                    <!-- /.info-box-content -->
                </div>
                <!-- /.info-box -->
            </div>
            <!-- /.col -->
            <div class="col-md-3 col-sm-6 col-xs-12">
                <div class="info-box">
                    <span class="info-box-icon bg-red"><i class=" fa fa-retweet "></i></span>

                    <div class="info-box-content">
                        <span class="info-box-text">Cancelled Manufacturer Sales</span>
                        <span class="info-box-number">N<small></small>
                            <asp:Label ID="lblCancelledManufacturerSales" CssClass ="counters" runat="server"></asp:Label>
                        </span>
                    </div>
                    <!-- /.info-box-content -->
                </div>
                <!-- /.info-box -->
            </div>
            <!-- /.col -->

            <!-- fix for small devices only -->
            <div class="clearfix visible-sm-block"></div>

            <div class="col-md-3 col-sm-6 col-xs-12">
                <div class="info-box">
                    <span class="info-box-icon bg-green"><i class="ion ion-ios-cart-outline"></i></span>

                    <div class="info-box-content">
                        <span class="info-box-text">Retailer Sales</span>
                        <span class="info-box-number">N<small></small>
                            <asp:Label ID="lblRetailerSales" CssClass ="counters" runat="server"></asp:Label>
                        </span>
                    </div>
                    <!-- /.info-box-content -->
                </div>
                <!-- /.info-box -->
            </div>
            <!-- /.col -->
            <div class="col-md-3 col-sm-6 col-xs-12">
                <div class="info-box">
                    <span class="info-box-icon bg-red"><i class=" fa fa-money"></i></span>

                    <div class="info-box-content">
                        <span class="info-box-text">Retailer Cancelled Sales</span>
                        <span class="info-box-number">N<small></small>
                            <asp:Label ID="lblRetailerCancelledSales" CssClass ="counters" runat="server"></asp:Label>
                        </span>
                    </div>
                    <!-- /.info-box-content -->
                </div>
                <!-- /.info-box -->
            </div>
            <!-- /.col -->
        </div>
        <!-- /.row -->

        <div class="row">
            <div class="col-md-12">
                <div class="box">
                    <div class="box-header with-border">
                        <h3 class="box-title">Manufacturer Report</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div class="row">
                            <div class="col-md-6 table-responsive ">
                                <figure class="highcharts-figure">
                                    <div id="container"></div>
                                    <p class="highcharts-description">
                                        Manufacturer Sales
                                    </p>
                                </figure>

                            </div>
                             <div class="col-md-6 table-responsive ">
                                <figure class="highcharts-figure">
                                    <div id="containerCancelled"></div>
                                    <p class="highcharts-description">
                                        Manufacturer Sales
                                    </p>
                                </figure>

                            </div>

                        </div>
                        <!-- /.row -->
                    </div>
                    <!-- ./box-body -->

                    <!-- /.box-footer -->
                </div>
                <!-- /.box -->
            </div>
            <!-- /.col -->
        </div>

         <div class="row">
            <div class="col-md-12">
                <div class="box">
                    <div class="box-header with-border">
                        <h3 class="box-title">Retailer Report</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div class="row">
                            <div class="col-md-6 table-responsive ">
                                <figure class="highcharts-figure">
                                    <div id="containers"></div>
                                    <p class="highcharts-description">
                                        Retailer Sales
                                    </p>
                                </figure>

                            </div>
                             <div class="col-md-6 table-responsive ">
                                <figure class="highcharts-figure">
                                    <div id="containerRetail"></div>
                                    <p class="highcharts-description">
                                        Retailer Sales
                                    </p>
                                </figure>

                            </div>

                        </div>
                        <!-- /.row -->
                    </div>
                    <!-- ./box-body -->

                    <!-- /.box-footer -->
                </div>
                <!-- /.box -->
            </div>
            <!-- /.col -->
        </div>
        <!-- /.row -->

        <!-- Main row -->

    </section>
    <!-- /.content -->
    <script src="floating-whatsapp-master/jquery-3.3.1.min.js"></script>
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/highcharts-3d.js"></script>
    <script src="https://code.highcharts.com/modules/cylinder.js"></script>
    <script src="https://code.highcharts.com/modules/funnel3d.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/modules/accessibility.js"></script>
    <script src="https://code.highcharts.com/modules/pyramid3d.js"></script>
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script>
       
            $.ajax({
                type: "POST",
                url: "Report.asmx/GetManufacturerSales",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccessProjectYear,
                error: OnErrorProjectCost
            });
            $.ajax({
                type: "POST",
                url: "Report.asmx/GetManufacturerSalesCancelled",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccessCancelled,
                error: OnErrorCancelled
            });
            $.ajax({
                type: "POST",
                url: "Report.asmx/GetRetailerSales",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: RetailerSuccess,
                error: RetailerFailure
            });
            $.ajax({
                type: "POST",
                url: "Report.asmx/GetRetailerSalesCancelled",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccessRetailCancelled,
                error: OnErrorRetailCancelled
            });
            function OnSuccessRetailCancelled(reponse) {
                var sData = reponse.d;
                var sLabel = sData[0];
                var sDataSet = sData[1];
                var ints = sDataSet.map(parseFloat);

                //Highcharts.chart('container', {
                //    chart: {
                //        zoomType: 'x'
                //    },
                //    title: {
                //        text: 'Manufacturer Sales in Naira'
                //    },
                //    subtitle: {
                //        text: document.ontouchstart === undefined ?
                //            'Click and drag in the plot area to zoom in' : 'Pinch the chart to zoom in'
                //    },
                //    xAxis: {
                //        type: sLabel
                //    },
                //    yAxis: {
                //        title: {
                //            text: 'Manufacturer Sales'
                //        }
                //    },
                //    legend: {
                //        enabled: false
                //    },
                //    plotOptions: {
                //        area: {
                //            fillColor: {
                //                linearGradient: {
                //                    x1: 0,
                //                    y1: 0,
                //                    x2: 0,
                //                    y2: 1
                //                },
                //                stops: [
                //                    [0, Highcharts.getOptions().colors[0]],
                //                    [1, Highcharts.color(Highcharts.getOptions().colors[0]).setOpacity(0).get('rgba')]
                //                ]
                //            },
                //            marker: {
                //                radius: 2
                //            },
                //            lineWidth: 1,
                //            states: {
                //                hover: {
                //                    lineWidth: 1
                //                }
                //            },
                //            threshold: null
                //        }
                //    },

                //    series: [{
                //        type: 'area',
                //        name: 'Sales in Naira',
                //        data: ints
                //    }]
                //});

                Highcharts.chart('containerRetail', {
                    chart: {
                        type: 'column',
                        options3d: {
                            enabled: true,
                            alpha: 10,
                            beta: 25,
                            depth: 70
                        }
                    },
                    title: {
                        text: 'Cancelled Retailer Sales'
                    },
                    subtitle: {
                        text: 'Cancelled Retailer Sales'
                    },
                    plotOptions: {
                        column: {
                            depth: 25
                        }
                    },
                    xAxis: {
                        categories: sLabel,
                        labels: {
                            skew3d: true,
                            style: {
                                fontSize: '16px'
                            }
                        }
                    },
                    yAxis: {
                        title: {
                            text: null
                        }
                    },
                    series: [{
                        name: 'Sales in Naira',
                        data: ints
                    }]
                });


            }
            function OnErrorRetailCancelled(repo) {
                alert(" something went wrong on Sales report, please try later !");
            }
            function OnSuccessProjectYear(reponse) {
                var sData = reponse.d;
                var sLabel = sData[0];
                var sDataSet = sData[1];
                var ints = sDataSet.map(parseFloat);

                //Highcharts.chart('container', {
                //    chart: {
                //        zoomType: 'x'
                //    },
                //    title: {
                //        text: 'Manufacturer Sales in Naira'
                //    },
                //    subtitle: {
                //        text: document.ontouchstart === undefined ?
                //            'Click and drag in the plot area to zoom in' : 'Pinch the chart to zoom in'
                //    },
                //    xAxis: {
                //        type: sLabel
                //    },
                //    yAxis: {
                //        title: {
                //            text: 'Manufacturer Sales'
                //        }
                //    },
                //    legend: {
                //        enabled: false
                //    },
                //    plotOptions: {
                //        area: {
                //            fillColor: {
                //                linearGradient: {
                //                    x1: 0,
                //                    y1: 0,
                //                    x2: 0,
                //                    y2: 1
                //                },
                //                stops: [
                //                    [0, Highcharts.getOptions().colors[0]],
                //                    [1, Highcharts.color(Highcharts.getOptions().colors[0]).setOpacity(0).get('rgba')]
                //                ]
                //            },
                //            marker: {
                //                radius: 2
                //            },
                //            lineWidth: 1,
                //            states: {
                //                hover: {
                //                    lineWidth: 1
                //                }
                //            },
                //            threshold: null
                //        }
                //    },

                //    series: [{
                //        type: 'area',
                //        name: 'Sales in Naira',
                //        data: ints
                //    }]
                //});

                Highcharts.chart('container', {
                    chart: {
                        type: 'column',
                        options3d: {
                            enabled: true,
                            alpha: 10,
                            beta: 25,
                            depth: 70
                        }
                    },
                    title: {
                        text: 'Manufacturer Sales'
                    },
                    subtitle: {
                        text: ' Manufacturer Sales'
                    },
                    plotOptions: {
                        column: {
                            depth: 25
                        }
                    },
                    xAxis: {
                        categories:sLabel,
                        labels: {
                            skew3d: true,
                            style: {
                                fontSize: '16px'
                            }
                        }
                    },
                    yAxis: {
                        title: {
                            text: null
                        }
                    },
                    series: [{
                        name: 'Sales in Naira',
                        data: ints
                    }]
                });


            }
            function OnErrorProjectCost(repo) {
                alert(" something went wrong on Sales report, please try later !");
            }

            function OnSuccessCancelled(reponse) {
                var sData = reponse.d;
                var sLabel = sData[0];
                var sDataSet = sData[1];
                var ints = sDataSet.map(parseFloat);

                //Highcharts.chart('container', {
                //    chart: {
                //        zoomType: 'x'
                //    },
                //    title: {
                //        text: 'Manufacturer Sales in Naira'
                //    },
                //    subtitle: {
                //        text: document.ontouchstart === undefined ?
                //            'Click and drag in the plot area to zoom in' : 'Pinch the chart to zoom in'
                //    },
                //    xAxis: {
                //        type: sLabel
                //    },
                //    yAxis: {
                //        title: {
                //            text: 'Manufacturer Sales'
                //        }
                //    },
                //    legend: {
                //        enabled: false
                //    },
                //    plotOptions: {
                //        area: {
                //            fillColor: {
                //                linearGradient: {
                //                    x1: 0,
                //                    y1: 0,
                //                    x2: 0,
                //                    y2: 1
                //                },
                //                stops: [
                //                    [0, Highcharts.getOptions().colors[0]],
                //                    [1, Highcharts.color(Highcharts.getOptions().colors[0]).setOpacity(0).get('rgba')]
                //                ]
                //            },
                //            marker: {
                //                radius: 2
                //            },
                //            lineWidth: 1,
                //            states: {
                //                hover: {
                //                    lineWidth: 1
                //                }
                //            },
                //            threshold: null
                //        }
                //    },

                //    series: [{
                //        type: 'area',
                //        name: 'Sales in Naira',
                //        data: ints
                //    }]
                //});

                Highcharts.chart('containerCancelled', {
                    chart: {
                        type: 'column',
                        options3d: {
                            enabled: true,
                            alpha: 10,
                            beta: 25,
                            depth: 70
                        }
                    },
                    title: {
                        text: 'Cancelled Manufacturer Sales'
                    },
                    subtitle: {
                        text: 'Cancelled  Manufacturer Sales'
                    },
                    plotOptions: {
                        column: {
                            depth: 25
                        }
                    },
                    xAxis: {
                        categories: sLabel,
                        labels: {
                            skew3d: true,
                            style: {
                                fontSize: '16px'
                            }
                        }
                    },
                    yAxis: {
                        title: {
                            text: null
                        }
                    },
                    series: [{
                        name: 'Sales in Naira',
                        data: ints
                    }]
                });


            }
            function OnErrorCancelled(repo) {
                alert(" something went wrong on Sales report, please try later !");
            }


            function RetailerSuccess(reponse) {
                var sData = reponse.d;
                var sLabel = sData[0];
                var sDataSet = sData[1];
                var ints = sDataSet.map(parseFloat);

                Highcharts.chart('containers', {
                    chart: {
                        type: 'column',
                        options3d: {
                            enabled: true,
                            alpha: 10,
                            beta: 25,
                            depth: 70
                        }
                    },
                    title: {
                        text: 'Retailer Sales'
                    },
                    subtitle: {
                        text: ' Retailer Sales'
                    },
                    plotOptions: {
                        column: {
                            depth: 25
                        }
                    },
                    xAxis: {
                        categories: sLabel,
                        labels: {
                            skew3d: true,
                            style: {
                                fontSize: '16px'
                            }
                        }
                    },
                    yAxis: {
                        title: {
                            text: null
                        }
                    },
                    series: [{
                        name: 'Sales in Naira',
                        data: ints
                    }]
                });


            }
            function RetailerFailure(repo) {
                alert(" something went wrong on Sales report, please try later !");
            }
          
       
    </script>
</asp:Content>

