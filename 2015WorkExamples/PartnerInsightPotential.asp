<%
   '************************************************
   'Page dislaying potential of incentives from
   'program for individual partner companies
   '************************************************
   
   '*** Dev Switch ***
   DIM onDev
   onDev = FALSE
   
   IF OnDev THEN
      response.Buffer = FALSE
      ON ERROR RESUME NEXT
   END IF
   
   '**** program specific variables ****
   '**********************************
   IF OnDev THEN 
      WebPageName = "devPartnerInsightPotential"
      AjaxName    = "devajaxPartnerInsight"
   ELSE
      WebPageName = "PartnerInsightPotential"
      AjaxName    = "ajaxPartnerInsight"
   END IF
   '**********************************
   payout      = 2 'Dollars
   specpayout  = 1 'Dollars
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
      'Session("UserMNA") = "ALL"
   END IF
%>
<!DOCTYPE HTML>
<html>
<head>
   <meta http-equiv='X-UA-Compatible' content='IE=edge' />
   <meta http-equiv='Content-Type' content='text/html' charset='utf-8' />
   <script src='Utils/JQuery2.1.4/jquery-2.1.4.min.js'></script>
   <!--**************************** Needed for PDF Export ****************************-->
   <!--<script type='text/javascript' src='Utils/jsPDF/dist/jspdf.min.js'></script>
   <script type='text/javascript' src='Utils/jsPDF/jspdf.plugin.standard_fonts_metrics.js'></script> 
   <script type='text/javascript' src='Utils/jsPDF/jspdf.plugin.split_text_to_size.js'></script>
   <script type='text/javascript' src='Utils/jsPDF/libs/FileSaver.js/FileSaver.min.js'></script>
   <script type='text/javascript' src='Utils/html2canvas/html2canvas.js'></script>
   <script type='text/javascript' src='Utils/html2canvas/html2canvas.svg.js'></script>-->
   <!--**************************** ********************* ****************************-->
   <title>PI | Potential</title>
   <link rel="stylesheet" href="ProjectStyle.css"/>
   <link rel='icon' type='image/ico' href='favicon1.ico'>
</head>
<body>
<form name='frmMixProgression' action='<%= WebPageName %>.asp' method='post'>
<div id='MainContainer' class='Container'>
   <div id='TopBanner' class='Container'>
      <div>
         <img src="images/SoftMicro.jpg" alt="SoftMicro"/>
      </div>
      <div>
         <%= Session("txtPermission") %>
      </div>
   
      <h1>
         Partner Insight Potential
      </h1>
   </div>

<input type='hidden' id='hidValue' name='hidValue' value='<%=request.form("hidValue")%>'/>
<input type='hidden' id='hidAction' name='hidAction' value='<%=request.form("hidAction")%>'/>
<input type='hidden' id='hidCountry' name='hidCountry' value='<%=request.form("hidCountry")%>'/>
<input type='hidden' id='hidRegion' name='hidRegion' value='<%=request.form("hidRegion")%>'/>
<div id='FilterBar' class='Container'>
<div id='TopFilters' class='Container'>
<div id='TopLeftDiv' class='Container'>
<!--Region/Company - Filter Disti's by Region or company group-->
<select id='RegionSelect' name='RegionSelect' onchange='fnRegionSelected()'>
   <% 
      DIM placeHolder
      placeHolder = 0
      
      sSQL = " SELECT DISTINCT dyna.DynVal1 AS RegionName "
      sSQL = sSql & " FROM Project1.dbo.UIDynamic dyna(NOLOCK) "
      sSQL = sSql & " LEFT JOIN Project1.dbo.FY16H1_EXPORT export (NOLOCK) "
      sSQL = sSql & " ON export.DistiSoldToId = dyna.DynVal2 "
      sSQL = sSql & " INNER JOIN Project1.dbo.Country country (NOLOCK) "
      sSQL = sSql & " ON export.DistiCountryCode = country.CountryCode "
      sSQL = sSql & " WHERE country.SubsidiaryID IN (" & Session("UserSubsidiary") & ") "
      sSQL = sSql & " AND dyna.PageName = '" & WebPageName & "' "
      IF Session("UserMNA") <> "ALL" THEN
         sSQL = sSql & " AND export.OEM = '" & Session("UserMNA") & "' "
      END IF
      sSQL = sSql & " ORDER BY dyna.DynVal1 "
      
      response.write "<option value='" & placeHolder & "' selected>WW</option>"
       
      recordSet.Open sSql, connection
      DO WHILE recordSet.BOF OR NOT recordSet.EOF
      placeHolder = placeHolder + 1
      IF recordSet("RegionName") = request.form("hidRegion") THEN
         response.write "<option value='" & placeHolder & "' selected>" & Server.HTMLENCODE(recordSet("RegionName")) & "</option>"
      ELSE
         response.write "<option value='" & placeHolder & "'>" & Server.HTMLENCODE(recordSet("RegionName")) & "</option>"
      END IF
      recordSet.MoveNext
      LOOP
      recordSet.Close
   %>
</select>
<br>
<!--Country Select - Filter Disti's by country-->
<select id='CountrySelect' name='CountrySelect' onchange="fnCountrySelected()">
   <option value='none' selected disabled>Select Country</option>
   <% sSQL = " SELECT DISTINCT export.DistiCountryCode AS [CountryCode], "
      sSQL = sSql & " Country.CountryName AS [CountryName] "
      sSQL = sSql & " FROM Project1.dbo.FY16H1_EXPORT export (NOLOCK) "
      sSQL = sSql & " INNER JOIN Project1.dbo.Country Country (NOLOCK) "
      sSQL = sSql & " ON export.DistiCountryCode = Country.CountryCode "
      sSQL = sSql & " WHERE Country.SubsidiaryID IN (" & Session("UserSubsidiary") & ") "
      IF Session("UserMNA") <> "ALL" THEN
         sSQL = sSql & " AND export.OEM = '" & Session("UserMNA") & "' "
      END IF
      IF NOT ISEMPTY(request.form("hidRegion")) AND CSTR(request.form("hidRegion")) <> "WW" THEN
         sSQL = sSql & " AND export.DistiSoldToId IN (SELECT DynVal2 FROM "
         sSQL = sSql & " Project1.dbo.UIDynamic(NOLOCK) WHERE DynVal1 = '" & CSTR(request.form("hidRegion")) & "' "
         sSQL = sSql & " AND PageName = '" & WebPageName & "') "
      END IF
      sSQL = sSql & " AND TOUCH IS NOT NULL "
      sSQL = sSql & " AND FormFactor NOT LIKE 'Desktop' "
      sSQL = sSql & " ORDER BY Country.CountryName; "
      'response.write sSql
       
      recordSet.Open sSql, connection
      DO WHILE recordSet.BOF OR NOT recordSet.EOF
      IF recordSet("CountryCode") = request.form("hidCountry") THEN
         response.write "<option value='" & recordSet("CountryCode") & "' selected>" & Server.HTMLENCODE(recordSet("CountryName")) & "</option>"
      ELSE
         response.write "<option value='" & recordSet("CountryCode") & "'>" & Server.HTMLENCODE(recordSet("CountryName")) & "</option>"
      END IF
      recordSet.MoveNext
      LOOP
      recordSet.Close
   %>
</select>
</div>
<div id='Loading' class='Container'> Loading...</div>
</div>
<!--Disti select - DistiID, DistiName-->
<select id='DistiSelect' name='DistiSelect' onkeydown="if (event.keyCode == 13) document.getElementById('btnGo').click()"
         onchange='fnDistiSelected()'>
   <option value='none' selected disabled>Select Distributor</option>
   <% 
      sSQL = " SELECT DISTINCT [DistiSoldToID], [DistiName] "
      sSQL = sSql & " FROM Project1.dbo.FY16H1_EXPORT(NOLOCK) "
      sSQL = sSql & " INNER JOIN Project1.dbo.Country(NOLOCK) "
      sSQL = sSql & " ON CountryCode = DistiCountryCode "
      sSQL = sSql & " WHERE SubsidiaryID IN (" & Session("UserSubsidiary") & ") "
      IF Session("UserMNA") <> "ALL" THEN
         sSQL = sSql & " AND OEM = '" & Session("UserMNA") & "' "
      END IF
      IF CSTR(request.form("hidCountry")) <> "none" AND NOT ISEMPTY(request.form("hidCountry")) THEN
         sSQL = sSql & " AND CountryCode = '" & request("hidCountry") & "' "
      END IF
      IF NOT ISEMPTY(request.form("hidRegion")) AND CSTR(request.form("hidRegion")) <> "WW" THEN
         sSQL = sSql & " AND DistiSoldToId IN (SELECT DynVal2 FROM "
         sSQL = sSql & " Project1.dbo.UIDynamic(NOLOCK) WHERE DynVal1 = '" & CSTR(request.form("hidRegion")) & "' "
         sSQL = sSql & " AND PageName = '" & WebPageName & "') "
      END IF
      sSQL = sSql & " AND TOUCH IS NOT NULL "
      sSQL = sSql & " AND FormFactor NOT LIKE 'Desktop' "
      sSQL = sSql & " ORDER BY [DistiName]; "
      
      recordSet.Open sSql, connection
      DO WHILE recordSet.BOF OR NOT recordSet.EOF
      IF "'" + CSTR(recordSet("DistiSoldToID")) + "'" = CSTR(request.form("hidValue")) THEN
         response.write "<option value='" & recordSet("DistiSoldToID") & "' selected>" & Server.HTMLENCODE(recordSet("DistiName")) & " - " & recordSet("DistiSoldToID") & "</option>"
      ELSE
         response.write "<option value='" & recordSet("DistiSoldToID") & "'>" & Server.HTMLENCODE(recordSet("DistiName")) & " - " & recordSet("DistiSoldToID") & "</option>"
      END IF
      recordSet.MoveNext
      LOOP
      recordSet.Close
   %>
</select>
<input id='btnGo' type='button' onclick='fnDistiClick()' value='Go'/>&nbsp;&nbsp;&nbsp;
<%
   IF OnDev THEN
      ''response.write "<input id='btnPrint' type='button' onclick='fnExport()' value='Export'/>"
   END IF
%>
</div>
<h3 id='CompanyName'></h3>
<br>
   <div id='TopContainerTitle'>Potential Growth in Eligible Units</div>
   <div id='TopContainer' class='Container'>
   <div id='MixProgressionContainer'>
      <table id='MixProgression' cellspacing='5' align='center'>
         <thead>
         <tr>
            <th class='dataTitle HiddenBorder' colspan='5' >Percentage of Sales by OS and Touch</th>
         </tr>
         </thead>
         <tbody>
         <tr>
            <td class='HiddenBorder'></td>
            <th id='DatePeriod' class='dataTitle HiddenBorder' colspan='3'></th>
            <td class='HiddenBorder'></td>
         </tr>
         <tr>
            <td class='HiddenBorder'></td>
            <td class='HiddenBorder'></td>
            <td colspan='2' class='HiddenBorder'>
               <div id='HorizArrow'></div>
            </td>
            <td class='HiddenBorder'></td>
         </tr>
         <tr>
            <th id='LeftHeaderT' style='font-weight:normal;'>
               <div class='VerticalTextLeft' 
                  style='font-weight:normal;'>Touch
               </div>
            </th> 
            <td id='MP11' class='MixProgressionData'></td>
            <td id='MP12' class='MixProgressionData'></td>
            <td id='MP13' class='MixProgressionData'></td>
            <td rowspan='2' class='HiddenBorder'>
               <div id='VertArrow'></div>
            </td>
         </tr>
         <tr>
            <th id='LeftHeaderB' style='font-weight:normal;'>
               <div class='VerticalTextLeft' 
                  style='font-weight:normal;'>No Touch
               </div>
            </th> 
            <td id='MP21' class='MixProgressionData'></td>
            <td id='MP22' class='MixProgressionData'></td>
            <td id='MP23' class='MixProgressionData'></td>
            <td class='HiddenBorder'></td>
         </tr>
         </tbody>
         <tfoot>
         <tr>
            <td class='HiddenBorder'></td>
            <td id='41' class='MixProgressionFooter'>OS 1 Pro</td>
            <td id='42' class='MixProgressionFooter'>OS 2/3</td>
            <td id='43' class='MixProgressionFooter'>OS 2/3 Pro</td>
            <td class='HiddenBorder'></td>
         </tr>
         </tfoot>
      </table>
   </div>
   <div id='IncentiveContainer'>
      <div class='dataTitle'>Incentive Growth Potential</div>
      <br>
      <div>
         <div class='IncentivePotential'>Convert Touch</div>
         <div id='Os2TOs2PT' class='MixProgressionChange'></div>
      </div>
      <br>
      <div>
         <div class='IncentivePotential'>Convert OS</div>
         <div id='Os2POs2PT' class='MixProgressionChange'></div>
      </div>
   </div>
   </div>
</div>

<script language='JavaScript' type='text/JavaScript'>
   //Test Alert
   //console.log($('#RegionSelect option:selected').index());
   
   $('#Loading').toggle();
   var displayLoad = 0;
   
   function fnCheckCountryDD(){
      if ($("#CountrySelect option[value='none']").text() != 'All') {
         $("#CountrySelect option[value='none']").text('All Countries');
         $("#CountrySelect option[value='none']").prop('disabled', false);
      }
      
      if ($('#RegionSelect option:selected').text() == 'WW') {
         $('#DistiSelect option:eq(0)').text('Select Distributor');
         $('#DistiSelect option:eq(0)').prop('disabled', true);
      }
      else {
         $('#DistiSelect option:eq(0)').text('All Sub-Distributors');
         $('#DistiSelect option:eq(0)').prop('disabled', false);
         
      }
   }
   
   function fnDistiClick() {
      if ($('#DistiSelect option:selected').index() != 0 ||
            $('#RegionSelect option:selected').index() != 0) {
         document.frmMixProgression.hidAction.value='SelectDisti';
         if($('#RegionSelect option:selected').index() != 0 
               && $('#DistiSelect option:selected').index() == 0){
            var lstDisti /*= $('#DistiSelect option:gt(0)')*/;
            $.each( $('#DistiSelect option:gt(0)'), function (key, id) {
               if(lstDisti == '' || lstDisti == null) {
                  lstDisti = "'" + id.value + "'";
               }
               else {
                  lstDisti = lstDisti + ",'" + id.value + "'";
               }});
            $('#hidValue').val(lstDisti);
         }
         else {
            $('#hidValue').val("'" + $('#DistiSelect option:selected').val() + "'");
         }
         document.frmMixProgression.hidCountry.value=document.getElementById('CountrySelect').value;
         document.frmMixProgression.hidRegion.value=$('#RegionSelect option:selected').text();
         document.frmMixProgression.submit();
      }
   }
   
   function setSelectedValue(selectObj, valueToSet) {
      for (var i = 0; i < selectObj.options.length; i++) {
         if (selectObj.options[i].value== valueToSet) {
            selectObj.options[i].selected = true;
            return;
         }
      }
   }

   function fnCountrySelected() {
      $('#Loading').toggle();
      $('#btnGo').prop('disabled', !$('#btnGo').prop('disabled'));
      var str = $('#CountrySelect option:selected').val();
      strOptions = $('#RegionSelect option:selected').text();
      var newOptions;
      var strUrl = 'Ajax/<%= AjaxName %>.asp?grab=distilist&id=' + str;
      if(strOptions != 'WW') {
         strUrl = strUrl + '&option=' + fnURLify(strOptions);
      }
      
      $.ajax({
         dataType: 'json',
         url: strUrl,
         success: function(result){
            newOptions = result;
            
            $('#DistiSelect option:gt(0)').remove();
            var $el = $("#DistiSelect");
            $.each(newOptions, function(value, key) {
               $el.append($("<option></option>")
               .attr("value", key.id).html(key.reseller));
            });
         },
         complete: function() {
            fnCheckCountryDD();
            document.getElementById('DistiSelect').focus();
            $('#Loading').toggle();
            $('#btnGo').prop('disabled', !$('#btnGo').prop('disabled'));
         }
      });
      if (str == 'none') {
         document.getElementById('DistiSelect').selectedIndex = 0;
      }
   }

   function fnDistiSelected() {
      $('#Loading').toggle();
      $('#btnGo').prop('disabled', !$('#btnGo').prop('disabled'));
      var str = $('#DistiSelect').val();
      $('#hidValue').val(fnURLify(str));
      
      if (str != 'none') {
         var http = new XMLHttpRequest();
         http.onreadystatechange = function() {
            if (http.readyState == 4 && http.status == 200) {
               var objSelect = document.getElementById('CountrySelect');
               setSelectedValue(objSelect, http.responseText);
               fnCheckCountryDD();
               $('#Loading').toggle();
               $('#btnGo').prop('disabled', !$('#btnGo').prop('disabled'));
            }
         }
         http.open('GET', 'Ajax/<%= AjaxName %>.asp?grab=country&id=' + str, true);
         http.send();
      }
      else {
         var objSelect = document.getElementById('CountrySelect');
         setSelectedValue(objSelect, 'none');
      }
   }

   function fnRegionSelected() {
      $('#Loading').toggle();
      $('#btnGo').prop('disabled', !$('#btnGo').prop('disabled'));
      var str = '';
      var passedFirst = false;
      str = '&id=' + fnURLify($('#RegionSelect option:selected').text());
      document.frmMixProgression.hidValue.value = str;
      str = str + '&req=<%= WebPageName %>';
      
      var newOptions;
      
      $.ajax({
         dataType: 'json',
         url: 'Ajax/<%= AjaxName %>.asp?grab=regionchange' + str,
         success: function(result){
            newOptions = result;
            $('#CountrySelect option:gt(0)').remove();
            var $el = $("#CountrySelect");
            $.each(newOptions, function(value, key) {
               $el.append($("<option></option>")
               .attr("value", key.cc).html(key.name));
            });
         },
         error: function(err1, err2, err3) {
            //console.log(err1);
            //console.log(err2);
            //console.log(err3);
         },
         complete: function() {
            fnCheckCountryDD();
            fnCountrySelected();
            document.getElementById('CountrySelect').focus();
            $('#Loading').toggle();
            $('#btnGo').prop('disabled', !$('#btnGo').prop('disabled'));
         }
      });
   }
   
   function fnExport() { //Was still a work in progress during my employment, went to lowest priority so never got to it
      if (document.getElementById('DistiSelect').value != 'none') {
      
         html2canvas(document.getElementById('MainContainer'), {
            onrendered: function(canvas) {
               var imgData = canvas.toDataURL(
                  'image/jpeg');
               var doc = new jsPDF(); 
               doc.addImage(imgData, 'jpeg', 10, 10);
               doc.save('Test.pdf');
            },
            background: '#FFFFFF',
            allowTaint: true,
            taintTest: false
         });
      }
   }
   
   function fnURLify(UrlToBe) {
   UrlToBe = "%27" + UrlToBe + "%27";
   UrlToBe = UrlToBe.replace(/\ /g, '%20');
   
   return UrlToBe;
   }
   
   function fnFormatData(perData, strLabel) {
      return "<span style='font-size:12Px;font-weight:500;'>" + perData + 
             "%</span><br><span style='font-size:12px;'>" + strLabel + "</span>";
   }
   
   function getOffset( el ) {
      return { height: el.offsetHeight==0?x1:el.offsetHeight, width: el.offsetWidth };
   }
   
   function createArrows(){
      var objOffset = getOffset( document.getElementById('HorizArrow') );
      var x1 = objOffset.width * .25; 
      var y1 = objOffset.height / 2; 
      var x2 = objOffset.width * .75; 
      var y2 = objOffset.height / 2; 
      
      document.getElementById('HorizArrow').innerHTML = '<svg><defs>' + 
            '<marker id=\'markerArrow\' markerWidth=\'13\' markerHeight=\'13\' refX=\'2\' refY=\'6\' orient=\'auto\' markerUnits=\'userSpaceOnUse\'>' + 
            '<path d=\'M1,1 L2,11 L10,7 L1,1\' style=\'fill: #00C900;\'/></marker></defs>' +
            '<path d=\'M' + x1 + ',' + y1 + ' L' + x2 + ',' + y2 + '\'/></svg>';
            
      x1 = objOffset.height / 2; 
      y1 = objOffset.width * .4; 
      x2 = objOffset.height / 2; 
      y2 = objOffset.width * .15; 
      
      document.getElementById('VertArrow').innerHTML = '<svg><defs>' + 
            '<marker id=\'markerArrow\' markerWidth=\'13\' markerHeight=\'13\' refX=\'2\' refY=\'6\' orient=\'auto\' markerUnits=\'userSpaceOnUse\'>' + 
            '<path d=\'M1,1 L2,11 L10,7 L1,1\' style=\'fill: #00C900;\'/></marker></defs>' +
            '<path d=\'M' + x1 + ',' + y1 + ' L' + x2 + ',' + y2 + '\'/></svg>';
   }
         
   $(window).resize(function(){
      createArrows();
   });
   $(window).load(function(){
      if($('#RegionSelect option:selected').text() == 'WW'
         && $('#CountrySelect option:selected').text() == 'Select Country'
         && $('#DistiSelect option:selected').text() == 'Select Distributor') {
         document.getElementById('TopContainerTitle').style.visibility='hidden';
         document.getElementById('TopContainer').style.visibility='hidden';
         document.getElementById('HorizArrow').style.visibility='hidden';
         document.getElementById('VertArrow').style.visibility='hidden';
      }
      else {
         document.getElementById('TopContainerTitle').style.visibility='visible';
         document.getElementById('TopContainer').style.visibility='visible';
         document.getElementById('HorizArrow').style.visibility='visible';
         document.getElementById('VertArrow').style.visibility='visible';
         if($('#DistiSelect option:selected').text() != 'Select Distributor') {
            document.getElementById('CompanyName').innerHTML = $('#DistiSelect option:selected').text();
         }
         else{
            document.getElementById('CompanyName').innerHTML = $('#RegionSelect option:selected').text();
         }
         fnCheckCountryDD();
      }
      createArrows();
      document.getElementById('RegionSelect').focus();
   });
</script>

<%
DIM totOs2PROT, totOs2PRO, totOs1PRO, DeviceGoal
IF request.form("hidAction")="SelectDisti" THEN
   'arrMonths to hold Months for bar graph, strYear = current year
   DIM arrMonths(5), specCountry
   
   sSql = " SELECT DistiSoldToId, LEFT(DateName(MONTH,CAST(Invoicedate AS DateTime)),3) + ' ' + Left(InvoiceDate, 4)  AS InvoiceDate, DistiCountryCode, "
         sSql = sSql & " SUM(CASE WHEN  OS = 'OS 1 Pro' AND Touch = 'Y'  THEN QTYSold ELSE 0 END)                           AS [Os1PROT], "
         sSql = sSql & " SUM(CASE WHEN  OS = 'OS 1 Pro' AND Touch = 'N'  THEN QTYSold ELSE 0 END)                           AS [Os1PRO], "
         sSql = sSql & " SUM(CASE WHEN (OS = 'OS 2' OR OS = 'OS 2.1') AND Touch = 'Y' THEN QTYSold ELSE 0 END)         AS [Os2T], "
         sSql = sSql & " SUM(CASE WHEN (OS = 'OS 2' OR OS = 'OS 2.1')  AND Touch = 'N'THEN QTYSold ELSE 0 END)         AS [Os2], "
         sSql = sSql & " SUM(CASE WHEN (OS = 'OS 2 PRO' OR OS = 'OS 2.1 PRO')  AND Touch = 'Y'THEN QTYSold ELSE 0 END) AS [Os2PROT], "
         sSql = sSql & " SUM(CASE WHEN (OS = 'OS 2 PRO' OR OS = 'OS 2.1 PRO')  AND Touch = 'N'THEN QTYSold ELSE 0 END) AS [Os2PRO], "
         sSql = sSql & " SUM(CASE WHEN  OS = 'OS 3' AND Touch = 'Y'  THEN QTYSold ELSE 0 END)                              AS [Os3T], "
         sSql = sSql & " SUM(CASE WHEN  OS = 'OS 3' AND Touch = 'N'  THEN QTYSold ELSE 0 END)                              AS [Os3], "
         sSql = sSql & " SUM(CASE WHEN  OS = 'OS 3 PRO' AND Touch = 'Y' THEN QTYSold ELSE 0 END)                           AS [Os3PROT], "
         sSql = sSql & " SUM(CASE WHEN  OS = 'OS 3 PRO' AND Touch = 'N' THEN QTYSold ELSE 0 END)                           AS [Os3PRO] "
         sSql = sSql & " FROM Project1.dbo.FY16H1_EXPORT(NOLOCK) "
         sSql = sSql & " INNER JOIN Project1.dbo.Country(NOLOCK) "
         sSql = sSql & " ON DistiCountryCode = CountryCode "
         sSql = sSql & " WHERE DistiSoldToID IN (" & CSTR(request.form("hidValue")) & ") "
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
         sSql = sSql & " GROUP BY DistiSoldToId, LEFT(DateName(MONTH,CAST(Invoicedate AS DateTime)),3) + ' ' + Left(InvoiceDate, 4) , DistiCountryCode "
         sSql = sSql & " ORDER BY InvoiceDate DESC "
   'response.write sSql
    
      DIM Os1PROT(5), Os1PRO(5), Os2T(5), Os2(5), Os2PROT(5), Os2PRO(5), Os3(5), Os3T(5), Os3PRO(5), Os3PROT(5)
      DIM placeCounter, totOs1PROT, totOs2T, totOs2, totOs3, totOs3T, totOs3PRO, totOs3PROT, MinDate, MaxDate, testDate
      
      recordSet.Open sSql, connection
   
      specCountry = recordSet("DistiCountryCode")
      
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
      
      IF totOs2T <= 0 THEN
         totOs2T = 0
      END IF
      IF totOs2PRO <= 0 THEN
         totOs2PRO = 0
      END IF
      
      DIM arrGraph(4), TotalDevice, RoundCount, DateRange, arrDollar(1)
         
      TotalDevice = totOs1PROT + totOs2T + totOs2 + totOs2PROT + totOs2PRO  _
                  + totOs3 + totOs3PRO + totOs3T + totOs3PROT

      
      RoundCount = 3
      DateRange = MaxDate
      DateRange = DateRange & " - "
      DateRange = DateRange & MinDate
         
      IF TotalDevice <> 0 THEN
         arrGraph(0) = Round((totOs1PROT                / TotalDevice), RoundCount) * 100
         arrGraph(1) = Round(((totOs2T + totOs3T)       / TotalDevice), RoundCount) * 100
         arrGraph(2) = Round(((totOs2 + totOs3)         / TotalDevice), RoundCount) * 100
         arrGraph(3) = Round(((totOs2PROT + totOs3PROT) / TotalDevice), RoundCount) * 100
         arrGraph(4) = Round(((totOs2PRO + totOs3PRO)   / TotalDevice), RoundCount) * 100
      
         arrDollar(0) = (totOs2T + totOs3T)  * payout
         IF specCountry = "CHN" OR specCountry = "BRA" OR specCountry = "RUS" THEN
            arrDollar(1) = (totOs2PRO + totOs3PRO) * specpayout
         ELSE
            arrDollar(1) = (totOs2PRO + totOs3PRO) * payout
         END IF
      ELSE
         arrGraph(0) = 0
         arrGraph(1) = 0
         arrGraph(2) = 0
         arrGraph(3) = 0
         arrGraph(4) = 0
            
         arrDollar(0) = 0
         arrDollar(1) = 0
      END IF
         
      response.write "<script language='javascript' type='text/javascript'>"
      response.write "document.getElementById('DatePeriod').innerHTML = '" & DateRange & "';"
      response.write "document.getElementById('MP12').innerHTML = fnFormatData('" & arrGraph(1) & "', 'OS 2x/3<br>Touch');"
      response.write "document.getElementById('MP13').innerHTML = fnFormatData('" & arrGraph(3) & "', 'OS 2x/3 Pro<br>Touch');"
      response.write "document.getElementById('MP22').innerHTML = fnFormatData('" & arrGraph(2) & "', 'OS 2x/3<br>No Touch');"
      response.write "document.getElementById('MP23').innerHTML = fnFormatData('" & arrGraph(4) & "', 'OS 2x/3 Pro<br>No Touch');"
      response.write "document.getElementById('MP11').innerHTML = fnFormatData('" & arrGraph(0) & "', 'OS 1 Pro<br>Touch');"
      
      response.write "document.getElementById('Os2TOs2PT').innerHTML = 'There are <span class=\'GrnTextBorder\'>" & FORMATNUMBER((totOs2PRO + totOs3PRO), 0) & _
            "</span> units (or <span class=\'GrnTextBorder\'>" & _
            FORMATNUMBER(arrGraph(4), 0) & "%</span>) " & _
            "of OS 2/3 Pro devices that are not Touch enabled. Converting these to Touch enabled will result in <span class=\'GrnTextBorder\'>USD&nbsp;" & _
            FORMATNUMBER(arrDollar(1), 0) & "</span> of additional incentives.';"
      response.write "document.getElementById('Os2POs2PT').innerHTML = 'There are <span class=\'GrnTextBorder\'>" & FORMATNUMBER((totOs2T + totOs3T), 0) & _
            "</span> units (or <span class=\'GrnTextBorder\'>" & _
            FORMATNUMBER(arrGraph(1), 0) & "%</span>) " & _
            "of Touch enabled devices that do not have a Professional version of OS. Converting these to OS 2/3 Pro will result in <span class=\'GrnTextBorder\'>USD&nbsp;" & _
            FORMATNUMBER(arrDollar(0), 0) & "</span> of additional incentives.';"
      
      response.write "</script>"
ELSE
   totOs2PROT = 0
   totOs2PRO = 0
   totOs1PRO = 0
   DeviceGoal = 0
END IF
%>
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