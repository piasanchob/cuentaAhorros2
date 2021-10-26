use cuentaAhorros;

DECLARE @datos XML
SELECT @datos = CAST(xmlfile AS xml)
<<<<<<< HEAD
FROM OPENROWSET(BULK 'C:\Users\user\Documents\TEC\BASES1 FRANCO\CA2\XMLFILEV7.xml', SINGLE_BLOB) AS T(xmlfile)
DECLARE @IdMonedaCuenta int,
@IdMov int,
@IdTipoCA int,
@Operacion int,
@TCcompra int,
@TCVenta int,
@IdPersona int
=======
FROM OPENROWSET(BULK 'C:\Users\gmora\OneDrive\Desktop\2 SEMESTRE 2021\Bases de Datos\Tarea Programada 2\cuentaAhorros2\DatosTarea2-6.xml', SINGLE_BLOB) AS T(xmlfile)
DECLARE @IdMonedaCuenta int,@IdMov int,@IdTipoCA int,@Operacion int,@TCcompra int,@TCVenta int, @IdMon INT;

<<<<<<< HEAD
DECLARE @idTipoCambio INT, @venta INT, @compra INT, @idMapeo INT, @var INT, @Monto INT, @IdCuenta INT,
@nuevoSaldo INT, @IdMov2 INT;
>>>>>>> master
=======
DECLARE @idTipoCambio INT, @venta INT, @compra INT, @idMapeo INT, @var INT, @Monto INT, @IdCuenta INT,
@nuevoSaldo INT, @IdMov2 INT, @cont INT;
>>>>>>> master


SET @cont=1;
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
		
FROM @datos.nodes('Datos/FechaOperacion') as T(Item)


DECLARE @fechaInicial DATE, @fechaFinal DATE
DECLARE @DiaCierreEC DATE
DECLARE @CuentasCierran TABLE( sec int identity(1,1), Id Int)

SELECT @fechaInicial=MIN(Fecha), @fechaFinal=MAX(Fecha) FROM @FechasProcesar

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

	FROM @datos.nodes('//Datos/FechaOperacion/AgregarPersona') as T(Item)
	
	SELECT * FROM dbo.Personas
	
	--insercion cuentas

	INSERT INTO dbo.CuentaAhorros(IdPersona,Saldo,IdTipoCuenta,NumCuenta,FechaCreacion,IdUsuario)
	
	SELECT  

		IdPersona = (SELECT Id FROM Personas WHERE ValorDocIdentidad = T.Item.value('@ValorDocumentoIdentidadDelCliente', 'varchar(64)')),
		Saldo = T.Item.value('@Saldo', 'float'),
		IdTipoCuenta = T.Item.value('@TipoCuentaId', 'int'),
		NumCuenta = T.Item.value('@NumeroCuenta', 'varchar(64)'),
		FechaCreacion = T.item.value('../@Fecha', 'DATE'),
		IdUsuario = (SELECT Id FROM Usuarios WHERE ValorDocIdentidad = T.Item.value('@ValorDocumentoIdentidadDelCliente', 'varchar(64)'))
	FROM @datos.nodes('//Datos/FechaOperacion/AgregarCuenta') as T(Item)

	SELECT * FROM dbo.CuentaAhorros
	

	--insercion beneficiarios

	INSERT INTO dbo.Beneficiarios(IdPersona,IdParentesco,Porcentaje,IdNumCuenta)
	SELECT 
		
		IdPersona = (SELECT Id FROM Personas WHERE ValorDocIdentidad = T.Item.value('@ValorDocumentoIdentidadBeneficiario', 'varchar(64)')),
		IdParentesco = T.Item.value('@ParentezcoId', 'int'),
		Porcentaje = T.Item.value('@Porcentaje', 'int'),
		IdNumCuenta = (SELECT Id FROM CuentaAhorros WHERE NumCuenta = T.Item.value('@NumeroCuenta', 'varchar(64)'))
	
	FROM @datos.nodes('//Datos/FechaOperacion/AgregarBeneficiario') as T(Item)
	

	SELECT * FROM dbo.Beneficiarios
	


	--insercion tipo cambio

	INSERT INTO dbo.TipoCambio(TCCompra,TCVenta,IdMoneda,IdOtra,Fecha)
	SELECT  
		TCCompra = T.Item.value('@Compra', 'int'),
		TCVenta = T.Item.value('@Venta', 'int'),
		IdMoneda = 2,
		IdOtra = 1,
		Fecha = T.item.value('../@Fecha', 'DATE')
		
	
	FROM @datos.nodes('Datos/FechaOperacion/TipoCambioDolares') as T(Item)
	WHERE T.item.value('../@Fecha', 'DATE') = @fechaInicial;

	SELECT * FROM dbo.TipoCambio

	--insercion mov
	INSERT INTO dbo.Movimientos(IdTipoCambio,Descripcion,IdCuenta,IdTipoMov,Monto,IdMoneda,Fecha,MontoMonedaOriginal)
		

	SELECT  
		
		IdTipoCambio = (SELECT Id FROM TipoCambio WHERE IdMoneda = T.Item.value('@IdMoneda', 'int')),
		Descripcion = T.Item.value('@Descripcion', 'varchar(64)'),
		IdCuenta = (SELECT Id FROM CuentaAhorros WHERE NumCuenta = T.Item.value('@NumeroCuenta', 'int')),
		IdTipoMov = T.Item.value('@Tipo', 'int'),
		Monto = T.Item.value('@Monto', 'int'),
		IdMoneda = T.Item.value('@IdMoneda', 'int'),
		Fecha = T.item.value('../@Fecha', 'DATE'),
		MontoMonedaOriginal = T.Item.value('@Monto', 'int')
		
		
	FROM @datos.nodes('//Datos/FechaOperacion/Movimientos') as T(Item)

	SELECT * FROM dbo.Movimientos

<<<<<<< HEAD
SET @fechaInicial = (SELECT(DATEADD(DAY,1,@fechaInicial)))
END;
<<<<<<< HEAD
	
	
	SELECT IdCuenta FROM CuentaAhorros WHERE IdCuenta = 
	@IdCuenta =
	SET @IdCA = (SELECT Id FROM CuentaAhorros WHERE Id = IdCuenta)
	SELECT * FROM 
	SET @IdTipoCA = (SELECT IdTipoCuenta FROM CuentaAhorros WHERE IdMovimiento = @IdMov)
	SET @IdMonedaCuenta = (SELECT IdTipoMoneda FROM TipoCuentaAhorros WHERE Id = @IdTipoCA)
	SET @IdTipoMov = SELECT Id FROM
	SET @Operacion = (SELECT Operacion FROM TipoMovimientos)
=======

--referencia
	SET @IdMov = (SELECT Id FROM CuentaAhorros WHERE NumCuenta=  T.Item.value('@NumeroCuenta', 'int'))
=======


--referencia
	

WHILE @cont<= 24
	SET @IdMov = (SELECT Id FROM CuentaAhorros WHERE NumCuenta=  @cont)
>>>>>>> master
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

>>>>>>> master
	
	SET @IdMov2= (SELECT IdCuenta FROM Movimientos WHERE IdTipoCambio=@idTipoCambio);
	SET @var = (SELECT Id FROM CuentaAhorros WHERE Id=@IdMov2 );

	SET @nuevoSaldo = (SELECT NuevoSaldo FROM Movimientos WHERE Id=@IdMov2);

	UPDATE CuentaAhorros
	SET Saldo = @nuevoSaldo
	WHERE @var=Id;


<<<<<<< HEAD
<<<<<<< HEAD
	IF @IdMonedaCuenta = 'moneda mov '
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
			
=======
>>>>>>> master
=======
SET @cont=@cont+1;
			

>>>>>>> master

SET @fechaInicial = (SELECT(DATEADD(DAY,1,@fechaInicial)))
END;

	SELECT IdTipoCuenta FROM CuentaAhorros WHERE Id = 'variable de todas las ids'
	SELECT Id FROM TipoCuentaAhorros WHERE Id = 'var d arribba'
	SET @SaldoCuenta = (SELECT Saldo FROM CuentaAhorros WHERE 'variable interfaz' = NumCuenta)
	SET @IdCuentaAhorros = (SELECT Id FROM CuentaAhorros WHERE 'variable interfaz' = NumCuenta)
	SET @IdTipoCA = (SELECT IdTipoCuenta FROM CuentaAhorros WHERE 'variable interfaz' = NumCuenta)
	SET @NumRetirosHum = (SELECT NumRetirosHumano FROM TipoCuentaAhorros WHERE Id = @IdTipoCA)
	SET @NumRetirosAuto = (SELECT NumRetirosAutomatico FROM TipoCuentaAhorros WHERE Id = @IdTipoCA)
	UPDATE EstadoCuenta
	SET SaldoInicial = @SaldoCuenta
	WHERE IdCuentaAhorros =@IdCuentaAhorros
	UPDATE EstadoCuenta
	SET NumRetirosHumano = @NumRetirosHum
	WHERE IdCuentaAhorros = @IdCuentaAhorros
	UPDATE EstadoCuenta
	SET NumRetirosAutomatico = @NumRetirosAuto
	WHERE IdCuentaAhorros = @IdCuentaAhorros
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