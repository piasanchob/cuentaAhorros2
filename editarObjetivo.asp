<%
Dim fechaIni
Dim fechaFin
Dim cuota 
Dim objetivo
Dim saldo
Dim interes
Dim numCuenta

numCuenta=Request.form("numCuenta")
fechaIni =Request.form("fechaIni")
fechaFin =Request.form("fechaFin")
cuota =Request.form("cuota")
objetivo = Request.form("objetivo")
descrip =Request.form("descrip")




Set con = Server.createObject("ADODB.Connection")



con.ConnectionString= "Provider=SQLNCLI11;Server=DESKTOP-94UDDNK;Database=cuentaAhorros;uid=sa;pwd=4321;"

con.open    
DIM upd
SET upd = Server.CreateObject("ADODB.Command")
SET upd.ActiveConnection = con

upd.CommandText = "EditarCuentaObjetivo"
upd.CommandType = 4  'adCmdStoredProc

upd.Parameters("@InNumCuenta") = numCuenta
upd.Parameters("@InFechaInicio") = fechaIni
upd.Parameters("@InFechaFinal") = fechaFin
upd.Parameters("@InCuota") = cuota
upd.Parameters("@InObjetivo") = objetivo
upd.Parameters("@InDescripcion") = descrip
upd.Parameters("@OutCodeResult") = 5005

upd.Execute()


Response.WRITE("La cuenta fue editada Correctamente")



%>