 CREATE PROCEDURE EditarCuentaObjetivo
	@InNumCuenta INT,
	@InFechaInicio DATE,
	@InFechaFinal DATE,
	@InCuota INT,
	@InObjetivo INT,
	@InDescripcion VARCHAR(64),
	@OutCodeResult INT
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE 
			@IdCuentaAhorros INT
		
		BEGIN TRANSACTION T1

			SET @IdCuentaAhorros = (SELECT Id FROM CuentaAhorros WHERE NumCuenta = @InNumCuenta);



			UPDATE CuentaObjetivo 

			SET FechaInicio=@InFechaInicio,
			 FechaFinal=@InFechaFinal,
			 Cuota=@InCuota ,
			 Objetivo =@InObjetivo ,
			 Descripcion= @InDescripcion
			

			WHERE @IdCuentaAhorros=Id;

		COMMIT TRANSACTION T1
	END TRY
	BEGIN CATCH
	IF @@TRANCOUNT>0
			ROLLBACK TRANSACTION T1;
			SET @OutCodeResult = 50005;
	END CATCH
	SET NOCOUNT OFF
END
DROP PROCEDURE EditarCuentaObjetivo


 CREATE PROCEDURE AgregarCuentaObjetivo
	@InNumCuenta INT,
	@InFechaInicio DATE,
	@InFechaFinal DATE,
	@InCuota INT,
	@InObjetivo INT,
	@InSaldo INT,
	@InInteresAcumulado INT,
	@InDescripcion VARCHAR(64),
	@InActivo BIT,
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
			InteresAcumulado,
			Descripcion,
			Activo)
			

			VALUES(
			@IdNumCuenta,
			@InFechaInicio,
			@InFechaFinal,
			@InCuota,
			@InObjetivo,
			@InSaldo,
			@InInteresAcumulado,
			@InDescripcion,
			@InActivo )

		COMMIT TRANSACTION T1
	END TRY
	BEGIN CATCH
	IF @@TRANCOUNT>0
			ROLLBACK TRANSACTION T1;
			SET @OutCodeResult = 50005;
	END CATCH
	SET NOCOUNT OFF
END



CREATE PROCEDURE EliminarCuentaObjetivo
	@InNumCuenta INT,
	@OutCodeResult INT
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE 
			@IdCuentaAhorros INT
		
		BEGIN TRANSACTION T1

			SET @IdCuentaAhorros = (SELECT Id FROM CuentaAhorros WHERE NumCuenta = @InNumCuenta);

			UPDATE CuentaObjetivo 
			SET Activo=0

			WHERE @IdCuentaAhorros=Id;

		COMMIT TRANSACTION T1
	END TRY
	BEGIN CATCH
	IF @@TRANCOUNT>0
			ROLLBACK TRANSACTION T1;
			SET @OutCodeResult = 50005;
	END CATCH
	SET NOCOUNT OFF
END
DROP PROCEDURE EliminarCuentaObjetivo