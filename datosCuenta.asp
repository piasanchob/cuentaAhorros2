<html lang="en">

<head>
<title>Datos de la Cuenta</title>
<style> table, td {border: 2px solid black;}</style>
</head>
<body bgcolor="#003366">
<%
Dim con
Dim numCuenta
Dim query
Dim rs


numCuenta =Request.form("numCuenta")
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
    <th>Datos de la Cuenta</th>
</tr>
<%
    'Do Until rs.EOF
        'Response.Write("<tr>")
            'For Each x In rs.Fields
                'Response.Write("<td>" &x.value & "</td>")
                'Response.Write("<br>")
            'Next
        'Response.Write("</tr>")
        'rs.movenext
    'Loop
%>

</table>
</center>
</body>
</html>