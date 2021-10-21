use cuentaAhorros;

DECLARE @datos XML
SELECT @datos = CAST(xmlfile AS xml)
FROM OPENROWSET(BULK 'C:\Users\user\Documents\TEC\BASES1 FRANCO\CA2\XMLFILEV2.xml', SINGLE_BLOB) AS T(xmlfile)
DECLARE @IdMonedaCuenta int,@IdMov int,@IdTipoCA int,@Operacion int,@TCcompra int,@TCVenta int
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

--WHILE @fechaInicial<=@fechaFinal
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

	INSERT INTO dbo.TipoCambio(TCCompra,TCVenta)
	SELECT  
		TCCompra = T.Item.value('@Compra', 'int'),
		TCVenta = T.Item.value('@Venta', 'int')
		
	
	FROM @datos.nodes('Datos/FechaOperacion/TipoCambioDolares') as T(Item)
	WHERE T.item.value('../@Fecha', 'DATE') = @fechaInicial;

	SELECT * FROM dbo.TipoCambio

	--insercion mov

	INSERT INTO dbo.Movimientos(Descripcion,IdCuenta,IdTipoMov,Monto,IdMoneda)
	SELECT  
		Descripcion = T.Item.value('@Descripcion', 'varchar(64)'),
		IdCuenta = (SELECT Id FROM CuentaAhorros WHERE NumCuenta = T.Item.value('@NumeroCuenta', 'int')),
		IdTipoMov = T.Item.value('@Tipo', 'int'),
		Monto = T.Item.value('@Monto', 'int'),
		IdMoneda = T.Item.value('@IdMoneda', 'int')

		
	FROM @datos.nodes('Datos/FechaOperacion/Movimientos') as T(Item)
	WHERE T.item.value('../@Fecha', 'DATE') = @fechaInicial;
END;

	SET @IdMov = (SELECT Id FROM Movimientos WHERE Descripcion = T.Item.value('@Descripcion', 'varchar(64)'))
	SET @IdTipoCA = (SELECT IdTipoCuenta FROM CuentaAhorros WHERE IdMovimiento = @IdMov)
	SET @IdMonedaCuenta = (SELECT IdTipoMoneda FROM TipoCuentaAhorros WHERE Id = @IdTipoCA)
	SET @Operacion = (SELECT Operacion FROM TipoMovimientos WHERE Id = T.Item.value('@Tipo', 'int'))
	


	IF @IdMonedaCuenta = T.Item.value('@IdMoneda', 'int')
		IF @Operacion = 1
			
			UPDATE Movimientos 
			SET NuevoSaldo = NuevoSaldo + T.Item.value('@Monto', 'int')
		
		IF @Operacion = 2
			
			UPDATE Movimientos 
			SET NuevoSaldo = NuevoSaldo - T.Item.value('@Monto', 'int')
			
	IF @IdMonedaCuenta != T.Item.value('@IdMoneda', 'int')
		IF @IdMonedaCuenta = 1
			--T.Item.value('@IdMoneda', 'int')
			
			UPDATE Movimientos 
			SET NuevoSaldo = NuevoSaldo + T.Item.value('@Monto', 'int')
		
		IF @Operacion = 2
			
			UPDATE Movimientos 
			SET NuevoSaldo = NuevoSaldo - T.Item.value('@Monto', 'int')
			


	
	
	
	--..... Procesar movimientos .. idem (incluye modificar saldos y valores en el estado de cuenta). 
		Para cada movimiento:
	
		Establecer el monto del movimiento dependiendo de la moneda del movimiento respecto de la moneda de la cuenta y aplicando el tipo de cambio mas reciente.
		inserta creditos o debitos
		actualiza saldo de la cuenta que corresponde
		actualizar valores en el estado de cuenta actual (ejemplo: contadores de operaciones en ventana o cajero humano o ATM)
		actualiza el saldo minimo del mes (atributo que esta en el estado de cuenta)
		actualiza contadores (la cantidad de operaciones de atm o operaciones en ventana), necesarias para procesoar comisiones por exceso de cantidad de operaciones en atm o ventana, al cerrar el EC.
		Calcular el nuevo saldo que queda despues de aplicar el movimiento y guardarlo en tabla de movimientos
	
	.... Procesar cierre de Estado de cuenta (aunque en la fecha de operacion talvez no se proceso nada previamente).
	
		 .... cargar en tabla variable las cuentas que fueron creada en dia que corresponde a datepart(@FechaInicio, d)
		 
		Set @DiaCierreEC=datepart(@Fechainicio, d)
		-- considerar hacer ajustes a DiaCierreEC considerando meses de 30 y 31 dias, o annos bisiestos
		insert @CuentasCierran(Id)
		Select C.Id from dbo.Cuentas C where datepart(C.FechaCreacion, d)=DiaCierreEC
		 
		Select @lo1=1, @hi1=max(sec) from @CuentasCierran
		 
		while @lo1<=@hi1
		begin
		
			Select @IdCuentaCierre=C.CodigoCuenta from @CuentasCierran where sec=@lo1
			
			-- procesar cierre de Estado de cuenta de @CuentaCierre
			--- Calcular intereses respecto del saldo minimo durante el mes, agregar credito por interes ganado y afectar saldo
			--- calcular multa por incumplimiento de saldo minimo y agregar movimiento debito y afecta saldo.
			--- cobro de comision por exceso de operaciones en ATM. Debito
			--- cobro de comision por exceso de operaciones en cajero humano. Debito
			--- cobro de cargos por servicio. Debito.
			-- cerrar el estado de cuenta (actualizar valores, como saldo final, y otros)
			-- abrir (insertar) estado de cuenta para nuevo mes (fecha inicio, fecha fin, saldoinicial - igual al saldo final de EC que se cierra, saldo minimo, etc) 
	
			Set @lo1=@lo1+1
		end

	Set @fechaFinal=dateadd(@fechaFinal, d, 1)
END;