<%
Dim nombre
Dim fecha
Dim cedula 
Dim tel1
Dim tel2
Dim email


nombre =Request.form("nom")
fecha =Request.form("fechaNa")
cedula =Request.form("ced")
tel1 = Request.form("tel1")
tel2 =Request.form("tel2")
email = Request.form("mail")



Set con = Server.createObject("ADODB.Connection")



con.ConnectionString= "Provider=SQLNCLI11;Server=DESKTOP-94UDDNK;Database=cuentaAhorros;uid=sa;pwd=4321;"

con.open    
DIM upd
SET upd = Server.CreateObject("ADODB.Command")
SET upd.ActiveConnection = con

upd.CommandText = "agregarPersona"
upd.CommandType = 4  'adCmdStoredProc

upd.Parameters("@ident") = cedula
upd.Parameters("@Nombre") = nombre
upd.Parameters("@Fecha") = fecha
upd.Parameters("@tel1") = tel1
upd.Parameters("@tel2") = tel2
upd.Parameters("@Email") = email

upd.Execute()

Response.Redirect("mensajePersona.asp")



%>
 