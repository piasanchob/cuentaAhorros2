 CREATE PROCEDURE AgregarCuentaObjetivo
	@InNumCuenta INT,
	@InFechaInicio DATE,
	@InFechaFinal DATE,
	@InCuota INT,
	@InObjetivo INT,
	@InSaldo INT,
	@InInteresAcumulado INT,
	@OutCodeResult INT
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE 
			@IdNumCuenta INT
		
		BEGIN TRANSACTION T1

			SET @IdNumCuenta = (SELECT Id FROM CuentaAhorros WHERE NumCuenta = @InNumCuenta);

			INSERT INTO dbo.CuentaObjetivo(IdCuentaAhorros,
			FechaInicio,
			FechaFinal,
			Cuota,
			Objetivo,
			Saldo,
			InteresAcumulado)
			

			VALUES(
			@IdNumCuenta,
			@InFechaInicio,
			@InFechaFinal,
			@InCuota,
			@InObjetivo,
			@InSaldo,
			@InInteresAcumulado)

		COMMIT TRANSACTION T1
	END TRY
	BEGIN CATCH
	IF @@TRANCOUNT>0
			ROLLBACK TRANSACTION T1;
			SET @OutCodeResult = 50005;
	END CATCH
	SET NOCOUNT OFF
END