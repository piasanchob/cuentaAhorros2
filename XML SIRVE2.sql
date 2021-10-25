use cuentaAhorros;

DECLARE @datos XML
SELECT @datos = CAST(xmlfile AS xml)
FROM OPENROWSET(BULK 'C:\Users\gmora\OneDrive\Desktop\Prueba.xml', SINGLE_BLOB) AS T(xmlfile)
DECLARE @IdMonedaCuenta int,@IdMov int,@IdTipoCA int,@Operacion int,@TCcompra int,@TCVenta int, @IdMon INT;

DECLARE @idTipoCambio INT, @venta INT, @compra INT, @idMapeo INT, @var INT, @Monto INT, @IdCuenta INT,
@nuevoSaldo INT, @IdMov2 INT;
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
	

	
DECLARE @FechasProcesar TABLE (Fecha date)
INSERT @FechasProcesar(Fecha)
SELECT  
		Fecha = T.Item.value('@Fecha', 'date')
		
FROM @datos.nodes('Datos/FechaOperacion') as T(Item)


DECLARE @fechaInicial DATE, @fechaFinal DATE
DECLARE @DiaCierreEC DATE
DECLARE @CuentasCierran TABLE( sec int identity(1,1), Id Int)

SELECT @fechaInicial=MIN(Fecha), @fechaFinal=MAX(Fecha) FROM @FechasProcesar

--SET @fechaFinal  = '12-31-2020'
--SET @fechaInicial  = '08-01-2020';
WHILE @fechaInicial<=@fechaFinal
BEGIN
	
	--insercion Personas

	INSERT INTO dbo.Personas(ValorDocIdentidad,Nombre,FechaNac,Tel1,Tel2,Email,IdTipoDoc)
	SELECT  
		ValorDocIdentidad = T.Item.value('@ValorDocumentoIdentidad', 'int'),
		Nombre = T.Item.value('@Nombre', 'varchar(64)'),
		FechaNac = T.Item.value('@FechaNacimiento', 'date'),
		Tel1 = T.Item.value('@Telefono1', 'bigint'),
		Tel2 = T.Item.value('@Telefono2', 'bigint'),
		Email = T.Item.value('@Email', 'varchar(64)'),
		IdTipoDoc = T.Item.value('@TipoDocuIdentidad', 'int')

	FROM @datos.nodes('Datos/FechaOperacion/AgregarPersona') as T(Item)
	WHERE T.item.value('../@Fecha', 'DATE') = @fechaInicial;

	SELECT * FROM dbo.Personas

	--insercion cuentas

	INSERT INTO dbo.CuentaAhorros(IdPersona,Saldo,IdTipoCuenta,NumCuenta)
	SELECT  

		IdPersona = (SELECT Id FROM Personas WHERE ValorDocIdentidad = T.Item.value('@ValorDocumentoIdentidadDelCliente', 'varchar(64)')),
		Saldo = T.Item.value('@Saldo', 'float'),
		IdTipoCuenta = T.Item.value('@TipoCuentaId', 'int'),
		NumCuenta = T.Item.value('@NumeroCuenta', 'varchar(64)')
		
	FROM @datos.nodes('Datos/FechaOperacion/AgregarCuenta') as T(Item)
	WHERE T.item.value('../@Fecha', 'DATE') = @fechaInicial;

	SELECT * FROM dbo.CuentaAhorros

	--insercion beneficiarios

	INSERT INTO dbo.Beneficiarios(IdPersona,IdParentesco,Porcentaje,IdNumCuenta)
	SELECT 
		
		IdPersona = (SELECT Id FROM Personas WHERE ValorDocIdentidad = T.Item.value('@ValorDocumentoIdentidadBeneficiario', 'varchar(64)')),
		IdParentesco = T.Item.value('@ParentezcoId', 'int'),
		Porcentaje = T.Item.value('@Porcentaje', 'int'),
		IdNumCuenta = (SELECT Id FROM CuentaAhorros WHERE NumCuenta = T.Item.value('@NumeroCuenta', 'varchar(64)'))
	
	FROM @datos.nodes('Datos/FechaOperacion/AgregarBeneficiario') as T(Item)
	WHERE T.item.value('../@Fecha', 'DATE') = @fechaInicial;

	SELECT * FROM dbo.Beneficiarios
	


	--insercion tipo cambio


	INSERT INTO dbo.Movimientos(Descripcion,IdCuenta,IdTipoMov,Monto,IdMoneda)
	SELECT  
		Descripcion = T.Item.value('@Descripcion', 'varchar(64)'),
		IdCuenta = (SELECT Id FROM CuentaAhorros WHERE NumCuenta = T.Item.value('@NumeroCuenta', 'int')),
		IdTipoMov = T.Item.value('@Tipo', 'int'),
		Monto = T.Item.value('@Monto', 'int'),
		IdMoneda = T.Item.value('@IdMoneda', 'int')

		
	FROM @datos.nodes('Datos/FechaOperacion/Movimientos') as T(Item)
	WHERE T.item.value('../@Fecha', 'DATE') = @fechaInicial;

	SELECT * FROM dbo.Movimientos;


	INSERT INTO dbo.TipoCambio(TCCompra,TCVenta)
	SELECT  
		TCCompra = T.Item.value('@Compra', 'int'),
		TCVenta = T.Item.value('@Venta', 'int')
		
	
	FROM @datos.nodes('Datos/FechaOperacion/TipoCambioDolares') as T(Item)
	WHERE T.item.value('../@Fecha', 'DATE') = @fechaInicial;

	SELECT * FROM dbo.TipoCambio

	--insercion mov

	INSERT INTO dbo.TipoMov(Id,Operacion,Descripcion)
	SELECT  
		
		Id = T.Item.value('@Id', 'int'),
		
		Operacion = T.Item.value('@Operacion', 'varchar(64)'),
		Descripcion = T.Item.value('@Descripcion', 'varchar(64)')
		
		
	FROM @datos.nodes('//Datos/FechaOperacion/TipoMovimientos') as T(Item)

	SELECT * FROM TipoMov


	


	SET @fechaInicial = (SELECT(DATEADD(DAY,1,@fechaInicial)))


END;
	SET @IdMov = (SELECT Id FROM CuentaAhorros WHERE NumCuenta=  T.Item.value('@NumeroCuenta', 'int'))
	SET @IdCuenta= (SELECT IdCuenta From Movimientos WHERE   Id=@IdMov)


	SET @IdTipoCA = (SELECT IdTipoCuenta FROM CuentaAhorros WHERE Id = @IdCuenta)

	SET @IdMonedaCuenta = (SELECT IdTipoMoneda FROM TiposCuentaAhorros WHERE Id = @IdTipoCA)

	SET @Operacion = (SELECT Operacion FROM TipoMov)

	
	SET @idTipoCambio= (SELECT idTipoCambio from Movimientos)


	SET @Monto = (SELECT Monto FROM Movimientos)
	SET @IdMon = (SELECT idMoneda FROM Movimientos)
	SET @var= (SELECT Id from Movimientos WHERE @idTipoCambio = idTipoCambio)

	IF @IdMonedaCuenta = @IdMon

					
		IF @Operacion = 1
			
			UPDATE Movimientos 
			SET NuevoSaldo = NuevoSaldo +@Monto
			WHERE @var=Id;

		--referencia2
		IF @Operacion = 2
			
			UPDATE Movimientos 
			SET NuevoSaldo = NuevoSaldo - @Monto
			WHERE @var=Id;
			
	IF (@IdMonedaCuenta = 1 AND @IdMon=2)
		IF @Operacion = 1
			
			Set @idTipoCambio = (SELECT idTipoCambio FROM Movimientos WHERE @IdMov=id)
			Set @compra = (SELECT TCVenta FROM TipoCambio WHERE @idTipoCambio=id)
			UPDATE Movimientos 
			SET NuevoSaldo = NuevoSaldo + (@Monto/@compra)
			WHERE @var=Id;
		
		IF @Operacion = 2
			
			Set @idTipoCambio = (SELECT idTipoCambio FROM Movimientos WHERE @IdMov=id)
			Set @compra = (SELECT TCVenta FROM TipoCambio WHERE @idTipoCambio=id)
			UPDATE Movimientos 
			SET NuevoSaldo = NuevoSaldo - (@Monto/@compra)
			WHERE @var=Id;

	IF (@IdMonedaCuenta = 2 AND @IdMon=1)
		IF @Operacion = 1
			
			Set @idTipoCambio = (SELECT idTipoCambio FROM Movimientos WHERE @IdMov=id)
			Set @venta = (SELECT TCVenta FROM TipoCambio WHERE @idTipoCambio=id)
			UPDATE Movimientos 
			SET NuevoSaldo = NuevoSaldo +( @Monto*@venta)
			WHERE @var=Id;
		
		IF @Operacion = 2
			
			Set @idTipoCambio = (SELECT idTipoCambio FROM Movimientos WHERE @IdMov=id)
			Set @venta = (SELECT TCVenta FROM TipoCambio WHERE @idTipoCambio=id)
			UPDATE Movimientos 
			SET NuevoSaldo = NuevoSaldo -  (@Monto*@venta)
			WHERE @var=Id;

	
	SET @IdMov2= (SELECT IdCuenta FROM Movimientos WHERE IdTipoCambio=@idTipoCambio);
	SET @var = (SELECT Id FROM CuentaAhorros WHERE Id=@IdMov2 );

	SET @nuevoSaldo = (SELECT NuevoSaldo FROM Movimientos WHERE Id=@IdMov2);

	UPDATE CuentaAhorros
	SET Saldo = @nuevoSaldo
	WHERE @var=Id;


	

END;