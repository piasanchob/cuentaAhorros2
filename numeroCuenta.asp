<html>
<head>
<title>Numeros de Cuentas</title>
</head>
<body bgcolor="#003366">
<center>

  <form method="POST" action="connection.asp">
  <p style="color:white" > <font face="Verdana" size="5"> Numeros de Cuenta <p>
  <table border="1" cellspacing="1" bordercolor="#111111" id="AutoNumber1" height="82">
    
    


    <%
    Do Until rs.EOF
        Response.Write("<tr>")
            For Each X In rs.Fields
                Response.Response.Write("<td>"&x.value & "</td>")

            Next
        Response.Write("</tr>")
        rs.movenext
    Loop
    
    %>
    
  </table>
  </form>
  </center>
</body>
</html>