<%
Dim fechaIni
Dim fechaFin
Dim cuota 
Dim objetivo
Dim saldo
Dim interes


fechaIni =Request.form("fechaIni")
fechaFin =Request.form("fechaFin")
cuota =Request.form("cuota")
objetivo = Request.form("objetivo")
saldo =Request.form("saldo")
interes = Request.form("interes")
numCuenta = Request.form("numCuenta")
descrip = Request.form("descrip")



Set con = Server.createObject("ADODB.Connection")



con.ConnectionString= "Provider=SQLNCLI11;Server=DESKTOP-94UDDNK;Database=cuentaAhorros;uid=sa;pwd=4321;"

con.open    
DIM upd
SET upd = Server.CreateObject("ADODB.Command")
SET upd.ActiveConnection = con

upd.CommandText = "AgregarCuentaObjetivo"
upd.CommandType = 4  'adCmdStoredProc

upd.Parameters("@InNumCuenta") = numCuenta
upd.Parameters("@InFechaInicio") = fechaIni
upd.Parameters("@InFechaFinal") = fechaFin
upd.Parameters("@InCuota") = cuota
upd.Parameters("@InObjetivo") = objetivo
upd.Parameters("@InSaldo") = saldo
upd.Parameters("@InInteresAcumulado") = interes
upd.Parameters("@InDescripcion") = descrip
upd.Parameters("@InActivo") = 1

upd.Parameters("@OutCodeResult") = 5005


upd.Execute()


Response.Redirect("mensajePersona.asp")



%>