Create PROCEDURE MovimientosCuentaAhorros
@OutCodeResult INT

AS
	BEGIN
		SET NOCOUNT ON
		BEGIN TRY

		DECLARE @IdCuentaAhorro INT, 
		@IdMov INT,@IdMonMov INT, @IdMonedaCuenta INT, @IdTipoCuenta INT, 
		@Venta INT, @Compra Int, @cont INT =1, @Operacion INT, @Monto INT , 
		@nuevoSaldo INT,@IdTipoCambio INT, @IdTipoMov INT


WHILE @cont<=3563


--Encontrar id de la moneda de la cuenta 

	SET @IdMov = (@cont)

	SET @IdCuentaAhorro = (SELECT IdCuenta FROM Movimientos WHERE Id=@IdMov)

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




	IF @IdMonedaCuenta = @IdMonMov

					
		IF @Operacion = 1
			
			UPDATE Movimientos 
			SET NuevoSaldo = NuevoSaldo +@Monto
			WHERE Id=@IdMov;

		--referencia2
		IF @Operacion = 2
			
			UPDATE Movimientos 
			SET NuevoSaldo = NuevoSaldo - @Monto
			WHERE Id=@IdMov;
			
	IF (@IdMonedaCuenta = 1 AND @IdMonMov=2)
		IF @Operacion = 1
			
			UPDATE Movimientos 
			SET NuevoSaldo = NuevoSaldo + (@Monto*@Compra)
			WHERE Id=@IdMov;
		
		IF @Operacion = 2
			
			UPDATE Movimientos 
			SET NuevoSaldo = NuevoSaldo - (@Monto*@Compra)
			WHERE Id=@IdMov;

	IF (@IdMonedaCuenta = 2 AND @IdMonMov=1)
		IF @Operacion = 1
			
			UPDATE Movimientos 
			SET NuevoSaldo = NuevoSaldo +( @Monto/@Venta)
			WHERE Id=@IdMov;
		
		IF @Operacion = 2
			
			UPDATE Movimientos 
			SET NuevoSaldo = NuevoSaldo -  (@Monto/@Venta)
			WHERE Id=@IdMov;

	


	SET @nuevoSaldo =(SELECT NuevoSaldo FROM Movimientos WHERE Id=@IdMov)



	UPDATE CuentaAhorros
	SET Saldo = @nuevoSaldo
	WHERE Id=@IdCuentaAhorro;

SET @cont= @cont+1;


		COMMIT TRANSACTION T1
	END TRY
	BEGIN CATCH
	IF @@TRANCOUNT>0
			ROLLBACK TRANSACTION T1;
			SET @OutCodeResult = 50005;
	END CATCH
	SET NOCOUNT OFF

END