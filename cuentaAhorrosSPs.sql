USE cuentaAhorros

CREATE PROCEDURE validarIdenPersona
	@InIdent VARCHAR(64),
	@OutCodeResult INT

AS
	BEGIN
		SET NOCOUNT ON
		BEGIN TRY
			BEGIN TRANSACTION T1

				IF (EXISTS (SELECT 1 FROM dbo.Personas WHERE ValorDocIdentidad = @InIdent))
					RETURN  1;
				ELSE
					RETURN  0;
		
			COMMIT TRANSACTION T1
		END TRY

	BEGIN CATCH
	IF @@TRANCOUNT>0
			ROLLBACK TRANSACTION T1;
			SET @OutCodeResult = 50005;
	END CATCH
	SET NOCOUNT OFF
		
END;



CREATE PROCEDURE ValidarElim 
@InValorDocIdentidad VARCHAR(64), 
@InPorcentaje VARCHAR(64), 
@InNumCuenta VARCHAR(64),
@OutCodeResult INT
As
	BEGIN
		SET NOCOUNT ON
		BEGIN TRY
			BEGIN TRANSACTION T1
				IF (EXISTS (SELECT 1 FROM dbo.Personas WHERE ValorDocIdentidad = @InValorDocIdentidad) )
					IF (EXISTS (SELECT 1 FROM dbo.CuentaAhorros WHERE NumCuenta = @InNumCuenta) )
						IF (EXISTS (SELECT 1 FROM dbo.Beneficiarios WHERE Porcentaje = @InPorcentaje))
					
							RETURN 1;
				ELSE
					RETURN 0;


			COMMIT TRANSACTION T1;
		END TRY

	BEGIN CATCH
	IF @@TRANCOUNT>0
			ROLLBACK TRANSACTION T1;
			SET @OutCodeResult = 50005;
	END CATCH
	SET NOCOUNT OFF
			

END;



CREATE PROCEDURE agregarPersona
@InNombre VARCHAR(64), 
@InFecha DATE, 
@InIdent INT,
@InTel1 VARCHAR(64),
@InTel2 VARCHAR(64), 
@InEmail VARCHAR(64),
@OutCodeResult INT

AS
	
	BEGIN
		SET NOCOUNT ON
		BEGIN TRY
			BEGIN TRANSACTION T1


			INSERT INTO dbo.Personas(ValorDocIdentidad,Nombre,FechaNac,Tel1,Tel2,Email)
			VALUES (@InIdent,@InNombre,@InFecha,@InTel1,@InTel2,@InEmail);


			COMMIT TRANSACTION T1;
		END TRY

	BEGIN CATCH
	IF @@TRANCOUNT>0
			ROLLBACK TRANSACTION T1;
			SET @OutCodeResult = 50005;
	END CATCH
	SET NOCOUNT OFF

END;

GO