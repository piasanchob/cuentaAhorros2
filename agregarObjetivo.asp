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



Set con = Server.createObject("ADODB.Connection")



con.ConnectionString= "Provider=SQLNCLI11;Server=DESKTOP-94UDDNK;Database=cuentaAhorros;uid=sa;pwd=4321;"

con.open    
DIM upd
SET upd = Server.CreateObject("ADODB.Command")
SET upd.ActiveConnection = con

'upd.CommandText = "agregarPersona"
'upd.CommandType = 4  'adCmdStoredProc

'upd.Parameters("@ident") = fechaIni
'upd.Parameters("@Nombre") = fechaFin
'upd.Parameters("@Fecha") = cuota
'upd.Parameters("@tel1") = objetivo
'upd.Parameters("@tel2") = saldo
'upd.Parameters("@Email") = interes

'upd.Execute()


'Response.Redirect("mensajePersona.asp")



%>