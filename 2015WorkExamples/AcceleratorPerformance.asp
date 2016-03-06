<%
   '************************************************
   'Page dislaying performance of an accelerated incentive
   'program for all partners, limited to users permissions
   'of geographical area
   '************************************************
   
   
   '*** Dev Switch ***
   DIM onDev
   onDev = FALSE
   
   IF OnDev THEN
      response.Buffer = TRUE
      ON ERROR RESUME NEXT
   END IF
   
   '**** program specific variables ****
   '**********************************
   IF OnDev THEN 
      WebPageName = "devAcceleratorPerformance"
   ELSE
      WebPageName = "AcceleratorPerformance"
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
   dtProRate = DATEPART("m", NOW())
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
   
   ' Returns the largest integer less than or equal to the specified number.
   FUNCTION floor(x)
      dim temp
      temp = Round(x)
      IF temp > x THEN
         temp = temp - 1
      END IF
      floor = temp
   END FUNCTION
   
   IF dtProRate > 6 THEN
      dtProRate = dtProRate - 6
   END IF
   
   IF DATEPART("d", NOW()) <= 28 AND dtProRate > 1 THEN
      dtProRate = dtProRate - 1
   END IF
   
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
   strName=sArrayLogon(1)
   
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
      ''Session("UserMNA") = "ALL"
   END IF
%>

<html>
<head>
   <meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
   <!--<script src='Utils/JQuery2.1.4/jquery-2.1.4.min.js'></script>
   <script src='Utils/FloatTHead/floatThead/jquery.floatThead._.js'></script>-->
   <style>
      div#MainContainer {
         overflow-y: auto;
         max-width: 100%;
         min-width: 25%:
         height: 100%;
      }
      
      /*head, body {
         overflow: hidden;
      }*/
      
      table thead#HeaderRow {
         position: fixed;
         top: 0;
         left: 0;
      }
      
      table#AccelPerf {
         padding-top: 15px;
         max-width: 100%;
      }
      
      table th.TableHeader {
         background-color: #000000;
         color: #ffffff;
         text-align: center;
         display: block;
         font-size: 16px;
      }
      
      table th.TableBody {
         background-color: #000000;
         color: #ffffff;
         text-align: center;
         /*overflow-y: auto;*/
         display: block;
      }
      
      table th.Header1 {
         background-color: #330066;
         color: #ffffff;
         text-align: center;
         font-weight: normal;
         font-size: 14px;
      }
      
      table th.Header2 {
         background-color: gray;
         color: #ffffff;
         text-align: center;
         font-weight: normal;
         font-size: 14px;
      }
      
      table th.Header3 {
         background-color: green;
         color: #ffffff;
         text-align: center;
         font-weight: normal;
         font-size: 14px;
      }
      
      table th.Header4 {
         background-color: #1F4E78;
         color: #ffffff;
         text-align: center;
         font-weight: normal;
         font-size: 14px;
      }
      
      table th.HeaderAccrualDollar {
         background-color: green;
         color: #ffffff;
         text-align: center;
         font-weight: normal;
      }
      
      table th.HeaderAccrualPercent {
         background-color: #FFA100;
         color: #ffffff;
         text-align: center;
         font-weight: normal;
      }
      
      table td.AccrualMark {
         background-color: #cfcfcf;
      }
      
      table td.Number {
         text-align: right;
      }
      
      table td.Data {
         font-size: 13px;
      }
      
      .Bold {
         font-weight: 700 !important;
      }
      
   </style>
   <title>Project1 Accelerator Dashboard</title>
   <link rel='stylesheet' href='ProjectStyle.css'/>
   <link rel='icon' type='image/ico' href='favicon1.ico'>
   <div>
      <div>
         <img src="images/SoftMicro.jpg" alt="SoftMicro"/>
      </div>
      <div>
         <%= Session("txtPermission") %>
      </div>
   </div>
</head>
<body style="margin-top='0';margin-left='0';margin-right='0'">
<form NAME='frmMain' action='<%= WebPageName %>.asp' method='POST'>
<div id='MainContainer'>
   <table id='AccelPerf' border=1  cellpadding=1 cellspacing=0>
      <thead id='HeaderRow'>
      <tr>
         <th colspan='15' class='TableHeader'>Accelerator Performance Report for FY16 H1</th>
      </tr>
      <tr>
         <th colspan='5' class='Header1'>ORGANIZATION</th>
         <th colspan='6' class='Header2'>ACCELERATOR GOALS</th>
         <th colspan='2' class='Header3'>ACCELERATOR STATUS</th>
         <th colspan='2' class='Header4'>ACCELERATOR ANALYSIS</th>
         <!--<th colspan=12 class='Header3'>TO DATE ACCRUAL ESTIMATOR</th>-->
      </tr>
      <tr>
         <th rowspan='2' class='Header1'>Area</th>
         <th rowspan='2' class='Header1'>Subsidiary</th>
         <th rowspan='2' class='Header1'>OrgName</th>
         <th rowspan='2' class='Header1'>TPID</th>
         <th rowspan='2' class='Header1'>DistiId</th>
         <th rowspan='2' class='Header2'>Baseline</th>
         <th rowspan='2' class='Header2'>Target</th>
         <th rowspan='2' class='Header2'><span class='Bold'>Units</span></th>
         <th rowspan='2' class='Header2'><span class='Bold'>% of Target</span></th>
         <th rowspan='2' class='HeaderAccrualPercent'>80% Mark</th>
         <th rowspan='2' class='HeaderAccrualPercent'>150% Mark</th>
         <th rowspan='2' class='HeaderAccrualDollar'>Per Unit Accrual</th> 
         <th rowspan='2' class='Header3'>Accelerator Bonus Accrued</th>
         <th rowspan='2' class='Header4'>ProRated Target</th>
         <th rowspan='2' class='Header4'><div class='Numerator'>Above</div><div class='Denominator'>Below</div></th>
      </tr></thead>
      <tr></tr>
 
<%
   sSql = "SELECT "
   sSql = sSql & " REPLACE(REPLACE(country.AreaName,'Central and Eastern Europe','CEE'),'Western Europe','WE') AS [Area], "
   sSql = sSql & " country.CountryName AS Subsidiary, "
   sSql = sSql & " export.DistiName AS OrgName, "
   sSql = sSql & " goals.TPID, "
   sSql = sSql & " goals.id AS DistiId, "
   sSql = sSql & " goals.BaseLine, "
   sSql = sSql & " goals.goal AS [Target], "
   sSql = sSql & " SUM(export.QtySold) AS ToDate "
   sSql = sSql & " FROM Project1.dbo.PartnerGoals goals(NOLOCK) "
   sSql = sSql & " LEFT JOIN Project1.dbo.FY16H1_EXPORT export(NOLOCK) "
   sSql = sSql & " ON goals.id = export.DistiSoldToId "
   sSql = sSql & " INNER JOIN Project1.dbo.Country country(NOLOCK) "
   sSql = sSql & " ON country.CountryCode = export.DistiCountryCode "
   sSql = sSql & " WHERE export.SoftMicroReportableSKU = 'WN7-01627' "
   sSql = sSql & " AND (export.OS LIKE 'OS%2%PRO' "
   sSql = sSql & " OR export.OS LIKE 'OS%3%PRO') "
   sSql = sSql & " AND export.Touch = 'Y' "
   IF Session("UserSubsidiary") <> "ALL" THEN
      sSql = sSql & " AND country.SubsidiaryID IN (" & Session("UserSubsidiary") & ") "
   END IF
   IF Session("UserMNA") <> "ALL" THEN
      sSql = sSql & " AND export.OEM = '" & Session("UserMNA") & "' "
   END IF
   IF Session("includeSpecialDevice1Data") <> "YES" THEN
      sSql = sSql & " AND export.OEM <> 'SoftMicro' "
   END IF
   sSql = sSql & " GROUP BY country.AreaName, country.CountryName, export.DistiName, "
   sSql = sSql & " TPID, goals.id, BaseLine, goals.goal "
   sSql = sSql & " ORDER BY Area, Subsidiary, OrgName "
      ' response.Write "<code>" & sSql & "</code>"

   DIM strArea, strSubsid, strOrgName, strTPID, strDistiId, intBaseline, intTarget
   DIM intToDate, intAccrual, intLowerMark, intUpperMark, intAccelUnits, intAccelBonus, intMonthlyTarget

   recordSet.Open sSql, connection
   DO WHILE recordSet.BOF OR NOT recordSet.EOF
      strArea     = CSTR(recordSet("Area"))
      strSubsid   = CSTR(recordSet("Subsidiary"))
      strOrgName  = Server.HTMLEncode(recordSet("OrgName"))
      strTPID     = CSTR(recordSet("TPID"))
      strDistiId  = CSTR(recordSet("DistiId"))
      
      intBaseline = ceil(CLNG(recordSet("BaseLine")))
      intTarget   = ceil(CLNG(recordSet("Target")))
      intToDate   = ceil(CLNG(recordSet("ToDate")))
      
      intAccrual     = CLNG(intToDate * payout)
      intLowerMark   = ceil(CLNG(recordSet("Target")) * lowerBonusIncentive / 100)
      intUpperMark   = ceil(CLNG(recordSet("Target")) * upperBonusIncentive / 100)
      IF intToDate > intLowerMark AND intToDate <= intUpperMark + 1 THEN
         intAccelUnits = intToDate - intLowerMark
      ELSEIF intToDate > intUpperMark + 1 THEN
         intAccelUnits = intUpperMark - intLowerMark
      ELSE
         intAccelUnits = 0
      END IF
      intAccelBonus  = intAccelUnits * (bonusPayout - payout)

      
      intMonthlyTarget = ceil(intTarget / 6 * dtProRate)
      
      'Organization
      response.write "<tbody id='TableBody'><tr>"
      response.write "<td class='Data'>" & strArea     & "</td>"
      response.write "<td class='Data'>" & strSubsid   & "</td>"
      response.write "<td class='Data'>" & strOrgName  & "</td>"
      response.write "<td class='Data'>" & strTPID     & "</td>"
      response.write "<td class='Data'>" & strDistiId  & "</td>"

      'Accelerator Goals
      response.write "<td class='Number Data'>" & FORMATNUMBER(intBaseline,0)   & "</td>"
      response.write "<td class='Number Data'>" & FORMATNUMBER(intTarget,0)     & "</td>"
      response.write "<td class='Number Data'>" & FORMATNUMBER(intToDate,0)     & "</td>"
      response.write "<td class='Number Data'>" & FORMATNUMBER(intToDate / intTarget * 100,2) & "%</td>"
      response.write "<td class='AccrualMark Number Data'>" & FORMATNUMBER(intLowerMark,0)    & "</td>"
      response.write "<td class='AccrualMark Number Data'>" & FORMATNUMBER(intUpperMark,0)    & "</td>"

      'Accelerator Status
      response.write "<td class='Number Data'>" & FORMATCURRENCY(intAccrual,0)    & "</td>"
      response.write "<td class='Number Data'>" & FORMATCURRENCY(intAccelBonus,0) & "</td>"

      'Accelerator Analysis
      response.write "<td class='Number Data'>" & FORMATNUMBER(intMonthlyTarget,0) & "</td>"
      response.write "<td class='Number Data'>" & FORMATNUMBER(intToDate - intMonthlyTarget,0) & "</td>"
      
      response.write "</tr>"

 
      recordSet.MoveNext
   LOOP
   recordSet.Close
   
   response.write "</tbody></table>"
%>
 
   </table>
</div>

<script language='JavaScript' type='text/JavaScript'>
   //var $floatHead = $('table#AccelPerf');
   //$floatHead.floatThead({
   //   scrollContainer: function($table){
   //      return $table.closest('#MainContainer');
   //   }
   //});
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
 
   <BODY BGCOLOR='#C0C0C0'>
 
   <FONT FACE='ARIAL">An error occurred in the execution of this ASP page<BR><P>
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

 	LineNumber: <%= Err.Line %><BR>
   Column: <%= Err.Column %><BR>
   ASPCode: <%= Err.ASPCode %><BR>
   ASPDescription: <%= Err.ASPDescription %><BR>
   Category: <%= Err.Category %><BR>
   File: <%= Err.File %><BR>
   
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