use cuentaAhorros

CREATE PROCEDURE MostrarEstadosCuenta
	@InNumCuenta int,
	@OutCodeResult int
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE 
			@IdNumCuenta int
		
		BEGIN TRANSACTION T1

			SET @IdNumCuenta = SELECT Id FROM CuentaAhorros WHERE NumCuenta = @InNumCuenta;

			SELECT * FROM EstadoCuenta WHERE IdCuentaAhorros = @IdNumCuenta;
		
		COMMIT TRANSACTION T1
	END TRY
	BEGIN CATCH
	if @@TRANCOUNT>0
			ROLLBACK TRANSACTION T1;
			SET @OutCodeResult = 50005;
	END CATCH
	SET NOCOUNT OFF
END
