<%
   '************************************************
   'Ajax page for CompeteDataReport.asp to call for 
   'data it is looking for
   '************************************************
   
   
   response.expires=-1
   DIM connection,recordSet,sSql
   SET connection = server.CreateObject ("ADODB.Connection")
   SET recordSet = Server.CreateObject ("ADODB.RecordSet")
   connection.ConnectionTimeout = 300
   
   connection.Open = "Provider=SQLOLEDB;Data Source=Server1;Initial Catalog=DeviceMain;uid=WebReportsUser;pwd=Pa$$word;"
 
   server.ScriptTimeout=300
   connection.CommandTimeOut=300

   DIM grab, id, Result
   grab = request.querystring("grab")
   
   IF grab = "country" THEN
      'get the id parameter from URL
      id = request.querystring("id")

      'lookup all hints from array if length of id>0
      IF LEN(id)>0 THEN
         sSQL = " SELECT DISTINCT CASE Country.AreaName WHEN 'Western Europe' THEN 'WE' ELSE Compete.CountryCode END AS CountryCd "
         sSql = sSql & " FROM Project2.dbo.vw_CompeteData Compete(NOLOCK) "
         sSql = sSql & " INNER JOIN DeviceMain.dbo.Country Country(NOLOCK) "
         sSql = sSql & " ON Country.CountryCode = Compete.CountryCode "
         sSql = sSql & " WHERE [Invoice Date] >= DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()), 0) "
         sSql = sSql & " AND Compete.TPID IN ('" & CSTR(id) & "') "
         sSql = sSql & " ORDER BY CountryCd "
         'response.write sSql
      
         recordSet.Open sSql, connection
         IF recordSet.BOF OR NOT recordSet.EOF THEN 
            Result = CSTR(recordSet("CountryCd"))
         ELSE
            Result = 0
         END IF
         recordSet.Close
      END IF
   
      response.ContentType = "text/plain"
      response.write(Result)
      
   ELSEIF grab = "resellerList" THEN
      'get the id parameter from URL
      id = CSTR(request.querystring("id"))

      'lookup all hints from array if length of id>0
      IF LEN(id)>0 THEN
         sSQL = " SELECT DISTINCT Compete.TPID, Compete.ResellerName "
         sSql = sSql & " FROM Project2.dbo.vw_CompeteData Compete(NOLOCK) "
         sSql = sSql & " INNER JOIN DeviceMain.dbo.Country Country(NOLOCK) "
         sSql = sSql & " ON Country.CountryCode = Compete.CountryCode "
         sSql = sSql & "WHERE [Invoice Date] >= DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()), 0) "
         IF id <> "none" THEN
            IF id <> "WE" THEN
               sSql = sSql & "AND Country.CountryCode IN ('" & id & "') "
            ELSE
               sSql = sSql & "AND Country.AreName IN ('" & id & "') "
            END IF
         END IF
         sSql = sSql & " ORDER BY ResellerName "
         'response.write sSql
         DIM FirstResult
         passedFirstResult = FALSE
         Result = "["
         recordSet.Open sSql, connection
         DO WHILE recordSet.BOF OR NOT recordSet.EOF 
            IF passedFirstResult THEN
               Result = Result & ", "
            END IF
            Result = Result & "{""value"" : """ & CSTR(recordSet("TPID")) & ""","
            Result = Result & "{""key"" : """ & CSTR(recordSet("ResellerName")) & """}"
            passedFirstResult = TRUE
            recordSet.MoveNext
         LOOP
         Result = Result & "]"
         recordSet.Close
      END IF
   
      response.ContentType = "application/json"
      response.write(Result)
      
   ELSEIF grab = "countryPI" THEN
      'get the id parameter from URL
      id = request.querystring("id")

      'lookup all hints from array if length of id>0
      IF LEN(id)>0 THEN
         sSQL = " SELECT DISTINCT CASE Country.AreaName WHEN 'Western Europe' THEN 'WE' ELSE export.CountryCode END AS CountryCd "
         sSql = sSql & " FROM DeviceFY16H1.dbo.FY16H1_EXPORT export(NOLOCK) "
         sSql = sSql & " INNER JOIN DeviceMain.dbo.Country Country(NOLOCK) "
         sSql = sSql & " ON Country.CountryCode = export.DistiCountryCode "
         sSql = sSql & " WHERE [Invoice Date] >= DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()), 0) "
         sSql = sSql & " AND Compete.TPID IN ('" & CSTR(id) & "') "
         sSql = sSql & " ORDER BY CountryCd "
         'response.write sSql
      
         recordSet.Open sSql, connection
         IF recordSet.BOF OR NOT recordSet.EOF THEN 
            Result = CSTR(recordSet("CountryCd"))
         ELSE
            Result = 0
         END IF
         recordSet.Close
      END IF
   
      response.ContentType = "text/plain"
      response.write(Result)
   END IF
 %>