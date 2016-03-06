<%
   '************************************************
   'Page summarizing sales data reported from partners
   'and comparing the results against other factors
   '************************************************

   '*** Dev Switch ***
   DIM onDev
   onDev = FALSE
   
   IF onDev THEN
      'Comment out for production
      response.Buffer = TRUE
      ON ERROR RESUME NEXT
   END IF
   
   DIM WebPageName, SpecialPartnerList, AjaxName
   '**********************************
   IF OnDev THEN 
      WebPageName = "devCompeteDataReport"
      AjaxName    = "devgetResellerCountry"
   ELSE
      WebPageName = "CompeteDataReport"
      AjaxName    = "getResellerCountry"
   END IF
   '**********************************
   SpecialPartnerList = "'0001','0002','0003','0004','0005','0006','0007','0008','0009','0010','0011','0012','0013'"
   
   DIM connection,recordSet,sSql
   SET connection = server.CreateObject ("ADODB.Connection")
   SET recordSet = Server.CreateObject ("ADODB.RecordSet")
   connection.ConnectionTimeout = 300
   
   connection.Open = "Provider=SQLOLEDB;Data Source=Server1;Initial Catalog=Project2;uid=WebReportsUser;pwd=Pa$$word;"
 
   server.ScriptTimeout=300
   connection.CommandTimeOut=300
   server.ScriptTimeout=10000000
   
   DIM strName, sArrayLogon
   strName = request.servervariables("logon_user")

   sArrayLogon=Split(strName, "\", -1, 1)
   strName=sArrayLogon(1)
   
   sSQL =        " SELECT SecurityValue, DateExpires "
   sSql = sSql & " FROM Project1.dbo.WebpageSecurity(NOLOCK) "
   sSql = sSql & " WHERE PageName LIKE '" & WebPageName & "' "
   sSql = sSql & " AND UserName LIKE '" & strName & "'; "
   
   DIM nUserAccess, sUser, sArray
   nUserAccess=-1

 
   DIM arrUsers(4)
   arrUsers(0) = "user1,3"
   arrUsers(1) = "user2,3"
   arrUsers(2) = "user3,3"
   arrUsers(3) = "user4,3"
   arrUsers(4) = "user5,3"



   FOR EACH sUser in arrUsers
      sArray=Split(sUser, ",", -1, 1)


      IF strName=sArray(0) THEN
      nUserAccess=sArray(1)
      END IF
   Next

   IF nUserAccess=-1 THEN
      response.Redirect "/NotAllowed.asp"
   END IF
   
   DIM arrMonths(8), counter, NumMonths
   counter = 0
   
   sSql = "SELECT DISTINCT [Invoice Date] AS InvDate "
   sSql = sSql & "FROM Project2.dbo.vw_competeData(NOLOCK) "
   sSql = sSql & "WHERE [Invoice Date] >= DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()), 0) "
   IF CSTR(request.form("hidReseller")) <> "" AND CSTR(request.form("hidReseller")) <> "none" THEN
      sSql = sSql & "AND TPID = '" & CSTR(request.form("hidReseller")) & "' "
   END IF
   sSql = sSql & "ORDER BY [Invoice Date] "
   
   recordSet.Open sSql, connection
   DO WHILE (recordSet.BOF OR NOT recordSet.EOF) AND counter <= UBOUND(arrMonths) + 1
      arrMonths(counter) = recordSet("InvDate")
      counter = counter + 1
      recordSet.MoveNext
   LOOP
   recordSet.Close
   
   NumMonths = counter
   
%>
<!DOCTYPE HTML>
<html>
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
   <meta http-equiv="X-UA-Compatible" content="IE=edge" />
   <script src='Utils/JQuery2.1.4/jquery-2.1.4.min.js'></script>
   <style>
      table {
         border: none;
         table-layout: fixed;
         width: <%= (numMonths + 4) * 9 %>%;
         padding: 1px;
         position: relative;
      }
      
      th {
         border: 1px solid black;
         white-space: nowrap;
         padding-right: 5px;
         padding-left: 5px;
         position: relative;
         width:30%
         overflow: hidden;
      }
      
      td {
         border: 1px solid black;
         width: 10%;
         overflow: hidden;
         white-space: nowrap;
      }
      
      .Header1 {
         background-color: #009600;
         color: #FFFFFF;
      }
      
      .Header2 {
         background-color: #32C832;
      }
      
      .Header3 {
         background-color: #96FA96;
      }
      
      .HeaderTotal {
         background-color: #64FA64;
      }
      
      div#Selectors {
         font-size: 16px;
         font-weight: 500;
      }
      
      table#DevicesSummary th {
         text-align: right;
      }
      
      table#OSSummary th {
         text-align: right;
      }
      
      .Gray {
         background-color: #cfcfcf;
      }
      
      #TableContainer {
         overflow: scroll;
         overflow-y: hidden;
         -ms-overflow-y: hidden;
      }
      
   </style>
   <title>Project2 Compete Report</title>
   <link rel='stylesheet' href='ProjectStyle.css'>
   <img src='images/SoftMicro.jpg' alt='SoftMicro'>
   <h1>
      Project2 Compete Report
   </h1>
</head>
<body>
<form name='frmCompeteReport' action='<%= WebPageName %>.asp' method='post'>
<div id='MainContainer'>
<div id='TopBar'>
<input type='hidden' id='hidReseller' name='hidReseller' value='<%=request("hidReseller")%>'/>
<input type='hidden' id='hidCountry' name='hidCountry' value='<%=request("hidCountry")%>'/>
<input type='hidden' id='hidSpecPart' name='hidSpecPart' value='<%=request("hidSpecPart")%>'/>

<div id='Selectors'>
Select&nbsp;Reseller:&nbsp;
<select id='ResellerSelect' name='ResellerSelect' onchange='fnRefresh()'>
   <option value='none' selected>Overview</option>
   <% sSQL = " SELECT DISTINCT Compete.TPID, Compete.ResellerName, "
      sSQL = sSql & " CASE Country.AreaName WHEN 'Western Europe' THEN 'WE' ELSE Compete.CountryCode END AS CountryCd, "
      sSQL = sSql & " CASE Compete.CountryCode "
      sSQL = sSql & " WHEN 'USA' THEN 1 "
      sSQL = sSql & " WHEN 'CAN' THEN 1 "
      sSQL = sSql & " WHEN 'AUS' THEN 1 "
      sSQL = sSql & " WHEN 'GBR' THEN 1 "
      sSQL = sSql & " ELSE 2 END AS Wave "
      sSql = sSql & " FROM Project2.dbo.vw_CompeteData Compete(NOLOCK) "
      sSql = sSql & " INNER JOIN Project2.dbo.Country Country(NOLOCK) "
      sSql = sSql & " ON Country.CountryCode = Compete.CountryCode "
      sSql = sSql & "WHERE [Invoice Date] >= DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()), 0) "
      IF request("hidSpecPart") = "true" THEN
         sSql = sSql & "AND Compete.TPID IN (" & SpecialPartnerList & ") "
      END IF
      IF CSTR(request.form("hidReseller")) = "none" AND CSTR(request.form("hidCountry")) <> "none" THEN
         IF CSTR(request.form("hidCountry")) <> "WE" THEN
            sSql = sSql & "AND Country.CountryCode = '" & CSTR(request.form("hidCountry")) & "' "
         ELSE
            sSql = sSql & "AND Country.AreaName = '" & CSTR(request.form("hidCountry")) & "' "
         END IF
      END IF
      sSql = sSql & " ORDER BY Wave, ResellerName "
      
      DIM currentWave
      currentWave = 0
      
      recordSet.Open sSql, connection
      DO WHILE NOT recordSet.EOF
         IF currentWave <> CINT(recordSet("Wave")) THEN
            IF currentWave <> 0 THEN
               response.write "</optgroup>"
            END IF
            response.write "<optgroup label='Wave " & CSTR(recordSet("Wave")) & "'>"
            currentWave = CINT(recordSet("Wave"))
         END IF
         IF CSTR(recordSet("TPID")) = CSTR(request.form("hidReseller")) THEN
            response.write "<option value='" & recordSet("TPID") & "' selected>" & CSTR(recordSet("ResellerName")) & "</option>"
            'country = CSTR(recordSet("CountryCd"))
         ELSE
            response.write "<option value='" & recordSet("TPID") & "'>" & CSTR(recordSet("ResellerName")) & "</option>"
         END IF
         recordSet.MoveNext
      LOOP
      recordSet.Close
   %>
</select>
&nbsp;&nbsp;&nbsp;
</div>
<div id='SpecialFunctions'>
<label><input id='chkSpecialPartners' type='checkbox' name='chkSpecialPartners' value='SpecialPartners' onchange='fnRefresh()'>26 Partner View</label>
</div>
</div>
<br/>
<br/>
<div id='TableContainer'>
<script language='JavaScript' type='text/JavaScript'>

   if('<%= request("hidSpecPart") %>' == 'true'){
      document.getElementById("chkSpecialPartners").checked = true;
   }

   function fnResellerSelected() {
      var str = document.getElementById('ResellerSelect').value;
      document.frmCompeteReport.hidReseller.value = str;
      
      if (str != 'none') {
         var http = new XMLHttpRequest();
         http.onreadystatechange = function() {
            if (http.readyState == 4 && http.status == 200) {
               var objSelect = document.getElementById('CountrySelect');
               setSelectedValue(objSelect, http.responseText);
            }
         }
         if ('<%= OnDev %>' == 'true') {
            http.open('GET', 'Ajax/<%= AjaxName %>.asp?grab=country&id=' + str, true);
         }
         http.send();
      }
      else {
         var objSelect = document.getElementById('CountrySelect');
         setSelectedValue(objSelect, 'none');
      }
   }

   function fnCountrySelected() {
      var str = document.getElementById('CountrySelect').value;
      var newOptions;
      
      $.ajax({
         url: 'Ajax/<%= AjaxName %>.asp?grab=resellerList&id=' + str,
         complete: function(result){
         newOptions = result;
         console.log(result);
         $('#ResellerSelect option:gt(0)').remove();
         var $el = $("#ResellerSelect");
         $.each(newOptions, function(value,key) {
            $el.append($("<option></option>")
            .attr("value", value).text(key));
         });
      }});
      
   }
   
   function setSelectedValue(selectObj, valueToSet) {
      for (var i = 0; i < selectObj.options.length; i++) {
         if (selectObj.options[i].value== valueToSet) {
            selectObj.options[i].selected = true;
            return;
         }
      }
   }
   
   function fnRefresh() {
      document.frmCompeteReport.hidReseller.value= document.getElementById('ResellerSelect').value;
      if (document.getElementById('chkSpecialPartners').checked == true) {
         document.frmCompeteReport.hidSpecPart.value= 'true';
      }
      else {
         document.frmCompeteReport.hidSpecPart.value= 'false';
      }
      document.frmCompeteReport.submit();
   }
</script>
<%
   '(non)OS devices above/below NTE Table
   DIM LeftLabel, RowTotal, ColTotal(8), TotalCounter, GrandTotal, MaxDate
   DIM DeviceAbove(8), DeviceBelow(8), OSAbove(8), OSBelow(8), IncludedPartners(8), TotalPartners
   TotalCounter = 0
   counter = 0
   RowTotal = 0
   GrandTotal = 0
   sSql = "SELECT COUNT(TPID) AS IncludedPartners, "
   sSql = sSql & "CASE "
   sSql = sSql & "WHEN Metric = 'Count of Non-OS devices transacted above the NTE price, sold to primary and secondary education institutions' "
   sSql = sSql & "THEN 'NonOS above NTE' "
   sSql = sSql & "WHEN Metric = 'Count of Non-OS devices transacted below the NTE price, sold to primary and secondary education institutions' "
   sSql = sSql & "THEN 'NonOS below NTE' "
   sSql = sSql & "WHEN Metric = 'Count of OS Devices transacted above the NTE price, sold to primary and secondary education institutions' "
   sSql = sSql & "THEN 'OS above NTE' "
   sSql = sSql & "WHEN Metric = 'Count of OS Devices transacted below the NTE price, sold to primary and secondary education institutions' "
   sSql = sSql & "THEN 'OS below NTE' "
   sSql = sSql & "END AS Metric, [Invoice Date] AS InvDate, SUM(CASE WHEN Quantity > 0 AND Quantity < 1 THEN 0 "
   sSql = sSql & "WHEN Quantity <= 0 OR Quantity >= 1 THEN Quantity END) AS Qty "
   sSql = sSql & "FROM Project2.dbo.vw_competeData (NOLOCK) "
   sSql = sSql & "WHERE [Invoice Date] >= DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()), 0) " 
   IF CSTR(request.form("hidReseller")) <> "" AND CSTR(request.form("hidReseller")) <> "none" THEN
      sSql = sSql & "AND TPID = '" & CSTR(request.form("hidReseller")) & "' "
   END IF
   IF request("hidSpecPart") = "true" THEN
      sSql = sSql & "AND TPID IN (" & SpecialPartnerList & ") "
   END IF
   sSql = sSql & "GROUP BY Metric, [Invoice Date] "
   sSql = sSql & "ORDER BY Metric, [Invoice Date] "
   
   response.write "<table id='DevicesNTE'>"
   response.write "<tr><th id='DevicesNTETitle' class='Header1' colspan='" & NumMonths + 3 & "'>(Non)OS Devices Above/Below NTE</th>"
   response.write "<tr><th class='Header2' colspan='2'>Metrics</th>"
   FOR EACH x IN arrMonths
      IF x <> "" THEN 
         response.write "<th class='Header2'>" & CSTR(x) & "</th>"
      END IF
   NEXT
   response.write "<th class='Header2'>Total</th>"
   
   recordSet.Open sSql, connection
   IF NOT recordSet.EOF THEN
      LeftLabel = recordSet("Metric")
      response.write "</tr><tr><th colspan='2' style='text-align:right;'>" & recordSet("Metric") & "</th>"
      
      DO WHILE recordSet("InvDate") <> arrMonths(counter) _
         AND counter < numMonths
         response.write "<td>0</td>"
         counter = counter + 1
      LOOP
      IF counter <> numMonths THEN
         response.write "<td>" & FORMATNUMBER(recordSet("Qty"), 0) & "</td>"
      END IF
      
      ColTotal(counter) = ColTotal(counter) + recordSet("Qty")
      
      IF INSTR(LCASE(recordSet("Metric")), "above") <> 0 THEN
         IF INSTR(LCASE(recordSet("Metric")), "non") = 0 THEN
            OSAbove(TotalCounter) = OSAbove(TotalCounter) + recordSet("Qty")
         END IF
         DeviceAbove(TotalCounter) = DeviceAbove(TotalCounter) + recordSet("Qty")
      ELSEIF INSTR(LCASE(recordSet("Metric")), "below") <> 0 THEN
         IF INSTR(LCASE(recordSet("Metric")), "non") = 0 THEN
            OSBelow(TotalCounter) = OSBelow(TotalCounter) + recordSet("Qty")
         END IF
         DeviceBelow(TotalCounter) = DeviceBelow(TotalCounter) + recordSet("Qty")
      END IF
      
      TotalCounter = TotalCounter + 1
      RowTotal = recordSet("Qty")
      recordSet.MoveNext
   END IF
   DO WHILE NOT recordSet.EOF
      IF LCASE(recordSet("Metric")) <> LCASE(LeftLabel) THEN
         LeftLabel = recordSet("Metric")
         TotalCounter = 0
         response.write "<td>" & FORMATNUMBER(RowTotal, 0) & "</td></tr><tr><th colspan='2' style='text-align:right;'>" & recordSet("Metric") & "</th>"
         counter = TotalCounter
         DO WHILE recordSet("InvDate") <> arrMonths(counter) _
            AND counter < numMonths
            response.write "<td>0</td>"
            counter = counter + 1
         LOOP
         IF counter <> numMonths THEN
            response.write "<td>" & FORMATNUMBER(recordSet("Qty"), 0) & "</td>"
         END IF
         GrandTotal = GrandTotal + RowTotal
         RowTotal = recordSet("Qty")
      ELSE
         counter = TotalCounter
         DO WHILE recordSet("InvDate") <> arrMonths(counter) _
            AND counter < numMonths
            response.write "<td>0</td>"
            counter = counter + 1
         LOOP
         IF counter <> numMonths THEN
            response.write "<td>" & FORMATNUMBER(recordSet("Qty"), 0) & "</td>"
         END IF
         RowTotal = RowTotal + recordSet("Qty")
      END IF
      
      IF INSTR(LCASE(recordSet("Metric")), "above") <> 0 THEN
         IF INSTR(LCASE(recordSet("Metric")), "non") = 0 THEN
            OSAbove(TotalCounter) = OSAbove(TotalCounter) + recordSet("Qty")
         END IF
         DeviceAbove(TotalCounter) = DeviceAbove(TotalCounter) + recordSet("Qty")
      ELSEIF INSTR(LCASE(recordSet("Metric")), "below") <> 0 THEN
         IF INSTR(LCASE(recordSet("Metric")), "non") = 0 THEN
            OSBelow(TotalCounter) = OSBelow(TotalCounter) + recordSet("Qty")
         END IF
         DeviceBelow(TotalCounter) = DeviceBelow(TotalCounter) + recordSet("Qty")
      END IF
      
      ColTotal(counter) = ColTotal(counter) + recordSet("Qty")
      TotalCounter = TotalCounter + 1
      MaxDate = recordSet("InvDate")
      recordSet.MoveNext
   LOOP
   GrandTotal = GrandTotal + RowTotal
   response.write "<td>" & FORMATNUMBER(RowTotal, 0) & "</td>"
   recordSet.Close
   response.write "</tr><tr><th colspan='2' class='HeaderTotal' style='text-align:right;'>Total</th>"
   FOR TotalCounter = 0 TO numMonths - 1
      IF ColTotal(TotalCounter) <> 0 THEN
         response.write "<td class=' Header3'>" & FORMATNUMBER(ColTotal(TotalCounter), 0) & "</td>"
      ELSE
         response.write "<td class=' Header3'>" & FORMATNUMBER(0, 0) & "</td>"
      END IF
   NEXT
   response.write "<td class=' Header3'>" & FORMATNUMBER(GrandTotal, 0) & "</td></tr></table>"
%>
<br/>
<br/>
<%
   'Compete Report Summary Table
   DIM OSOverall(8)
   response.write "<table id='DevicesSummary'>"
   response.write "<tr><th id='DevicesSummTitle' class='Header1' style='text-align: center;' colspan='" & NumMonths + 2 & "'>Compete Report Summary</th>"
   response.write "<tr><th class='Header2' colspan='2'>&nbsp;</th>"
   FOR EACH x IN arrMonths
      IF x <> "" THEN 
         response.write "<th class='Header2' style='text-align: center;'>" & CSTR(x) & "</th>"
      END IF
   NEXT
   response.write "</tr><tr>"
   response.write "<th class='HeaderTotal' colspan='2' style='text-align: right;'>Total Units in Sample</th>"
   FOR TotalCounter = 0 TO UBOUND(ColTotal)
      IF ColTotal(TotalCounter) <> 0  THEN
         response.write "<td>" & FORMATNUMBER(ColTotal(TotalCounter), 0) & "</td>"
      ELSEIF TotalCounter < NumMonths THEN
         response.write "<td>0</td>"
      END IF
   NEXT
   response.write "</tr><tr>"
   response.write "<th colspan='2' style='test-align: right;'>Total # of Devices Above NTE</th>"
   FOR TotalCounter = 0 TO UBOUND(DeviceAbove)
      IF DeviceAbove(TotalCounter) <> 0 THEN
         response.write "<td>" & FORMATNUMBER(DeviceAbove(TotalCounter), 0) & "</td>"
      ELSEIF TotalCounter < NumMonths THEN
         response.write "<td>0</td>"
      END IF
   NEXT
   response.write "</tr><tr>"
   response.write "<th colspan='2' style='test-align: right;'>Total # of Devices Below NTE</th>"
   FOR TotalCounter = 0 TO UBOUND(DeviceBelow)
      IF DeviceBelow(TotalCounter) <> 0 THEN
         response.write "<td>" & FORMATNUMBER(DeviceBelow(TotalCounter), 0) & "</td>"
      ELSEIF TotalCounter < NumMonths THEN
         response.write "<td>0</td>"
      END IF
   NEXT
   response.write "</tr><tr>"
   response.write "<th colspan='2' style='test-align: right;'>% of Total Devices Above NTE</th>"
   FOR TotalCounter = 0 TO UBOUND(DeviceAbove)
      IF DeviceAbove(TotalCounter) <> 0 THEN
         response.write "<td>" & FORMATNUMBER(DeviceAbove(TotalCounter) / ColTotal(TotalCounter) * 100, 0) & "%</td>"
      ELSEIF TotalCounter < NumMonths THEN
         response.write "<td>0%</td>"
      END IF
   NEXT
   response.write "</tr><tr>"
   response.write "<th colspan='2' style='test-align: right;'>% of Total Devices Below NTE</th>"
   FOR TotalCounter = 0 TO UBOUND(DeviceBelow)
      IF DeviceBelow(TotalCounter) <> 0 THEN
         response.write "<td>" & FORMATNUMBER(DeviceBelow(TotalCounter) / ColTotal(TotalCounter) * 100, 0) & "%</td>"
      ELSEIF TotalCounter < NumMonths THEN
         response.write "<td>0%</td>"
      END IF
   NEXT
   response.write "</tr><tr>"
   response.write "<th colspan='2' style='test-align: right;'>Total # of OS Devices Above NTE</th>"
   FOR TotalCounter = 0 TO UBOUND(OSAbove)
      OSOverall(TotalCounter) = OSOverall(TotalCounter) + OSAbove(TotalCounter)
      IF OSAbove(TotalCounter) <> 0 THEN
         response.write "<td>" & FORMATNUMBER(OSAbove(TotalCounter), 0) & "</td>"
      ELSEIF TotalCounter < NumMonths THEN
         response.write "<td>0</td>"
      END IF
   NEXT
   response.write "</tr><tr>"
   response.write "<th colspan='2' style='test-align: right;'>Total # of OS Devices Below NTE</th>"
   FOR TotalCounter = 0 TO UBOUND(OSBelow)
      OSOverall(TotalCounter) = OSOverall(TotalCounter) + OSBelow(TotalCounter)
      IF OSBelow(TotalCounter) <> 0 THEN
         response.write "<td>" & FORMATNUMBER(OSBelow(TotalCounter), 0) & "</td>"
      ELSEIF TotalCounter < NumMonths THEN
         response.write "<td>0</td>"
      END IF
   NEXT
   response.write "</tr><tr>"
   response.write "<th colspan='2' style='test-align: right;'>% of OS Devices Above NTE</th>"
   FOR TotalCounter = 0 TO UBOUND(OSAbove)
      IF OSAbove(TotalCounter) <> 0 THEN
         response.write "<td>" & FORMATNUMBER(OSAbove(TotalCounter) / DeviceAbove(TotalCounter) * 100, 0) & "%</td>"
      ELSEIF TotalCounter < NumMonths THEN
         response.write "<td>0%</td>"
      END IF
   NEXT
   response.write "</tr><tr>"
   response.write "<th colspan='2' style='test-align: right;'>% of OS Devices Below NTE</th>"
   FOR TotalCounter = 0 TO UBOUND(OSBelow)
      IF OSBelow(TotalCounter) <> 0 THEN
         response.write "<td>" & FORMATNUMBER(OSBelow(TotalCounter) / DeviceBelow(TotalCounter) * 100, 0) & "%</td>"
      ELSEIF TotalCounter < NumMonths THEN
         response.write "<td>0%</td>"
      END IF
   NEXT
   response.write "</tr><tr>"
   response.write "<th colspan='2' style='test-align: right;'>Total # of OS Devices Reported</th>"
   FOR TotalCounter = 0 TO UBOUND(OSOverall)
      IF OSOverall(TotalCounter) <> 0 THEN
         response.write "<td>" & FORMATNUMBER(OSOverall(TotalCounter), 0) & "</td>"
      ELSEIF TotalCounter < NumMonths THEN
         response.write "<td>0</td>"
      END IF
   NEXT
   response.write "</tr><tr>"
   response.write "<th colspan='2' style='test-align: right;'>OS Share Overall</th>"
   FOR TotalCounter = 0 TO UBOUND(OSOverall)
      IF OSOverall(TotalCounter) <> 0 THEN
         response.write "<td>" & FORMATNUMBER(OSOverall(TotalCounter) / ColTotal(TotalCounter) * 100, 0) & "%</td>"
      ELSEIF TotalCounter < NumMonths THEN
         response.write "<td>0%</td>"
      END IF
   NEXT
   response.write "</tr><tr>"
   
   sSql = " SELECT COUNT(DISTINCT TPID) AS IncludedPartners, [Invoice Date]  "
   sSql = sSql & " FROM Project2.dbo.vw_competeData "
   sSql = sSql & " WHERE [Invoice Date] >= DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()), 0) " 
   sSql = sSql & " AND [Invoice Date] <= '" & MaxDate & "' "
   IF CSTR(request.form("hidReseller")) <> "" AND CSTR(request.form("hidReseller")) <> "none" THEN
      sSql = sSql & "AND TPID = '" & CSTR(request.form("hidReseller")) & "' "
   END IF
   IF request("hidSpecPart") = "true" THEN
      sSql = sSql & "AND TPID IN (" & SpecialPartnerList & ") "
   END IF
   sSql = sSql & " GROUP BY [Invoice Date] "
   
   TotalCounter = 0
   recordSet.Open sSql, connection
   DO WHILE recordSet.BOF OR NOT recordSet.EOF
      IncludedPartners(TotalCounter) = recordSet("IncludedPartners")
      TotalCounter = TotalCounter + 1
      recordSet.MoveNext
   LOOP
   recordSet.Close
   
   response.write "<th colspan='2' class='Gray' style='test-align: right;'>Count of Partners Included in View</th>"
   FOR TotalCounter = 0 TO UBOUND(IncludedPartners)
      IF IncludedPartners(TotalCounter) <> 0 THEN
         response.write "<td class='Gray'>" & FORMATNUMBER(IncludedPartners(TotalCounter), 0) & "</td>"
      ELSEIF TotalCounter < NumMonths THEN
         response.write "<td class='Gray'>0</td>"
      END IF
   NEXT
   response.write "</tr><tr>"
   
   sSql = " SELECT COUNT(DISTINCT TPID) AS Total "
   sSql = sSql & " FROM Project2.dbo.vw_CompeteData (NOLOCK) "
   sSql = sSql & " WHERE [Invoice Date] >= DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()), 0) " 
   sSql = sSql & " AND [Invoice Date] <= '" & MaxDate & "' "
   sSQL = sSql & " AND CountryCode IN ('USA', 'CAN', 'AUS', 'GBR') "
   
   recordSet.Open sSql, connection
   IF recordSet.BOF OR NOT recordSet.EOF THEN
      TotalPartners = recordSet("Total")
   ELSE
      TotalPartners = 0
   END IF
   recordSet.Close
   
   response.write "<th colspan='2' class='Gray' style='test-align: right;'>Total Count of Partners</th>"
   FOR TotalCounter = 0 TO NumMonths - 1
      IF TotalPartners <> 0 THEN
         response.write "<td class='Gray'>" & FORMATNUMBER(TotalPartners, 0) & "</td>"
      ELSEIF TotalCounter < NumMonths THEN
         response.write "<td class='Gray'>0</td>"
      END IF
   NEXT
   response.write "</tr><tr>"
   response.write "<th colspan='2' class='Gray' style='test-align: right;'>% of Partners Included in View</th>"
   FOR TotalCounter = 0 TO NumMonths - 1
      IF TotalPartners <> 0 THEN
         response.write "<td class='Gray'>" & FORMATNUMBER(IncludedPartners(TotalCounter) / TotalPartners * 100, 0) & "%</td>"
      ELSEIF TotalCounter < NumMonths THEN
         response.write "<td class='Gray'>0%</td>"
      END IF
   NEXT
   response.write "</tr></table>"
%>
<br/>
<br/>
<%
   '% OS Above/Below NTE Table
   response.write "<table id='OSSummary'>"
   response.write "<tr><th id='OSSummTitle' class='Header1' style='text-align: center;' colspan='" & NumMonths + 2 & "'>% OS Above/Below NTE Summary</th>"
   response.write "<tr><th class='Header2' colspan='2'>&nbsp;</th>"
   FOR EACH x IN arrMonths
      IF x <> "" THEN 
         response.write "<th class='Header2' style='text-align: center;'>" & CSTR(x) & "</th>"
      END IF
   NEXT
   response.write "</tr><tr>"
   response.write "<th class='HeaderTotal' colspan='2' style='text-align: right;'>Total Units in Sample</th>"
   FOR TotalCounter = 0 TO UBOUND(ColTotal)
      IF ColTotal(TotalCounter) <> 0  THEN
         response.write "<td>" & FORMATNUMBER(ColTotal(TotalCounter), 0) & "</td>"
      ELSEIF TotalCounter < NumMonths THEN
         response.write "<td>0</td>"
      END IF
   NEXT
   response.write "</tr><tr>"
   response.write "<th colspan='2' style='test-align: right;'>% of OS Devices Above NTE</th>"
   FOR TotalCounter = 0 TO UBOUND(OSAbove)
      IF OSAbove(TotalCounter) <> 0 THEN
         response.write "<td>" & FORMATNUMBER(OSAbove(TotalCounter) / DeviceAbove(TotalCounter) * 100, 0) & "%</td>"
      ELSEIF TotalCounter < NumMonths THEN
         response.write "<td>0%</td>"
      END IF
   NEXT
   response.write "</tr><tr>"
   response.write "<th colspan='2' style='test-align: right;'>% of OS Devices Below NTE</th>"
   FOR TotalCounter = 0 TO UBOUND(OSBelow)
      IF OSBelow(TotalCounter) <> 0 THEN
         response.write "<td>" & FORMATNUMBER(OSBelow(TotalCounter) / DeviceBelow(TotalCounter) * 100, 0) & "%</td>"
      ELSEIF TotalCounter < NumMonths THEN
         response.write "<td>0%</td>"
      END IF
   NEXT
   response.write "</tr><tr>"
   response.write "<th colspan='2' style='test-align: right;'>OS Share Overall</th>"
   FOR TotalCounter = 0 TO UBOUND(OSOverall)
      IF OSOverall(TotalCounter) <> 0 THEN
         response.write "<td>" & FORMATNUMBER(OSOverall(TotalCounter) / ColTotal(TotalCounter) * 100, 0) & "%</td>"
      ELSEIF TotalCounter < NumMonths THEN
         response.write "<td>0%</td>"
      END IF
   NEXT
   response.write "</tr></table>"
%>
</div>
</div>
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
   Error Number <%= Err.Number %><BR>
   Error Description <%= Err.Description %><BR>	
   Source <%= Err.Source %><BR>

 	LineNumber <%= Err.Line %><P><br>
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