<%
   '************************************************
   'Page dislaying performance of an accelerated incentive
   'program for individual partner companies
   '************************************************
   
   '*** Dev Switch ***
   DIM onDev
   onDev = FALSE
   
   IF OnDev THEN
      response.Buffer = TRUE
      ON ERROR RESUME NEXT
   END IF
   
   '**** program specific variables ****
   DIM lowerBonusIncentive, upperBonusIncentive, payout, bonusPayout, AcceleratorMinDevices, WebPageName
   DIM AjaxName
   '**********************************
   IF OnDev THEN 
      WebPageName = "devPartnerInsightAccel"
      AjaxName    = "devajaxPartnerInsight"
   ELSE
      WebPageName = "PartnerInsightAccel"
      AjaxName    = "ajaxPartnerInsight"
   END IF
   '**********************************
   lowerBonusIncentive  = 80  'Percent
   upperBonusIncentive  = 150 'Percent
   AcceleratorMinDevices = 10 'Number of devices to qualify for accelerator
   '**********************************
   payout      = 2 'Dollars
   bonusPayout = 6 'Dollars
   '**********************************
   'IF Session("includeCompeteData") = "" THEN
   '   Session("includeCompeteData") = "NO" 'T or F
   'END IF
   IF Session("includeSpecialDevice1Data") = "" THEN
      Session("includeSpecialDevice1Data")  = "NO" 'T or F
   END IF
   'IF Session("includeSpecialDevice1DataHistoric") = "" THEN
   '   Session("includeSpecialDevice1DataHistoric")     = "NO" 'T or F
   'END IF
   '**********************************
   ' Returns the smallest integer greater than or equal to the specified number.
   FUNCTION ceil(x)
      DIM temp
      temp = Round(x)
      IF temp < x THEN
         temp = temp + 1
      END IF
      ceil = temp
   END FUNCTION
   
  DIM connection,recordSet,sSql
   SET connection = server.CreateObject ("ADODB.Connection")
   SET recordSet = Server.CreateObject ("ADODB.RecordSet")
   connection.ConnectionTimeout = 300
   
   connection.Open = "Provider=SQLOLEDB;Data Source=Server1;Initial Catalog=Project1;uid=WebReportsUser;pwd=Pa$$word;"
 
   server.ScriptTimeout=300
   connection.CommandTimeOut=300
   server.ScriptTimeout=10000000

   DIM strName, sArrayLogon, sMessage
   strName = request.servervariables("logon_user")
   sMessage=""

   sArrayLogon=Split(strName, "\", -1, 1)
   strName = sArrayLogon(1)
   
   IF Session("UserSubsidiary") = "" THEN
      x = 0
      Session("UserSubsidiary") = "''"
      sSql = " SELECT * FROM Project1.dbo.LOEM_Project1_AreaPermissions WHERE UserAlias='" & strName & "' "
      
      recordSet.Open sSql, connection
      DO WHILE recordSet.BOF OR NOT recordSet.EOF
         Session("UserSubsidiary") = Session("UserSubsidiary") & ",'" & recordSet("SubsidiaryID") & "'"
         IF recordSet("SpecialDevice1") = 1 THEN
            Session("includeSpecialDevice1Data") = "YES"
         END IF
         Session("UserMNA") = recordSet("MNA")
         x = x + 1
         recordSet.MoveNext
      LOOP
      recordSet.Close
      
      'Update Last Updated Prompt
      sSql = " SELECT * FROM Project1.dbo.UIDynamic WHERE PageName='All' "
      
      recordSet.Open sSql, connection
      IF recordSet.BOF OR NOT recordSet.EOF THEN
         Session("LastUpdated") = recordSet("DynVal2")
      END IF
      recordSet.Close
      
      Session("txtPermission") = "You are logged in as " & strName & ", SpecialDevice1= " & Session("includeSpecialDevice1Data")&", MNA= " & Session("UserMNA") & ", Geo= " 
      
      IF x > 70 THEN
         Session("txtPermission") = Session("txtPermission") & "ALL"
      ELSE
         Session("txtPermission") = Session("txtPermission") & "Limited"
      END IF
      Session("txtPermission") = Session("txtPermission") & ", Last Updated: " & Session("LastUpdated")

      IF Session("UserSubsidiary") = "" THEN
         response.Redirect "NotAllowed.asp"
      END IF
   END IF
   
   IF OnDev THEN
      ''Session("UserSubsidiary") = "ALL"
   END IF
%>
<!DOCTYPE HTML>
<html>
<head>
   <meta http-equiv="X-UA-Compatible" content="IE=edge" />
   <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
   <script src='http://d3js.org/d3.v3.min.js'></script>
   <script src='Utils/JQuery2.1.4/jquery-2.1.4.min.js'></script>
   <!--**************************** ********************* ****************************-->
   
   <title>PI | Accelerator</title>
   <link rel="stylesheet" href="ProjectStyle.css"/>
   <link rel='icon' type='image/ico' href='favicon1.ico'>
   <div>
      <div>
         <img src="images/SoftMicro.jpg" alt="SoftMicro"/>
      </div>
      <div>
         <%= Session("txtPermission") %>
      </div>
   </div>
   
   <h1>
      Partner Insight Accelerator
   </h1>
</head>
<body>
<form name='frmMixProgression' action='<%= WebPageName %>.asp' method='post'>

<input type='hidden' id='hidValue' name='hidValue' value='<%=request("hidValue")%>'/>
<input type='hidden' id='hidAction' name='hidAction' value='<%=request("hidAction")%>'/>
<input type='hidden' id='hidCountry' name='hidCountry' value='<%=request("hidCountry")%>'/>

<!--Disti select - DistiID, DistiName-->
<select id='DistiSelect' name='DistiSelect' onkeydown="if (event.keyCode == 13) document.getElementById('btnGo').click()">
   <option value='none' selected disabled>Select Distributor</option>
   <% 
      sSQL = " SELECT DISTINCT [DistiSoldToID], [DistiName], [DistiCountryCode] "
      sSQL = sSql & " FROM Project1.dbo.FY16H1_EXPORT(NOLOCK) "
      sSQL = sSql & " LEFT JOIN Project1.dbo.PartnerGoals(NOLOCK) "
      sSQL = sSql & " ON DistiSoldToId = id "
      sSQL = sSql & " INNER JOIN Project1.dbo.Country(NOLOCK) "
      sSQL = sSql & " ON CountryCode = DistiCountryCode "
      sSQL = sSql & " WHERE SubsidiaryID IN (" & Session("UserSubsidiary") & ") "
      IF Session("UserMNA") <> "ALL" THEN
         sSQL = sSql & " AND OEM = '" & Session("UserMNA") & "' "
      END IF
      sSQL = sSql & " ORDER BY [DistiName]; "
      
      recordSet.Open sSql, connection
      DO WHILE recordSet.BOF OR NOT recordSet.EOF
      IF CSTR(recordSet("DistiSoldToID")) = CSTR(request.form("hidValue")) THEN
         response.write "<option value='" & recordSet("DistiSoldToID") & "' selected>" & Server.HTMLEncode(recordSet("DistiName")) & " - " & recordSet("DistiSoldToID") & " - " & recordSet("DistiCountryCode") & "</option>"
      ELSE
         response.write "<option value='" & recordSet("DistiSoldToID") & "'>" & Server.HTMLEncode(recordSet("DistiName")) & " - " & recordSet("DistiSoldToID") & " - " & recordSet("DistiCountryCode") & "</option>"
      END IF
      recordSet.MoveNext
      LOOP
      recordSet.Close
   %>
</select>
<input id='btnGo' type='button' onclick='fnDistiClick()' value='Go'/>&nbsp&nbsp&nbsp

<br>
<h3 id='CompanyName'></h3>
<br>
<div id='MainContainer' class='Container'>
   <div id='BottomContainerTitle'>Month over Month Unit and Accelerator Performance</div>
   <div id='BottomContainer'>
   <div id='TrendGraphContainer' class='Half'>
      <div id='Waterfall'>
         <svg class='chart'></svg>
      </div>
   </div>
   <div id='AccrualPotentialContainer' class='Half'>
      <div class='Whole'>
         <table id='AccrualToDateTable'>
            <tr>
               <th colspan='3' class='dataTitle'>To Date Performance</th>
            </tr>
            <tr>
               <th></th>
               <th>Units</th>
               <th>Total</th>
            </tr>
            <tr id='AccrualOption2PT'>
               <td>OS 2x/3 Professional <b>with</b> Touch Accrual (x$2)</td>
               <td id='OsProTouchUnits'></td>
               <td id='OsProTouchTotal'></td>
            </tr>

            <tr id='AccrualOption2P'>
               <td>OS 2x/3 Professional with <b>No</b> Touch Accrual (x$2)</td>
               <td id='Os2ProUnits'></td>
               <td id='Os2ProTotal'></td>
            </tr>
            <tr id='AccrualOption1P'>
               <td>OS 1 Professional with <b>No</b> Touch Accrual (x$2)</td>
               <td id='Os1ProUnits'></td>
               <td id='Os1ProTotal'></td>
            </tr>
            <tr>
               <td>Per Unit Accelerator Actual Accrual</td>
               <td id='AccelAccrualUnits'></td>
               <td id='AccelAccrualTotal'></td>
            </tr>
            <tr>
               <td>Total Preliminary Accrual</td>
               <td id='PrelimUnits'></td>
               <td id='PrelimTotal'></td>
            </tr>
         </table>
      </div>
      <div class='Whole'>
         <table id='AccrualPotentialTable'>
            <tr>
               <th colspan='3' class='dataTitle'>Accruals Potential</th>
            </tr>
            <tr>
               <th></th>
               <th>Units</th>
               <th>Total</th>
            </tr>
            <tr>
               <td>Min Potential <%= lowerBonusIncentive %>% Sales</td>
               <td id='MinPotentialUnits'></td>
               <td id='MinPotentialTotal'></td>
            </tr>
            <tr>
               <td colspan='3' class='PotDesc'>
                  This represents the $2 base incentive Only
               </td>
            </tr>
            <tr>
               <td>Max Potential <%= upperBonusIncentive %>% Sales</td>
               <td id='MaxPotentialUnits'></td>
               <td id='MaxPotentialTotal'></td>
            </tr>
            <tr>
               <td colspan='3' class='PotDesc'>
                  This represents the $2 base incentive plus the $4 accelerator bonus
               </td>
            </tr>
         </table>
      </div>
   </div>
   </div>
</div>

<script language='JavaScript' type='text/JavaScript'>
   //Test Alert
   //console.log("<%= Session("UserSubsidiary") %>");
   
   if(document.getElementById('DistiSelect').value == 'none') {
      document.getElementById('MainContainer').style.visibility='hidden';
   }
   else {
      document.getElementById('MainContainer').style.visibility='visible';
      document.getElementById('CompanyName').innerHTML = 
         document.getElementById('DistiSelect').options[document.getElementById('DistiSelect').selectedIndex].text;
   }
   
   function fnDistiClick() {
      if (document.getElementById('DistiSelect').value != 'none') {
         document.frmMixProgression.hidAction.value='SelectDisti';
         document.frmMixProgression.hidValue.value=document.getElementById('DistiSelect').value;
         //document.frmMixProgression.hidCountry.value=document.getElementById('CountrySelect').value;
         document.frmMixProgression.submit();
      }
   }

   function fnCountrySelected() {
      var str = document.getElementById('CountrySelect').value;
      var newOptions;
      
      $.ajax({
         url: 'Ajax/<%= AjaxName %>.asp?grab=countryPI&id=' + str,
         complete: function(result){
         newOptions = result;
         
         $('#DistiSelect option:gt(0)').remove();
         var $el = $("#DistiSelect");
         $.each(newOptions, function(value,key) {
            $el.append($("<option></option>")
            .attr("value", value).text(key));
         });
      }});
      
   }
   
   function fnFormatData(perData, strLabel) {
      return "<span style='font-size:12Px;font-weight:500;'>" + perData + 
             "%</span><br><span style='font-size:12px;'>" + strLabel + "</span>"
   }
</script>

<%
DIM totOs2PROT, totOs2PRO, totOs1PRO, DeviceGoal, PrevAvg
IF request.form("hidAction")="SelectDisti" THEN
   'arrMonths to hold Months for bar graph, strYear = current year
   DIM arrMonths(5), strYear, specCountry
   
   sSql = " SELECT DistiSoldToId, InvoiceDate, DistiCountryCode, "
         sSql = sSql & " SUM(CASE WHEN  OS = 'OS 1 Pro' AND Touch = 'Y'  THEN QTYSold ELSE 0 END)                           AS [Os1PROT], "
         sSql = sSql & " SUM(CASE WHEN  OS = 'OS 1 Pro' AND Touch = 'N'  THEN QTYSold ELSE 0 END)                           AS [Os1PRO], "
         sSql = sSql & " SUM(CASE WHEN (OS = 'OS 2' OR OS = 'OS 2.1') AND Touch = 'Y' THEN QTYSold ELSE 0 END)         AS [Os2T], "
         sSql = sSql & " SUM(CASE WHEN (OS = 'OS 2' OR OS = 'OS 2.1')  AND Touch = 'N'THEN QTYSold ELSE 0 END)         AS [Os2], "
         sSql = sSql & " SUM(CASE WHEN OS LIKE 'OS 2%' AND SoftMicroReportableSKU = 'WN7-01627' THEN QTYSold ELSE 0 END)    AS [Os2PROT], "
         sSql = sSql & " SUM(CASE WHEN (OS = 'OS 2 PRO' OR OS = 'OS 2.1 PRO')  AND Touch = 'N'THEN QTYSold ELSE 0 END) AS [Os2PRO], "
         sSql = sSql & " SUM(CASE WHEN  OS = 'OS 3' AND Touch = 'Y'  THEN QTYSold ELSE 0 END)                              AS [Os3T], "
         sSql = sSql & " SUM(CASE WHEN  OS = 'OS 3' AND Touch = 'N'  THEN QTYSold ELSE 0 END)                              AS [Os3], "
         sSql = sSql & " SUM(CASE WHEN  OS LIKE 'OS 3%' AND SoftMicroReportableSKU = 'WN7-01627' THEN QTYSold ELSE 0 END)  AS [Os3PROT], "
         sSql = sSql & " SUM(CASE WHEN  OS = 'OS 3 PRO' AND Touch = 'N' THEN QTYSold ELSE 0 END)                           AS [Os3PRO] "
         sSql = sSql & " FROM Project1.dbo.FY16H1_EXPORT(NOLOCK) "
         sSql = sSql & " INNER JOIN Project1.dbo.Country(NOLOCK) "
         sSql = sSql & " ON DistiCountryCode = CountryCode "
         sSql = sSql & " WHERE DistiSoldToID = '" & CSTR(request.form("hidValue")) & "' "
         IF Session("includeSpecialDevice1Data") = "NO" THEN
            sSql = sSql & " AND OEM <> 'SoftMicro' "
         END IF
         IF Session("UserMNA") <> "ALL" THEN
            sSql = sSql & " AND OEM = '" & Session("UserMNA") & "' "
         END IF
         sSql = sSql & " AND SubsidiaryID IN (" & Session("UserSubsidiary") & ") "
         sSql = sSql & " AND (OS LIKE 'OS 1' "
         sSql = sSql & " OR OS LIKE 'OS 1 Pro' "
         sSql = sSql & " OR OS LIKE 'OS 2' "
         sSql = sSql & " OR OS LIKE 'OS 2 PRO' "
         sSql = sSql & " OR OS LIKE 'OS 2.1' "
         sSql = sSql & " OR OS LIKE 'OS 2.1 PRO' "
         sSql = sSql & " OR OS LIKE 'OS 3' "
         sSql = sSql & " OR OS LIKE 'OS 3 PRO') "
         sSQL = sSql & " AND TOUCH IS NOT NULL "
         sSQL = sSql & " AND FormFactor NOT LIKE 'Desktop' "
         sSql = sSql & " GROUP BY DistiSoldToId, InvoiceDate, DistiCountryCode "
         sSql = sSql & " ORDER BY InvoiceDate DESC "
   'response.write sSql
    
      DIM placeHolder, Os1PROT(5), Os1PRO(5), Os2T(5), Os2(5), Os2PROT(5), Os2PRO(5), Os3(5), Os3T(5), Os3PRO(5), Os3PROT(5)
      DIM placeCounter, totOs1PROT, totOs2T, totOs2, totOs3, totOs3T, totOs3PRO, totOs3PROT, MinDate, MaxDate, testDate
      
      recordSet.Open sSql, connection
   
      strYear = LEFT(recordSet("InvoiceDate"), 4)
      specCountry = recordSet("DistiCountryCode")
      
      IF CDATE(LEFT(recordSet("InvoiceDate"), 4) & "-" & MID(recordSet("InvoiceDate"), 5,2) & "-" & RIGHT(recordSet("InvoiceDate"), 2)) < CDATE("July 1, " + strYear) THEN
         arrMonths(0) = "Jan"
         arrMonths(1) = "Feb"
         arrMonths(2) = "Mar"
         arrMonths(3) = "Apr"
         arrMonths(4) = "May"
         arrMonths(5) = "Jun"
      ELSE
         arrMonths(0) = "Jul"
         arrMonths(1) = "Aug"
         arrMonths(2) = "Sep"
         arrMonths(3) = "Oct"
         arrMonths(4) = "Nov"
         arrMonths(5) = "Dec"
      END IF
      
      MinDate = recordSet("InvoiceDate")
      MaxDate = recordSet("InvoiceDate")
      
      DO WHILE recordSet.BOF OR NOT recordSet.EOF
      testDate =  MID(recordSet("InvoiceDate"), 5, 2)
      'Determine if dates are 1st or second half of year
         IF testDate >= 1 _
            AND testDate <= 6 THEN
            placeHolder = testDate - 1
         ELSEIF testDate >= 7 _
            AND testDate <= 12 THEN
            placeHolder = testDate - 7
         END IF
         Os1PROT(placeHolder)  = Os1PROT(placeHolder)  + recordSet("Os1PROT")
         Os1PRO(placeHolder)   = Os1PRO(placeHolder)   + recordSet("Os1PRO")
         Os2T(placeHolder)     = Os2T(placeHolder)     + recordSet("Os2T")
         Os2(placeHolder)      = Os2(placeHolder)      + recordSet("Os2") 
         Os2PROT(placeHolder)  = Os2PROT(placeHolder)  + recordSet("Os2PROT")
         Os2PRO(placeHolder)   = Os2PRO(placeHolder)   + recordSet("Os2PRO")
         Os3T(placeHolder)    = Os3T(placeHolder)    + recordSet("Os3T")
         Os3(placeHolder)     = Os3(placeHolder)     + recordSet("Os3") 
         Os3PROT(placeHolder) = Os3PROT(placeHolder) + recordSet("Os3PROT")
         Os3PRO(placeHolder)  = Os3PRO(placeHolder)  + recordSet("Os3PRO")
         
         If recordSet("InvoiceDate") < MinDate THEN
            MinDate = recordSet("InvoiceDate")
         END IF
         IF recordSet("InvoiceDate") > MaxDate THEN
            MaxDate = recordSet("InvoiceDate")
         END IF
         recordSet.MoveNext
      LOOP
      recordSet.Close
      
      FOR placeCounter = 0 TO 5
         totOs1PROT  = totOs1PROT  + Os1PROT(placeCounter)
         totOs1PRO   = totOs1PRO   + Os1PRO(placeCounter)
         totOs2T     = totOs2T     + Os2T(placeCounter)
         totOs2      = totOs2      + Os2(placeCounter)
         totOs2PROT  = totOs2PROT  + Os2PROT(placeCounter)
         totOs2PRO   = totOs2PRO   + Os2PRO(placeCounter)
         totOs3T    = totOs3T    + Os3T(placeCounter)
         totOs3     = totOs3     + Os3(placeCounter)
         totOs3PROT = totOs3PROT + Os3PROT(placeCounter)
         totOs3PRO  = totOs3PRO  + Os3PRO(placeCounter)
      NEXT
      
      'GET Goal
      sSql = " SELECT Goal "
      sSql = sSql & " FROM Project1.dbo.PartnerGoals "
      sSql = sSql & " WHERE id = '" & CSTR(request.form("hidValue")) & "' "
      
      PrevAvg = 1
      
      recordSet.Open sSql, connection
      
      IF recordSet.BOF OR NOT recordSet.EOF THEN
         PrevAvg = CDBL(recordSet("Goal"))
      END IF
      
      recordSet.Close
         
      response.write "<script language='javascript' type='text/javascript'>"
      
      response.write "document.getElementById('AccrualOption2PT').style.display = 'table-row';"
      IF specCountry = "BRA" OR specCountry = "CHN" OR specCountry = "RUS" THEN
         response.write "document.getElementById('AccrualOption2P').style.display = 'table-row';"
         IF specCountry = "CHN" THEN
            response.write "document.getElementById('AccrualToDateTable').style.display = 'table-row';"
         ELSE
         response.write "document.getElementById('AccrualToDateTable').deleteRow(document.getElementById('AccrualOption1P').rowIndex);"
         END IF
      ELSE
         response.write "document.getElementById('AccrualToDateTable').deleteRow(document.getElementById('AccrualOption2P').rowIndex);"
         response.write "document.getElementById('AccrualToDateTable').deleteRow(document.getElementById('AccrualOption1P').rowIndex);"
      END IF
      
      'Creating Data Variable for Bar Graph
      response.write "var data = ["
      FOR placeCounter = 0 TO 5 - 1
         response.write "{month: '" & arrMonths(placeCounter) & "', deviceQty: +'" & _
            (Os2PROT(placeCounter) + Os3PROT(placeCounter)) & "'},"
      NEXT
      response.write "{month: '" & arrMonths(5) & "', deviceQty: +'" & _
            (Os2PROT(5) + Os3PROT(5)) & "'}];"
      
      response.write "</script>"
      
      DeviceGoal = ceil(upperBonusIncentive * CDBL(PrevAvg) / 100) - ceil(lowerBonusIncentive * CDBL(PrevAvg) / 100)
ELSE
   totOs2PROT = 0
   totOs2PRO = 0
   totOs1PRO = 0
   DeviceGoal = 0
   PrevAvg = 0
END IF
%>
<script>
   var Total2ProT = <%= totOs2PROT + totOs3PROT %>;
   var Total2Pro  = <%= totOs2PRO %>;
   var Total1Pro  = <%= totOs1PRO %>;
   var TotalDevices = 0;
   var DeviceGoal   = Math.ceil(<%= DeviceGoal %>);
   var PrevAvg    = <%= PrevAvg %>;
   var country    = '<%= specCountry %>';
   var lowerBonusIncentive = <%= lowerBonusIncentive %> / 100;
   var upperBonusIncentive = <%= upperBonusIncentive %> / 100;
   var accelMinDevices = <%= AcceleratorMinDevices %>;
   var payout = <%= payout %>;
   var bonusPayout = <%= bonusPayout %>;
   var moneyFormat = d3.format("$,.2")
   var numberFormat = d3.format(" ,.0f")
   var comparePercent = 0;
   
   if (country != 'BRA' && country != 'CHN' &&  country != 'RUS'){                     // Normal
      TotalDevices = Total2ProT;
   }
   else {
      if (country != 'CHN') {                                                           // Not China
      TotalDevices = (Total2ProT + Total2Pro);
      }
      else {
      TotalDevices = (Total2ProT + Total2Pro + Total1Pro);
      }
   }
   
function createGraph(data){
   
   var invertLimit = .055; //Before percent
   
   var margin = {top: 75, right: 30, bottom: 30, left: 40},
      width = 600 - margin.left - margin.right,
      height = 400 - margin.top - margin.bottom,
      padding = 0.2;

   var x = d3.scale.ordinal()
      .rangeRoundBands([0, width], padding);

   var y = d3.scale.linear()
      .range([height, 0]);

   var xAxis = d3.svg.axis()
      .scale(x)
      .orient('bottom');

   var yAxis = d3.svg.axis()
      .scale(y)
      .orient('left')
      .tickFormat(TotalDevices / PrevAvg <= 0.5 ? d3.format(",.1%") : d3.format(",.0%"));

   // Creating chart with axes
   var chart = d3.select('.chart')
      .attr('width', width + margin.left + margin.right)
      .attr('height', height + margin.top + margin.bottom)
   .append('g')
      .attr('transform', 'translate(' + margin.left + ',' + margin.top + ')');

   // Transform data (i.e., finding cumulative values and total) for easier charting
   var cumulative = 0;
   var cumulativeDevices = 0;
   for (var i = 0; i < data.length; i++) {
      data[i].start = cumulative;
      cumulative += (data[i].deviceQty / PrevAvg);
      data[i].end = cumulative;
      data[i].isLast = i==data.length - 1 ? true : false;

      cumulativeDevices += data[i].deviceQty;
      data[i].cumulativeDevices = cumulativeDevices;
      
      data[i].class = ( data[i].deviceQty >= 0 ) ? 'positive' : 'negative';
   }
   
   x.domain(data.map(function(d) { return d.month; }));
   y.domain([0, d3.max(data, function(d) { return d.end; })]);

   chart.append('g')
         .attr('class', 'x axis')
         .attr('transform', 'translate(0,' + height + ')')
         .call(xAxis);

   chart.append('g')
         .attr('class', 'y axis')
         .call(yAxis);

   // Adding highlighted region - must be before bars
   chart.filter(function(d) { return (y.domain()[1] > lowerBonusIncentive && (TotalDevices >= accelMinDevices)); }).append('rect')
         .attr('y', y(Math.min(y.domain()[1], upperBonusIncentive)))
         .attr('x', padding)
         .attr('width', width - (1 - padding))
         .attr('height', Math.abs(y(Math.min(y.domain()[1], upperBonusIncentive)) - y(lowerBonusIncentive)))
         .attr('class', 'barBg');

   // Adding bars to chart
   var bar = chart.selectAll('.bar')
         .data(data)
      .enter().append('g')
         .attr('class', function(d) { return 'bar ' + d.class; })
         .attr('transform', function(d) { return 'translate(' + x(d.month) + ',0)'; });

   bar.append('rect')
         .attr('y', function(d) { return y( Math.max(d.start, d.end) ); })
         .attr('height', function(d) { return Math.abs( y(d.start) - y(d.end) ); })
         .attr('width', x.rangeBand());
   
   // chart title
   chart.append('text')
      .attr('x', (width + (margin.left + margin.right) )/ 2)
      .attr('y', 0 - (margin.top / 2))
      .attr('text-anchor', 'middle')
      .attr('class', 'dataTitle')
      .text('Eligible Units');

   // Add Device Count inside bars
   bar.filter(function(d) { return d.end != 0; }).append('text')
         .attr('x', x.rangeBand() / 2)
         .attr('y', function(d) { return ((d.end - d.start)/cumulative)<=invertLimit ? y(d.end) - 15 : y(d.end) + 5; })
         .attr('class', function(d) { return (d.end - d.start)/cumulative<=invertLimit ? 'above' : 'below'; })
         .attr('dy', function(d) { return ((d.class=='negative') ? '-' : '') + '.75em'; })
         .text(function(d) { return numberFormat(d3.round(d.deviceQty));});

   // Add Cumulative Devices above bars
   bar.filter(function(d) { return d.end != 0; }).append('text')
         .attr('x', x.rangeBand() / 2)
         .attr('y', function(d) { 
               return ((d.end - d.start)/cumulative)<=invertLimit ? y(d.end) - 30 : y(d.end) - 15; })
         .attr('class', function(d) { return 'above'; })
         .attr('dy', function(d) { return ((d.class=='negative') ? '-' : '') + '.75em'; })
         .text(function(d) { return numberFormat(d.cumulativeDevices);});

   //Line between bars
   bar.filter(function(d) { return (!d.isLast && d.end != 0); }).append('line')
         .attr('class', 'connector')
         .attr('x1', x.rangeBand() + 5 )
         .attr('y1', function(d) { return y(d.end); } )
         .attr('x2', x.rangeBand() / ( 1 - padding) - 5 )
         .attr('y2', function(d) { return y(d.end); } );
         
   comparePercent = cumulative;
}

function calcAccruals(data) {

   var accelAccrualUnits = (comparePercent < lowerBonusIncentive ? //No incentive, below min percent
         0 : (comparePercent < upperBonusIncentive ? //Incentive calculation
            ((comparePercent - lowerBonusIncentive) * PrevAvg) : ((upperBonusIncentive - lowerBonusIncentive) * PrevAvg)));
   accelAccrualUnits = Math.ceil(accelAccrualUnits);
   var accelAccrualTotal = accelAccrualUnits * (bonusPayout - payout);
   
   document.getElementById('OsProTouchUnits').innerHTML = numberFormat(Total2ProT);
   document.getElementById('OsProTouchTotal').innerHTML = moneyFormat(Total2ProT * payout);
   if (document.getElementById('AccrualOption2P')) {
      document.getElementById('Os2ProUnits').innerHTML = numberFormat(Total2Pro);
      document.getElementById('Os2ProTotal').innerHTML = moneyFormat(Total2Pro * payout);
   }
   if (document.getElementById('AccrualOption1P')) {
      document.getElementById('Os1ProUnits').innerHTML = numberFormat(Total1Pro);
      document.getElementById('Os1ProTotal').innerHTML = moneyFormat(Total1Pro * payout);
   }
   document.getElementById('AccelAccrualUnits').innerHTML = numberFormat(accelAccrualUnits);
   document.getElementById('AccelAccrualTotal').innerHTML = moneyFormat(accelAccrualTotal);
   document.getElementById('PrelimUnits').innerHTML = numberFormat(TotalDevices);
   document.getElementById('PrelimTotal').innerHTML = moneyFormat((TotalDevices * payout) + accelAccrualTotal);
   
   PrevAvg = Math.ceil(PrevAvg * lowerBonusIncentive);
   
   document.getElementById('MinPotentialUnits').innerHTML = numberFormat(PrevAvg);
   document.getElementById('MinPotentialTotal').innerHTML = moneyFormat(PrevAvg * payout);
   document.getElementById('MaxPotentialUnits').innerHTML = numberFormat(PrevAvg + DeviceGoal);
   document.getElementById('MaxPotentialTotal').innerHTML = moneyFormat((PrevAvg * payout) + (DeviceGoal * bonusPayout));
}

if (document.getElementById('DistiSelect').value != 'none') {
   createGraph(data);
   calcAccruals(data);
}
document.getElementById('DistiSelect').focus();
</script>
</form>
<%

   ' Error Handler
   If Err.Number <> 0 Then
 
      ' Clear response buffer
      Response.Clear
            
      ' Display Error Message to user	
 %>
   <HTML>
 
   <HEAD>
   <TITLE></TITLE>
   </HEAD>
 
   <BODY BGCOLOR="#C0C0C0">
 
   <FONT FACE="ARIAL">An error occurred in the execution of this ASP page<BR><P>
   <%
      '	Action sensitive to error
      Select Case Err.Number
 
 		Case ""		'	Specific error messages
 		'	Placeholder for specific error message code
      '	You can handle custom errors here	
 
      Case Else		'	General Error Response
 
 		If IsObject(objConnection) Then
 	
         If objConnection.Errors.Count > 0 Then
   %>

   <B>Database Connection Object</B>
 
   <%					For intLoop = 0 To objConnection.Errors.Count - 1	%>
 
   Error No: <%= objConnection.Errors(intLoop).Number %><BR>
   Description: <%= objConnection.Errors(intLoop).Description %><BR>

   Source: <%= objConnection.Errors(intLoop).Source %><BR>
   SQLState: <%= objConnection.Errors(intLoop).SQLState %><BR>
   NativeError: <%= objConnection.Errors(intLoop).NativeError %><P>
 
   <%					Next
 			End If
 
 		End If
 
      If Err.Number <> 0 Then
   %>

 
   <B>Page Error Object</B><BR>
   Error Number: <%= Err.Number %><BR>
   Error Description: <%= Err.Description %><BR>	
   Source: <%= Err.Source %><BR><BR>

 	LineNumber: <%= Err.Line %><P><BR><BR>
   <p><%= Err.ToString %></p>   
 
   </FONT>
 
   </BODY>
   </HTML>
<%		End If
 
 	End Select
 End If
%>
<%
   Response.End()
   set recordSet = nothing
   set connection = nothing
%>
</body>
</html>