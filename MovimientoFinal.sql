
		DECLARE @IdCuentaAhorro INT, 
		@IdMov INT,@IdMonMov INT, @IdMonedaCuenta INT, @IdTipoCuenta INT, 
		@Venta INT, @Compra Int, @cont INT =1, @Operacion INT, @Monto INT , 
		@nuevoSaldo INT,@IdTipoCambio INT, @IdTipoMov INT, @Val INT, 
		@IdNumCuenta INT, @MontoMonedaCuenta INT;



WHILE @cont<3564
BEGIN


--Encontrar id de la moneda de la cuenta 

	SET @IdMov = (@cont)

	SET @IdCuentaAhorro =  (SELECT IdCuenta FROM Movimientos WHERE Id=@IdMov)

	SET @IdTipoCuenta = (SELECT IdTipoCuenta FROM CuentaAhorros WHERE Id=@IdCuentaAhorro)

	SET @IdMonedaCuenta = (SELECT IdTipoMoneda FROM TiposCuentaAhorros WHERE Id=@IdTipoCuenta)

-- Encontrar Moneda del Movimiento

	SET @IdMonMov = (SELECT IdMoneda FROM Movimientos WHERE Id =@IdMov )

-- Encontrar Tipo de Cambio

	SET @IdTipoCambio= (SELECT IdTipoCambio FROM Movimientos WHERE Id = @IdMov)

	SET @Venta = (SELECT TCVenta FROM TipoCambio WHERE Id= @IdTipoCambio)

	SET @Compra = (SELECT TCCompra FROM TipoCambio WHERE Id= @IdTipoCambio)

	SET @IdTipoMov= (SELECT IdTipoMov FROM Movimientos WHERE Id= @IdMov)

-- ENCONTRAR OPERACION


	SELECT @Operacion = (SELECT Operacion FROM TipoMov WHERE Id = @IdTipoMov)


-- Encontrar Monto

	SET @Monto = (SELECT Monto FROM Movimientos WHERE Id=@IdMov)

	IF (@IdMonedaCuenta= 1 AND @IdMonMov=1)			
		IF @Operacion = 1

			SET @MontoMonedaCuenta=@Monto 

			
			
		ELSE
			
			SET @MontoMonedaCuenta=-@Monto 
			
	ELSE IF (@IdMonedaCuenta = 1 AND @IdMonMov=2)
		
		IF @Operacion = 1
		
			SET @MontoMonedaCuenta = (@Compra * @Monto) 
			
		ELSE
			
			
			SET @MontoMonedaCuenta = (@Compra * -@Monto) 
			

	ELSE IF (@IdMonedaCuenta = 2 AND @IdMonMov=1)
		
		IF @Operacion = 1
			
			
			SET @MontoMonedaCuenta = (@Monto /@Venta) 
		
		
		ELSE
			
			SET @MontoMonedaCuenta = (@Monto / -@Venta)
			
	ELSE IF (@IdMonedaCuenta= 2 AND @IdMonMov	=2 )
		IF @Operacion = 1

			SET @MontoMonedaCuenta=@Monto 

			
		ELSE
			
			SET @MontoMonedaCuenta= -@Monto 
		

			
	
	--print(@MontoMonedaCuenta)


	UPDATE Movimientos
	SET MontoMonedaCuenta = @MontoMonedaCuenta
	WHERE Id=@IdMov;


	SET @cont= @cont+1;
	

END

