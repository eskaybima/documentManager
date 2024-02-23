

<%@page import="com.fasyl.util.FormatAmount"%>
<%@page import="com.fasyl.newjobBo.SaveToDb"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>        
        <!-- META SECTION -->
        <title>DAS DEMO - Document Archiving System</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        
        <link rel="icon" href="favicon.ico" type="image/x-icon" />
        <!-- END META SECTION -->
        <%! 
        SaveToDb sb = new SaveToDb();
        String totalAmountPaid = null;
        %>
        <%
            int timeout = session.getMaxInactiveInterval();
            response.setHeader("Refresh", timeout + "; URL =" + request.getContextPath() + "/Login.jsp");
            
            
         totalAmountPaid = sb.getValue2("select sum(nvl(amount,0)) from fas_int_revenue");
         totalAmountPaid = FormatAmount.formatAmount(totalAmountPaid);
        %>
        <jsp:include page="pagesimport.jsp"></jsp:include>
            <!-- END PLUGINS -->



    </head>
    
    <style>
        .blue{
            background: #27007A;
        }
    </style>
    
    <body class="blue" id="background">
        <div class="page-container">
        <jsp:include page="leftMenu.jsp"></jsp:include>
        <div class="page-content">
        <jsp:include page="header.jsp"></jsp:include>
        <!-- START BREADCRUMB 
                <ul class="breadcrumb">
                    <li><a href="#">Home</a></li>                    
                    <li class="active">Dashboard</li>
                </ul>
                END BREADCRUMB --> 
        
        
          <!-- PAGE CONTENT WRAPPER -->
          <br>
          <br>
          <br>
          <br>
                <div class="page-content-wrap" id="main-loader">                      
                
                    <!-- START WIDGETS -->                    
                    <div class="row">
                        <div class="col-md-3">
                            <!-- START WIDGET MESSAGES -->
                            <div class="widget widget-default widget-item-icon">
                                <div class="widget-item-left">
                                    <span class="fa fa-balance-scale"></span>
                                </div>   
                                
                                
                                <div class="widget-data">
                                    <div class="widget-title"><strong>7,067</strong></div>
                                    <div class="widget-title">Registered Individuals</div>
                                    <div class="widget-subtitle">Employed/Self Employed</div>
                                </div>   
                            </div>                            
                            <!-- END WIDGET MESSAGES -->
                            
                        </div>
                        <div class="col-md-3">
                            
                            <!-- START WIDGET MESSAGES -->
                            <div class="widget widget-success widget-item-icon">
                                <div class="widget-item-left">
                                    <span class="fa fa-area-chart"></span>
                                </div>                             
                                <div class="widget-data">
                                    <div class="widget-title"><strong>10,876</strong></div>
                                    <div class="widget-title">Registered Corporate Entities</div>
                                    <div class="widget-subtitle">Companies and Institutions</div>
                                </div> 
                            </div>                            
                            <!-- END WIDGET MESSAGES -->
                            
                        </div>
                        <div class="col-md-3">
                            
                            <!-- START WIDGET REGISTRED -->
                            <div class="widget widget-success widget-item-icon" >
                                <div class="widget-item-left">
                                    <span class="fa fa-bar-chart"></span>
                                </div>
                                <div class="widget-data">
                                    <div class="widget-title"><Strong>N<%= totalAmountPaid%></strong></div>
                                    <div class="widget-title">REVENUE PAID</div>
                                    <div class="widget-subtitle">Amount paid for the current year</div>
                                    
                                     
                                     <li>
                                          <a href="${pageContext.request.contextPath}/pages/showSummaryRev.jsp">Click here for Details</a>
                        
                                   </li>
								   

                                </div>                           
                            </div>                            
                            <!-- END WIDGET REGISTRED -->
                            
                        </div>
                        <div class="col-md-3">

                            <!-- START WIDGET REGISTRED -->
                            <div class="widget widget-danger widget-item-icon">
                                <div class="widget-item-left">
                                    <span class="fa fa-bar-chart"></span>
                                </div>
                                <div class="widget-data">
                                    <div class="widget-title"><Strong>N30,098,908.89</strong></div>
                                    <div class="widget-title">PENDING REVENUE</div>
                                    <div class="widget-subtitle">Amount pending for the current year</div>
                                </div>
                            </div>
                            <!-- END WIDGET REGISTRED -->

                        </div>
                    </div>
                    <!-- END WIDGETS -->                    
                    
                    
                    <div class="row">
                        <div class="col-md-12">
                            <!-- START SALES & EVENTS BLOCK -->
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <div class="panel-title-box">
                                        <h3>Revenue Collection</h3>
                                        <span></span>
                                    </div>
                                    <ul class="panel-controls" style="margin-top: 2px;">
                                        <li><a href="#" class="panel-fullscreen"><span class="fa fa-expand"></span></a></li>
                                        <li><a href="#" class="panel-refresh"><span class="fa fa-refresh"></span></a></li>                                      
                                    </ul>
                                </div>
                             <div class="panel-body padding-0">
                                    <div class="chart-holder" id="dashboard-donut-1" style="height: 220px;"></div>
                                </div>
                                 <div class="panel-body padding-0">
                                    <div class="chart-holder" id="barexample" style="height: 220px;"></div>
                                </div>
                                 <div class="panel-body padding-0">
                                    <div class="chart-holder" id="myfirstchart" style="height: 220px;"></div>
                                </div>
                                  <div class="panel-body padding-0">
                                    <div class="chart-holder" id="area-example" style="height: 220px;"></div>
                                </div>
                            </div>
                            <!-- END SALES & EVENTS BLOCK -->
                            
                        </div>
                    </div>

                </div>
                <!-- END PAGE CONTENT WRAPPER --> 
        
        
        
        <div id="homebody">
           <%--<img src="${pageContext.request.contextPath}/resources/images/nisHome.png" style="width: 101%; height: 109%;"/>--%>
        </div>
     </div>
    </div>
        
                           <script>
            // Morris chart script
            
 /**           
    Morris.Bar({
                element: 'dashboard-bar-1',
                data: [
                    { y: 'Request', a: 5, b: 3 },
                    
                   
                ],
                xkey: 'y',
                ykeys: ['a', 'b'],
                labels: ['Approved Request', 'Declined Request'],
                barColors: ['#7ac218', '#ff7e00'],
                gridTextSize: '10px',
                hideHover: true,
                resize: true,
                gridLineColor: '#E5E5E5'
            });
   **/
  Morris.Donut({
        element: 'dashboard-donut-1',
        data: [
            {label: "Revenue Paid", value: 19.1},
            {label: "Pending Revenue", value: 80.9},
           
        ],
        formatter: function (y) { return y + "%" },
        colors: ['#7ac218', '#471b1b', '#ff7e00'],
        resize: true
    });
        </script>   
            <script>
Morris.Bar({
  element: 'barexample',
  data: [
    { y: '2010', a: 100, b: 90 },
    { y: '2011', a: 75,  b: 65 },
    { y: '2012', a: 50,  b: 40 },
    { y: '2013', a: 75,  b: 65 },
    { y: '2014', a: 50,  b: 40 },
    { y: '2015', a: 75,  b: 65 },
    { y: '2016', a: 85, b: 90 }
  ],
  xkey: 'y',
  ykeys: ['a', 'b'],
  labels: ['Individual', 'Corporate']

});
</script>
<script>
    new Morris.Line({
  // ID of the element in which to draw the chart.
  element: 'myfirstchart',
  // Chart data records -- each entry in this array corresponds to a point on
  // the chart.
  data: [
    { year: '2012', value: 0},
    { year: '2013', value: 10000},
    { year: '2014', value: 15000 },
    { year: '2015', value: 25000 },
    { year: '2016', value: 500000 }
  ],
  // The name of the data record attribute that contains x-values.
  xkey: 'year',
  // A list of names of data record attributes that contain y-values.
  ykeys: ['value'],
  // Labels for the ykeys -- will be displayed when you hover over the
  // chart.
  labels: ['Value']
});
</script>


<script>
    Morris.Area({
  element: 'area-example',
  data: [
    { y: '2006', a: 100, b: 90 },
    { y: '2007', a: 75,  b: 65 },
    { y: '2008', a: 50,  b: 40 },
    { y: '2009', a: 75,  b: 65 },
    { y: '2010', a: 50,  b: 40 },
    { y: '2011', a: 75,  b: 65 },
    { y: '2012', a: 100, b: 90 }
  ],
  xkey: 'y',
  ykeys: ['a', 'b'],
  labels: ['Series A', 'Series B']
});
</script>

   </body>

</html>


