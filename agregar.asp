<%
Dim identificacion
Dim parentesco
Dim porcentaje 
Dim num
Dim rs

parentesco =Request.form("parent")
porcentaje =Request.form("beneficio")
identificacion =Request.form("id")
num = Request.form("numCuenta")


Set con = Server.createObject("ADODB.Connection")



con.ConnectionString= "Provider=SQLNCLI11;Server=DESKTOP-94UDDNK;Database=cuentaAhorros;uid=sa;pwd=4321;"

con.open    
DIM upd
SET upd = Server.CreateObject("ADODB.Command")
SET upd.ActiveConnection = con

upd.CommandText = "ValidarBeneficiarios"
upd.CommandType = 4  'adCmdStoredProc

upd.Parameters("@Cedula") = identificacion
upd.Execute()


rs = upd.Parameters(0)

if rs="1" then
    SET exc = Server.CreateObject("ADODB.Command")
    SET exc.ActiveConnection = con

    exc.CommandText = "validarIdenPersona"
    exc.CommandType = 4  'adCmdStoredProc

    exc.Parameters("@ident") = identificacion

    exc.Execute()
    rs = exc.Parameters(0)
    if rs="1" then
        SET cmd = Server.CreateObject("ADODB.Command")
        SET cmd.ActiveConnection = con

        cmd.CommandText = "agregarBeneficiario"
        cmd.CommandType = 4  'adCmdStoredProc

        cmd.Parameters("@Parentezco") = parentesco
        cmd.Parameters("@Porcentaje") = porcentaje
        cmd.Parameters("@ident") = identificacion
        cmd.Parameters("@Cuenta") = num
        cmd.Execute()
        Response.Redirect"mensajeBeneficiarios.asp"


    else
        SET cmd = Server.CreateObject("ADODB.Command")
        SET cmd.ActiveConnection = con

        cmd.CommandText = "agregarBeneficiario"
        cmd.CommandType = 4  'adCmdStoredProc

        cmd.Parameters("@Parentezco") = parentesco
        cmd.Parameters("@Porcentaje") = porcentaje
        cmd.Parameters("@ident") = identificacion
        cmd.Parameters("@Cuenta") = num
        cmd.Execute()
        Response.Redirect"agregarPersona.asp"

        
    end if


else    
    Response.Redirect"mensajeBeneficiariosError.asp"
end if

%>
 