<%

Dim con
Dim user
Dim password
Dim query
Dim rs
Dim ra


user =Request.form("username")
password =Request.form("pass")
Set con = Server.createObject("ADODB.Connection")



con.ConnectionString= "Provider=SQLNCLI11;Server=DESKTOP-94UDDNK;Database=cuentaAhorros;uid=sa;pwd=4321;"

con.open    


DIM cmd
SET cmd = Server.CreateObject("ADODB.Command")
SET cmd.ActiveConnection = con


'Prepare the stored procedure
cmd.CommandText = "validarUsuario"
cmd.CommandType = 4  'adCmdStoredProc

cmd.Parameters("@Usuario") = user
cmd.Parameters("@Contra") = password

'Execute the stored procedure
'This returns recordset but you dont need it

cmd.Execute()
rs = cmd.Parameters(0)


if rs="1" then
    Response.Redirect("inicio.asp")

else
    Response.Redirect("inicio.asp")

end if






%>