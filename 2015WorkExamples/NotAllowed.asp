<%
   '************************************************
   'Page for when users don't have permission to view a page
   '************************************************
%>
<!DOCTYPE HTML>
<html>
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
   <meta http-equiv='X-UA-Compatible' content='IE=edge' />
   <script src='Utils/JQuery2.1.4/jquery-2.1.4.min.js'></script>
   <style>
   </style>
   <title>Not Authorized</title>
   <link rel="stylesheet" href="ProjectStyle.css">
   <img src="images/SoftMicro.jpg" alt="SoftMicro">
   <h1>
      Access Not Allowed
   </h1>
</head>
<body>
<form name='frmMixProgression' action='Project13.asp' method='post'>
<strong>You are not authorized to view this page.</strong>
<br>
<br>
<script language='JavaScript' type='text/JavaScript'>
   $(document).ready(function () {
      $('form').append('<p></p>')
         .html('Please contact <a href=\'mailto:OEMI@SoftMicro.com?' +
               'Subject=Access%20Denied%20|%20<%=Session("WebPageName")%>' +
               '\' target=\'_top\'>OEMI@SoftMicro.com</a> if you need access.')
   });
</script>
</form>
</body>
</html>