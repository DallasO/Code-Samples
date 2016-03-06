<%
   '************************************************
   'Ajax for PartnerInsightPages to return Information
   '**** Current Pages:                         ****
   '**** (dev)PartnerInsightPotential.asp       ****
   '**** (dev)PartnerInsightAccel.asp           ****
   '************************************************
   
   '*** Dev Switch ***
   DIM onDev
   onDev = FALSE
   
   IF OnDev THEN
      response.Buffer = TRUE
      ON ERROR RESUME NEXT
   END IF
   
   response.expires=-1
   DIM connection,recordSet,sSql
   SET connection = server.CreateObject ("ADODB.Connection")
   SET recordSet = Server.CreateObject ("ADODB.RecordSet")
   connection.ConnectionTimeout = 300
   
   connection.Open = "Provider=SQLOLEDB;Data Source=Server1;Initial Catalog=Project1;uid=WebReportsUser;pwd=Pa$$word;"
 
   server.ScriptTimeout=300
   connection.CommandTimeOut=300

   DIM strName, sArrayLogon, sMessage
   strName = request.servervariables("logon_user")
   sMessage=""

   sArrayLogon=Split(strName, "\", -1, 1)
   strName = sArrayLogon(1)
   
   IF Session("UserSubsidiary") = "" THEN
      x = 0
      Session("UserSubsidiary") = "''"
      sSql = " SELECT * FROM Project1.dbo.LOEM_Project1_AreaPermissions "
      sSql = sSql & "WHERE UserAlias='" & strName & "' "
      
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
      
      Session("txtPermission") = "You are logged in as " & strName & ", SpecialDevice1= " & Session("includeSpecialDevice1Data")&", MNA= " & Session("UserMNA") & ", Geo= " 
      
      IF x > 70 THEN
         Session("txtPermission") = Session("txtPermission") & "ALL"
      ELSE
         Session("txtPermission") = Session("txtPermission") & "Limited"
      END IF
   END IF

   DIM grab, id, Result, FirstResult
   grab = request.querystring("grab")
   
   IF grab = "country" THEN
      'get the id parameter from URL
      id = request.querystring("id")

      'lookup all hints from array if length of id>0
      IF LEN(id)>0 THEN
         sSQL = " SELECT TOP 1 Export.DistiCountryCode AS CountryCd "
         sSql = sSql & " FROM Project1.dbo.FY16H1_EXPORT Export(NOLOCK) "
         sSql = sSql & " WHERE Export.DistiSoldToId IN ('" & CSTR(id) & "') "
         ''response.write sSql
      
         recordSet.Open sSql, connection
         IF recordSet.BOF OR NOT recordSet.EOF THEN 
            Result = CSTR(recordSet("CountryCd"))
         ELSE
            Result = 0
         END IF
         recordSet.Close
      END IF
   
      response.ContentType = "text/plain"
      response.write Result
      
   ELSEIF grab = "distilist" THEN
      'get the id parameter from URL
      id = request.querystring("id")
      grabOption = request.querystring("option")
      
      'lookup all hints from array if length of id>0
      IF LEN(id)>0 THEN
         sSQL = " SELECT DISTINCT [DistiSoldToID], [DistiName] "
         sSQL = sSql & " FROM Project1.dbo.FY16H1_EXPORT(NOLOCK) "
         sSQL = sSql & " INNER JOIN Project1.dbo.Country(NOLOCK) "
         sSQL = sSql & " ON CountryCode = DistiCountryCode "
         IF LEN(grabOption) > 0 THEN
            sSQL = sSql & " INNER JOIN Project1.dbo.UIDynamic(NOLOCK) "
            sSQL = sSql & " ON DynVal2 = DistiSoldToId "
         END IF
         sSQL = sSql & " WHERE SubsidiaryID IN (" & Session("UserSubsidiary") & ") "
         IF CSTR(id) <> "none" THEN
            sSql = sSql & " AND DistiCountryCode LIKE '" & CSTR(id) & "' "
         END IF
         IF Session("UserMNA") <> "ALL"  AND Session("UserMNA") <> "" THEN
            sSQL = sSql & " AND OEM = '" & Session("UserMNA") & "' "
         END IF
         IF LEN(grabOption) > 0 THEN
            sSQL = sSql & " AND DynVal1 = " & CSTR(grabOption) & " "
            sSQL = sSql & " AND PageName = 'devPartnerInsightPotential' "
         END IF
         sSQL = sSql & " ORDER BY [DistiName]; "
         
         passedFirstResult = FALSE
         Result = "["
         recordSet.Open sSql, connection
         DO WHILE recordSet.BOF OR NOT recordSet.EOF 
            IF passedFirstResult THEN
               Result = Result & ", "
            END IF
            Result = Result & "{""id"" : """ & CSTR(recordSet("DistiSoldToId")) & ""","
            Result = Result & """reseller"" : """ & Server.HTMLEncode(recordSet("DistiName")) & " - " & CSTR(recordSet("DistiSoldToId")) & """}"
            passedFirstResult = TRUE
            recordSet.MoveNext
         LOOP
         Result = Result & "]"
         recordSet.Close
      END IF
   
      response.ContentType = "application/json"
      response.write Result
      
   ELSEIF grab = "regionchange" THEN
      'get the id parameter from URL
      id = request.querystring("id")
      
      'lookup all hints from array if length of id>0
      IF LEN(id)>0 THEN
         sSQL = " SELECT DISTINCT country.[CountryCode], country.[CountryName] "
         sSQL = sSql & " FROM Project1.dbo.FY16H1_EXPORT export(NOLOCK) "
         sSQL = sSql & " LEFT JOIN Project1.dbo.UIDynamic dyna(NOLOCK) "
         sSQL = sSql & " ON dyna.dynVal2 = export.DistiSoldToId "
         sSQL = sSql & " INNER JOIN Project1.dbo.Country country(NOLOCK) "
         sSQL = sSql & " ON country.CountryCode = export.DistiCountryCode "
         sSQL = sSql & " WHERE dyna.PageName = '" & CSTR(request.querystring("req")) & "' "
         sSQL = sSql & " AND country.SubsidiaryID IN (" & Session("UserSubsidiary") & ") "
         IF CSTR(id) <> "'WW'" THEN
            sSql = sSql & " AND dyna.dynVal1 IN (" & CSTR(id) & ") "
         END IF
         IF Session("UserMNA") <> "ALL"  AND Session("UserMNA") <> "" THEN
            sSQL = sSql & " AND export.OEM LIKE '" & Session("UserMNA") & "' "
         END IF
         sSQL = sSql & " ORDER BY country.CountryName; "
         
         passedFirstResult = FALSE
         Result = "["
         recordSet.Open sSql, connection
         DO WHILE recordSet.BOF OR NOT recordSet.EOF 
            IF passedFirstResult THEN
               Result = Result & ", "
            END IF
            Result = Result & "{""cc"" : """ & CSTR(recordSet("CountryCode")) & ""","
            Result = Result & """name"" : """ & CSTR(recordSet("CountryName")) & """}"
            passedFirstResult = TRUE
            recordSet.MoveNext
         LOOP
         Result = Result & "]"
         recordSet.Close
      END IF
   
      response.ContentType = "application/json"
      response.write Result
   ELSE
      IF OnDev THEN
         response.write "<html><body>Test Page!</body></html>"
      END IF
   END IF

   ' Error Handler
   IF Err.Number <> 0 THEN
 
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
      SELECT CASE Err.Number
 
 		CASE ""		'	Specific error messages
 		'	Placeholder for specific error message code
      '	You can handle custom errors here	
 
      CASE ELSE		'	General Error Response
 
 		IF IsObject(objConnection) THEN
 	
         IF objConnection.Errors.Count > 0 THEN
   %>

   <B>Database Connection Object</B>
 
   <%					FOR intLoop = 0 TO objConnection.Errors.Count - 1	%>
 
   Error No: <%= objConnection.Errors(intLoop).Number %><BR>
   Description: <%= objConnection.Errors(intLoop).Description %><BR>

   Source: <%= objConnection.Errors(intLoop).Source %><BR>
   SQLState: <%= objConnection.Errors(intLoop).SQLState %><BR>
   NativeError: <%= objConnection.Errors(intLoop).NativeError %><P>
 
   <%					NEXT
 			END IF
 
 		END IF
 
      IF Err.Number <> 0 THEN
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
<%		END IF
 
 	END SELECT
   END IF
 
   Response.End()
   SET recordSet = NOTHING
   SET connection = NOTHING
%>