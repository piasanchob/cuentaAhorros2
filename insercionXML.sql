use cuentaAhorros
GO
CREATE PROCEDURE InsercionXML
AS
BEGIN
	--lectura del XML

	DECLARE @datos XML
	SELECT @datos = CAST(xmlfile AS xml)
	FROM OPENROWSET(BULK 'C:\Users\user\Documents\TEC\BASES1 FRANCO\cuentaahorros_bases1\XMLFile.xml', SINGLE_BLOB) AS T(xmlfile)


	--insercion tipo docs identidad

	INSERT INTO dbo.TipoDocsIdentidad(Id, Nombre)
	SELECT  
		Id = T.Item.value('@Id', 'int'),
		Nombre = T.Item.value('@Nombre', 'varchar(64)')
	FROM @datos.nodes('Datos/Tipo_Doc/TipoDocuIdentidad') as T(Item)

	
	SELECT * FROM dbo.TipoDocsIdentidad
	--insercion tipo monedas

	INSERT INTO dbo.TipoMonedas(Id, Nombre)
	SELECT  
		Id = T.Item.value('@Id', 'int'),
		Nombre = T.Item.value('@Nombre', 'varchar(64)')
	FROM @datos.nodes('Datos/Tipo_Moneda/TipoMoneda') as T(Item)

	SELECT * FROM dbo.TipoMonedas
	
	--insercion tipo parentescos

	INSERT INTO dbo.Parentescos(Id, Nombre)
	SELECT  
		Id = T.Item.value('@Id', 'int'),
		Nombre = T.Item.value('@Nombre', 'varchar(64)')
	FROM @datos.nodes('Datos/Parentezcos/Parentezco') as T(Item)

	
	SELECT * FROM dbo.Parentescos
	--insercion tipo cuentas de ahorro

	INSERT INTO dbo.TiposCuentaAhorros(Id, Nombre,IdTipoMoneda,SaldoMin,MultaSaldoMin,CargoAnual,NumRetirosHumano,NumRetirosAutomatico,ComisionHumano,ComisionCajero,TasaInteres)
	SELECT  
		Id = T.Item.value('@Id', 'int'),
		Nombre = T.Item.value('@Nombre', 'varchar(64)'),
		IdTipoMoneda = T.Item.value('@IdTipoMoneda', 'int'),
		SaldoMin = T.Item.value('@SaldoMinimo', 'float'),
		MultaSaldoMin = T.Item.value('@MultaSaldoMin', 'float'),
		CargoAnual = T.Item.value('@CargoAnual', 'int'),
		NumRetirosHumano = T.Item.value('@NumRetirosHumano', 'int'),
		NumRetirosAutomatico = T.Item.value('@NumRetirosAutomatico', 'int'),
		ComisionHumano = T.Item.value('@ComisionHumano', 'int'),
		ComisionCajero = T.Item.value('@ComisionAutomatico', 'int'),
		TasaInteres = T.Item.value('@Interes', 'int')


	FROM @datos.nodes('Datos/Tipo_Cuenta_Ahorros/TipoCuentaAhorro') as T(Item)

	
	SELECT * FROM dbo.TiposCuentaAhorros
	--insercion Personas

	INSERT INTO dbo.Personas(Cedula,Nombre,FechaNac,Tel1,Tel2,Email,IdTipoDoc)
	SELECT  
		Cedula = T.Item.value('@ValorDocumentoIdentidad', 'int'),
		Nombre = T.Item.value('@Nombre', 'varchar(64)'),
		FechaNac = T.Item.value('@FechaNacimiento', 'date'),
		Tel1 = T.Item.value('@Telefono1', 'bigint'),
		Tel2 = T.Item.value('@Telefono2', 'bigint'),
		Email = T.Item.value('@Email', 'varchar(64)'),
		IdTipoDoc = T.Item.value('@TipoDocuIdentidad', 'int')
	FROM @datos.nodes('Datos/Personas/Persona') as T(Item)

	
	SELECT * FROM dbo.Personas
	--insercion cuentas

	INSERT INTO dbo.CuentaAhorros(FechaCreacion,Saldo,IdTipoCuenta,Cedula,NumCuenta)
	SELECT  
		FechaCreacion = T.Item.value('@FechaCreacion', 'date'),
		Saldo = T.Item.value('@Saldo', 'float'),
		IdTipoCuenta = T.Item.value('@TipoCuentaId', 'int'),
		Cedula = T.Item.value('@ValorDocumentoIdentidadDelCliente', 'varchar(64)'),
		NumCuenta = T.Item.value('@NumeroCuenta', 'varchar(64)')
	
	FROM @datos.nodes('Datos/Cuentas/Cuenta') as T(Item)

	SELECT * FROM dbo.CuentaAhorros
	--insercion beneficiarios

	INSERT INTO dbo.Beneficiarios(IdParentesco,Porcentaje,NumCuenta,Cedula)
	SELECT  
		IdParentesco = T.Item.value('@ParentezcoId', 'int'),
		Porcentaje = T.Item.value('@Porcentaje', 'int'),
		NumCuenta = T.Item.value('@NumeroCuenta', 'varchar(64)'),
		Cedula = T.Item.value('@ValorDocumentoIdentidadBeneficiario', 'varchar(64)')
	
	
	FROM @datos.nodes('Datos/Beneficiarios/Beneficiario') as T(Item)

	
	SELECT * FROM dbo.Beneficiarios
	--insertar Usuarios

	INSERT INTO dbo.Usuarios(Username,Pass,EsAdmin,Cedula)
	SELECT  
		Username = T.Item.value('@User', 'varchar(64)'),
		Pass = T.Item.value('@Pass', 'varchar(64)'),
		EsAdmin = T.Item.value('@EsAdministrador', 'bit'),
		Cedula = T.Item.value('@ValorDocumentoIdentidad', 'varchar(64)')
	
	
	FROM @datos.nodes('Datos/Usuarios/Usuario') as T(Item)

	
	SELECT * FROM dbo.Usuarios
	-- insercion usuarios puede ver

	INSERT INTO dbo.UsuarioPuedeVer(Username,NumCuenta)
	SELECT  
		Username = T.Item.value('@User', 'varchar(64)'),
		NumCuenta = T.Item.value('@NumeroCuenta', 'varchar(64)')
	
	FROM @datos.nodes('Datos/Usuarios_Ver/UsuarioPuedeVer') as T(Item)

	
	SELECT * FROM dbo.UsuarioPuedeVer

END;

EXEC InsercionXML;


