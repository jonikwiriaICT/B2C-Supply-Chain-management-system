<%@ Page Title="" Language="C#" MasterPageFile="~/SupplyChainMaster.master" AutoEventWireup="true" CodeFile="Manufacturer.aspx.cs" Inherits="Manufacturer" ValidateRequest ="false"  %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <section class="content">

        <div class="row">
            <div class="col-md-7">
                <div id="formView" runat="server">
                    <div class="panel">
                        <div class="panel-heading ">
                            <div class="panel-title ">
                                <h4>Manufacturer Information</h4>
                                <div class="btn-group pull-right ">
                                    <button type="button" class="btn btn-info">Action</button>
                                    <button type="button" class="btn btn-info dropdown-toggle" data-toggle="dropdown">
                                        <span class="caret"></span>
                                        <span class="sr-only">Toggle Dropdown</span>
                                    </button>
                                    <ul class="dropdown-menu" role="menu">
                                        <li>
                                            <asp:LinkButton ID="lnkGoBack" OnClick="ViewRecord" runat="server"><i class=" fa fa-eyedropper"></i>View Record</asp:LinkButton>

                                        </li>

                                    </ul>
                                </div>

                                <br />
                            </div>
                        </div>
                        <div class="panel-body">
                            <div class="box box-primary">
                                <div class="box-body box-profile">

                                    <br />
                                    <br />
                                    <asp:Panel ID="PnlManufacturer" runat="server">
                                        <asp:HiddenField ID="rec_id" runat="server" />

                                        <div class="row">
                                            <div class="col-md-3">
                                                <label style="font-size: 12px">User Type</label>
                                            </div>
                                            <div class="col-md-9">
                                                <asp:DropDownList ID="UserTypeID" CssClass="form-control" runat="server"></asp:DropDownList>

                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-3">
                                                <label style="font-size: 12px">Name</label>
                                            </div>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="first_name" CssClass="form-control" runat="server"></asp:TextBox>

                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-3">
                                                <label style="font-size: 12px">Email</label>
                                            </div>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="email" CssClass="form-control" runat="server"></asp:TextBox>

                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-3">
                                                <label style="font-size: 12px">Telephone No.</label>
                                            </div>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="telephone_no" CssClass="form-control" runat="server"></asp:TextBox>

                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-3">
                                                <label style="font-size: 12px">Country</label>
                                            </div>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="country" CssClass="form-control" runat="server"></asp:TextBox>

                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-3">
                                                <label style="font-size: 12px">State</label>
                                            </div>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="state" CssClass="form-control" runat="server"></asp:TextBox>

                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-3">
                                                <label style="font-size: 12px">Address</label>
                                            </div>
                                            <div class="col-md-9">
                                                <asp:TextBox ID="address" TextMode="MultiLine" Rows="3" CssClass="form-control" runat="server"></asp:TextBox>

                                            </div>
                                        </div>


                                        <div class="row">
                                            <div class="col-md-12">
                                                <asp:LinkButton ID="lnkSaveChanges" OnClick="SaveChangesClicked" CssClass="btn btn-sm btn-primary pull-right  " runat="server"><i class="fa fa-save "></i>&nbsp Save Changes</asp:LinkButton>
                                            </div>
                                        </div>

                                    </asp:Panel>



                                </div>
                            </div>

                        </div>
                    </div>
                </div>

            </div>
            <!-- /.col -->

            <!-- /.col -->
        </div>
        <div class="row">
            <div class="col-md-12">
                <div id="TableView" runat="server">
                    <div class="nav-tabs-custom">
                        <div class="panel ">
                            <div class="panel-heading ">
                                <div class="panel-title ">
                                    <h4>Manufacturer Record</h4>
                                    <div class="btn-group pull-right ">
                                        <button type="button" class="btn btn-info">Action</button>
                                        <button type="button" class="btn btn-info dropdown-toggle" data-toggle="dropdown">
                                            <span class="caret"></span>
                                            <span class="sr-only">Toggle Dropdown</span>
                                        </button>
                                        <ul class="dropdown-menu" role="menu">
                                            <li>
                                                <asp:LinkButton ID="LinkButton1" OnClick="AddNewRecordClicked" runat="server"><i class=" fa fa-plus-circle"></i>Add New Record</asp:LinkButton>

                                            </li>

                                        </ul>
                                    </div>

                                    <br />
                                </div>
                            </div>
                            <div class="panel-body">
                                <div class="box box-primary">
                                    <div class="box-body box-profile">
                                        <div class="table-responsive">
                                            <asp:GridView ID="TableResult" runat="server" Font-Size="10px"
                                                CssClass="table table-bordered table-striped catr" AutoGenerateColumns="true" AllowCustomPaging="true"
                                                OnSelectedIndexChanged="tableChanged" OnRowDeleting="TableDelete"
                                                EmptyDataText="There is no record for the selected item">
                                                <Columns>
                                                    <asp:TemplateField HeaderStyle-Width="7%" HeaderText="Delete Record" Visible="true" HeaderStyle-CssClass=" thead-default" ItemStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Center">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lbDelete" runat="server" Font-Size="14px" CssClass="btn btn-sm btn-danger"
                                                                CausesValidation="False" CommandName="Delete" CommandArgument='<%# Container.DataItemIndex %>'>
                                                    <i class="fa fa-trash"></i>
                                                            </asp:LinkButton>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderStyle-Width="5%" HeaderText="Edit Record" ItemStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Center">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lbSelect" Font-Size="14px" runat="server" CssClass="btn btn-sm btn-info"
                                                                CausesValidation="False" CommandName="Select" CommandArgument='<%# Container.DataItemIndex %>'>
                                                    <i class="fa fa-edit " ></i>
                                                            </asp:LinkButton>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>


                                                </Columns>
                                            </asp:GridView>
                                            <div class="Pager"></div>
                                            <asp:DataList CellPadding="5" RepeatDirection="Horizontal" runat="server" ID="dlPager"
                                                OnItemCommand="dlPager_ItemCommand">
                                                <ItemTemplate>

                                                    <nav class="pagination">
                                                        <ul class="pagination">
                                                            <li class="page-item ">
                                                                <asp:LinkButton Enabled='<%#Eval("Enabled") %>' CssClass="page-link " runat="server" ID="lnkPageNo" Text='<%#Eval("Text") %>' CommandArgument='<%#Eval("Value") %>' CommandName="PageNo"></asp:LinkButton>

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

                        <!-- /.tab-content -->
                    </div>
                </div>
                <!-- /.nav-tabs-custom -->
            </div>
        </div>
        <!-- /.row -->

    </section>

    <div class="modal fade" id="DeleteRecord" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabels"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabels">Delete Record</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <asp:Label ID="Label1" CssClass="text-danger " runat="server" Text="Label"></asp:Label>
                </div>
                <div class="modal-footer bg-whitesmoke br">

                    <asp:LinkButton ID="lnkDelete" CssClass="btn btn-sm btn-danger" OnClick="lbDeleteYes_Click" runat="server"><i class="fa fa-trash"></i>&nbsp Delete</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <script src="floating-whatsapp-master/jquery-3.3.1.min.js"></script>
    <script src="ckeditor/ckeditor.js"></script>
    <script>
        function showDelete() {
            $('#DeleteRecord').modal('show')
        }
    </script>

</asp:Content>

