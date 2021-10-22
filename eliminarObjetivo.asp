<%
Dim fechaIni
Dim fechaFin
Dim cuota 
Dim objetivo
Dim saldo
Dim interes

numCuenta = Request.form("numCuenta")



Set con = Server.createObject("ADODB.Connection")



con.ConnectionString= "Provider=SQLNCLI11;Server=DESKTOP-94UDDNK;Database=cuentaAhorros;uid=sa;pwd=4321;"

con.open    
DIM upd
SET upd = Server.CreateObject("ADODB.Command")
SET upd.ActiveConnection = con

upd.CommandText = "EliminarCuentaObjetivo"
upd.CommandType = 4  'adCmdStoredProc

upd.Parameters("@InNumCuenta") = numCuenta
upd.Parameters("@OutCodeResult") = 50005


upd.Execute()


RESPONSE.WRITE("Se Elimino Correctamente")



%>