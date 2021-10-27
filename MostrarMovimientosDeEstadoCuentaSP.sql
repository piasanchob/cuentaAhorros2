CREATE PROCEDURE MostrarMovimientosDeEstadoCuenta
	@InNumCuenta INT,
	@OutCodeResult INT
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE 
			@IdNumCuenta INT
		
		BEGIN TRANSACTION T1

			SET @IdNumCuenta = (SELECT Id FROM CuentaAhorros WHERE NumCuenta = @InNumCuenta)
			SELECT * FROM Movimientos WHERE IdCuenta=@IdNumCuenta
		
		COMMIT TRANSACTION T1
	END TRY
	BEGIN CATCH
	if @@TRANCOUNT>0
			ROLLBACK TRANSACTION T1;
			SET @OutCodeResult = 50005;
	END CATCH
	SET NOCOUNT OFF
END
SELECT * FROM Movimientos