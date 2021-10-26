DECLARE @datos XML
SELECT @datos = CAST(xmlfile AS xml)
FROM OPENROWSET(BULK 'C:\Users\gmora\OneDrive\Desktop\2 SEMESTRE 2021\Bases de Datos\Tarea Programada 2\cuentaAhorros2\DatosTarea2-7.xml', SINGLE_BLOB) AS T(xmlfile)

--insercion usuarios


	INSERT INTO dbo.Usuarios(ValorDocIdentidad, Username,Pass,EsAdmin)
	SELECT  
		ValorDocIdentidad =  T.Item.value('@ValorDocumentoIdentidad', 'varchar(64)'),
		Username =  T.Item.value('@Usuario', 'varchar(64)'),
		Pass =  T.Item.value('@Pass', 'varchar(64)'),
		EsAdmin =  T.Item.value('@EsAdministrador', 'bit')
		
		
	FROM @datos.nodes('Datos/Usuarios/Usuario') as T(Item)

	
	SELECT * FROM dbo.Usuarios

--insercion puede ver
	
	INSERT INTO dbo.UsuarioPuedeVer(NumCuenta,Username,IdUsuario)
	SELECT  

		NumCuenta =  T.Item.value('@NumeroCuenta', 'varchar(64)'),
		Username =  T.Item.value('@Usuario', 'varchar(64)'),
		IdUsuario =  (SELECT Id FROM Usuarios WHERE Username = T.Item.value('@Username', 'varchar(64)'))
		
	FROM @datos.nodes('Datos/Usuarios_Ver/UsuarioPuedeVer') as T(Item)

	
	SELECT * FROM dbo.UsuarioPuedeVer
	
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
	
	--insercion tipo mov 
	INSERT INTO dbo.TipoMov(Id,Operacion,Descripcion)
		
	SELECT  
		
		Id = T.Item.value('@Id', 'int'),
		
		Operacion = T.Item.value('@Operacion', 'varchar(64)'),
		Descripcion = T.Item.value('@Descripcion', 'varchar(64)')
		
		
	FROM @datos.nodes('//Datos/Tipo_Movimientos/TipoMovimiento') as T(Item)

	SELECT * FROM TipoMov

	
DECLARE @FechasProcesar TABLE (Fecha date)
INSERT @FechasProcesar(Fecha)
SELECT  
		Fecha = T.Item.value('@Fecha', 'date')
		
FROM @datos.nodes('//Datos/FechaOperacion') as T(Item)


DECLARE @fechaInicial DATE, @fechaFinal DATE
DECLARE @DiaCierreEC DATE
DECLARE @CuentasCierran TABLE( sec int identity(1,1), Id Int)

--SELECT @fechaInicial=MIN(Fecha), @fechaFinal=MAX(Fecha) FROM @FechasProcesar
SELECT @fechaInicial='2021-08-02', @fechaFinal= ' 2021-11-30' 
WHILE @fechaInicial<=@fechaFinal
BEGIN
	
	--insercion Personas
	INSERT INTO dbo.Personas(ValorDocIdentidad,Nombre,FechaNac,Tel1,Tel2,Email,IdTipoDoc)
	SELECT  
		ValorDocIdentidad = T.Item.value('@ValorDocumentoIdentidad', 'varchar(64)'),
		Nombre = T.Item.value('@Nombre', 'varchar(64)'),
		FechaNac = T.Item.value('@FechaNacimiento', 'date'),
		Tel1 = T.Item.value('@Telefono1', 'bigint'),
		Tel2 = T.Item.value('@Telefono2', 'bigint'),
		Email = T.Item.value('@Email', 'varchar(64)'),
		IdTipoDoc = T.Item.value('@TipoDocuIdentidad', 'int')

	FROM @datos.nodes('//Datos/FechaOperacion/AgregarPersona') as T(Item) 
	--WHERE T.item.value('../@Fecha', 'DATE') = @fechaInicial;
	
	SELECT * FROM dbo.Personas

	INSERT INTO dbo.TipoCambio(TCCompra,TCVenta,IdMoneda,IdOtra,Fecha)
	SELECT  
		TCCompra = T.Item.value('@Compra', 'int'),
		TCVenta = T.Item.value('@Venta', 'int'),
		IdMoneda = 2,
		IdOtra = 1,
		Fecha = T.item.value('../@Fecha', 'DATE')
		
	
	FROM @datos.nodes('//Datos/FechaOperacion/TipoCambioDolares') as T(Item)

	

	SELECT * FROM dbo.TipoCambio
	--insercion cuentas

	INSERT INTO dbo.CuentaAhorros(IdPersona,Saldo,IdTipoCuenta,NumCuenta,FechaCreacion,IdUsuario)
	
	SELECT  

		IdPersona = (SELECT Id FROM Personas WHERE ValorDocIdentidad = T.Item.value('@ValorDocumentoIdentidadDelCliente', 'varchar(64)')),
		Saldo = T.Item.value('@Saldo', 'int'),
		IdTipoCuenta = T.Item.value('@TipoCuentaId', 'int'),
		NumCuenta = T.Item.value('@NumeroCuenta', 'varchar(64)'),
		FechaCreacion = T.item.value('../@Fecha', 'DATE'),
		IdUsuario = (SELECT Id FROM Usuarios WHERE ValorDocIdentidad = T.Item.value('@ValorDocumentoIdentidadDelCliente', 'varchar(64)'))

	FROM @datos.nodes('//Datos/FechaOperacion/AgregarCuenta') as T(Item)
	--WHERE T.item.value('../@Fecha', 'DATE') = @fechaInicial;
	

	SELECT * FROM dbo.CuentaAhorros
	

	--insercion beneficiarios

	INSERT INTO dbo.Beneficiarios(IdPersona,IdParentesco,Porcentaje,IdNumCuenta)
	SELECT 
		
		IdPersona = (SELECT Id FROM Personas WHERE ValorDocIdentidad = T.Item.value('@ValorDocumentoIdentidadBeneficiario', 'varchar(64)')),
		IdParentesco = T.Item.value('@ParentezcoId', 'int'),
		Porcentaje = T.Item.value('@Porcentaje', 'int'),
		IdNumCuenta = (SELECT Id FROM CuentaAhorros WHERE NumCuenta = T.Item.value('@NumeroCuenta', 'varchar(64)'))
	
	FROM @datos.nodes('//Datos/FechaOperacion/AgregarBeneficiario') as T(Item)
	--WHERE T.item.value('../@Fecha', 'DATE') = @fechaInicial;
	
	

	SELECT * FROM dbo.Beneficiarios
	


	--insercion tipo cambio

	

	--insercion mov
	INSERT INTO dbo.Movimientos(IdTipoCambio,Descripcion,IdCuenta,IdTipoMov,Monto,IdMoneda,Fecha,MontoMonedaOriginal)
	SELECT  
		
		IdTipoCambio = (SELECT Id FROM TipoCambio WHERE Fecha = T.item.value('../@Fecha', 'DATE')),
		Descripcion = T.Item.value('@Descripcion', 'varchar(64)'),
		IdCuenta = (SELECT Id FROM CuentaAhorros WHERE NumCuenta = T.Item.value('@NumeroCuenta', 'int')),
		IdTipoMov = T.Item.value('@Tipo', 'int'),
		Monto = T.Item.value('@Monto', 'int'),
		IdMoneda = T.Item.value('@IdMoneda', 'int'),

		Fecha = T.item.value('../@Fecha', 'DATE'),
		MontoMonedaOriginal = T.Item.value('@Monto', 'int')
		
		
	FROM @datos.nodes('//Datos/FechaOperacion/Movimientos') as T(Item)
	

	SELECT * FROM dbo.Movimientos

SET @fechaInicial = (SELECT(DATEADD(DAY,1,@fechaInicial)))

END;

DELETE FROM dbo.TipoCambio WHERE Id >121
SELECT COUNT(*) FROM Movimientos