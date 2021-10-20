<html lang="en">

<head>
<title>Cuentas</title>
<style> table, td {border: 2px solid black;}</style>
</head>
<body bgcolor="#003366">
<%
Dim con
Dim ced
Dim query
Dim rs


ced =Request.form("ced")
Set con = Server.createObject("ADODB.Connection")
con.ConnectionString= "Provider=SQLNCLI11;Server=DESKTOP-94UDDNK;Database=cuentaAhorros;uid=sa;pwd=4321;"

con.open    
DIM cmd
SET cmd = Server.CreateObject("ADODB.Command")
SET cmd.ActiveConnection = con


'Prepare the stored procedure
'cmd.CommandText = "numeroCuentas"
'cmd.CommandType = 4  'adCmdStoredProc

'cmd.Parameters("@Cedula") = ced


'Execute the stored procedure
'This returns recordset but you dont need it

'set rs=cmd.Execute()
%>
<center>
<table>

<tr>
    <th>Numeros de Cuenta</th>
</tr>
<%
    'Do Until rs.EOF
        'Response.Write("<tr>")
            'For Each x In rs.Fields
               ' Response.Write("<td>" &x.value & "</td>")
                'Response.Write("<br>")
           ' Next
        'Response.Write("</tr>")
       ' rs.movenext
   ' Loop
   Response.write("Aqui va los numeros de cuentaq")
%>

</table>
</center>




<center>
    
  <form method="POST" action="datosCuenta.asp">
  <p style="color:white" > <font face="Verdana" size="5"> Cuentas <p>
  <table border="1" cellspacing="1" bordercolor="#111111" id="AutoNumber1" height="82">
    <tr>
      <td height="23"><font color="#FFFFFF" face="Verdana" size="2">numCuenta</font></td>
      <td width="148" height="23">
        <p align="center">
        <font face="Verdana" color="#FFFFFF">
        <input type="text" name="numCuenta" size="20" value=""><font size="2">
        </font></font>
      </td>
    </tr>
    
    <tr>
      <td width="210" colspan="2" height="22">
      <p align="center"><font face="Verdana" color="#FFFFFF"><input type="submit" value="Seleccionar" name="B1"><font size="2">&nbsp;</font></td>
    </tr>
  </table>
  </form>
  </center>
</body>
</html>