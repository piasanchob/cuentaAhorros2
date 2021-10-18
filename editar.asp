<%
Dim rs
Dim porcentaje
Dim parentesco
Dim ced
Dim cedB
Dim nom

ced=Request.form("ced")
cedB=Request.form("cedB")
nombre =Request.form("nom")
porcentaje =Request.form("porcentaje")
parentesco =Request.form("paren")

Response.write(nombre)
Response.write("<br>")

Set con = Server.createObject("ADODB.Connection")

con.ConnectionString= "Provider=SQLNCLI11;Server=DESKTOP-94UDDNK;Database=cuentaAhorros;uid=sa;pwd=4321;"

con.open    
DIM cmd
SET cmd = Server.CreateObject("ADODB.Command")
SET cmd.ActiveConnection = con


'Prepare the stored procedure
cmd.CommandText = "ValidarEdit"
cmd.CommandType = 4  'adCmdStoredProc

cmd.Parameters("@Cedula") = ced
cmd.Parameters("@CedulaB") = cedB

'Execute the stored procedure
'This returns recordset but you dont need it

cmd.Execute()
rs = cmd.Parameters(0)


if rs="1" then
    DIM upd
    SET upd = Server.CreateObject("ADODB.Command")
    SET upd.ActiveConnection = con

    upd.CommandText = "validarPorcentaje"
    upd.CommandType = 4  'adCmdStoredProc

    upd.Parameters("@Porcentaje2") = porcentaje
    upd.Parameters("@Cedula") = ced
    upd.Execute()
    rs = upd.Parameters(0)

    if rs="1" then

        
        SET upd = Server.CreateObject("ADODB.Command")
        SET upd.ActiveConnection = con
        upd.CommandText = "ActualizarDatos"
        upd.CommandType = 4  'adCmdStoredProc

        upd.Parameters("@Cedula") = ced
        upd.Parameters("@CedulaB") = cedB
        upd.Parameters("@Nombre") = nombre
        upd.Parameters("@Porcentaje") = Porcentaje
        upd.Parameters("@Parentesco") = parentesco
        upd.Execute()

        Response.Redirect("porcentajeMenor.asp")

    elseif rs="0" then
        Response.Redirect("porcentajeMayor.asp")


    else
        
        SET upd = Server.CreateObject("ADODB.Command")
        SET upd.ActiveConnection = con
        upd.CommandText = "ActualizarDatos"
        upd.CommandType = 4  'adCmdStoredProc

        upd.Parameters("@Cedula") = ced
        upd.Parameters("@CedulaB") = cedB
        upd.Parameters("@Nombre") = nombre
        upd.Parameters("@Porcentaje") = Porcentaje
        upd.Parameters("@Parentesco") = parentesco
        upd.Execute()

        Response.Redirect("mensajeEditado.asp")
    end if

else
    Response.Redirect("DatosNoEncontrados.asp")

end if




%>







