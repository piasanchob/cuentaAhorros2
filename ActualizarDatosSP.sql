CREATE PROCEDURE ActualizarDatos @InPorcentaje INT, @InParentesco VARCHAR(64),
@InNombre VARCHAR(64), 
@InCedula VARCHAR(64), 
@InCedulaB VARCHAR(64),
@OutCodeResult INT

AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @P INT
		DECLARE @Var INT

		IF (@InParentesco='Padre')
			SET @P=1;
		IF (@InParentesco='Madre')
			SET @P=2;
		IF (@InParentesco='Hijo')
			SET @P=3;
		IF (@InParentesco='Hija')
			SET @P=4;
		IF (@InParentesco='Hermano')
			SET @P=5;
		IF (@InParentesco='Hermana')
			SET @P=6;
		IF (@InParentesco='Amigo')
			SET @P=7;
		IF (@InParentesco='Amiga')
			SET @P=8;
		SET @Var = (SELECT Id FROM Personas WHERE ValorDocIdentidad=@InCedula)

		UPDATE dbo.Beneficiarios
		SET IdParentesco=@P,Porcentaje=@InPorcentaje WHERE IdPersona = @Var;

		UPDATE dbo.Personas
		SET Nombre=@InNombre WHERE ValorDocIdentidad = @InCedulaB;
		
		COMMIT TRANSACTION T1
	END TRY
	BEGIN CATCH
	if @@TRANCOUNT>0
			ROLLBACK TRANSACTION T1;
			SET @OutCodeResult = 50005;
	END CATCH
	SET NOCOUNT OFF
END;

CREATE PROCEDURE agregarBeneficiario 
@InParentezco VARCHAR(64),
@InPorcentaje INT, 
@InIdent VARCHAR(64),
@InCuenta VARCHAR(64),
@OutCodeResult INT

AS
	BEGIN
		SET NOCOUNT ON
		BEGIN TRY

		DECLARE @P INT;
		DECLARE @Var INT;
		Declare @IdNumCuenta INT ;

		IF (@InParentezco='Padre')
			SET @P=1;
		IF (@InParentezco='Madre')
			SET @P=2;
		IF (@InParentezco='Hijo')
			SET @P=3;
		IF (@InParentezco='Hija')
			SET @P=4;
		IF (@InParentezco='Hermano')
			SET @P=5;
		IF (@InParentezco='Hermana')
			SET @P=6;
		IF (@InParentezco='Amigo')
			SET @P=7;
		IF (@InParentezco='Amiga')
			SET @P=8;

		SET @Var = (SELECT Id FROM Personas WHERE ValorDocIdentidad=@InIdent)


		SET @IdNumCuenta = (SELECT IdNumCuenta FROM Beneficiarios WHERE id=@Var)

		INSERT INTO dbo.Beneficiarios (IdParentesco,Porcentaje,IdPersona,IdNumCuenta)
		VALUES (@P,@InPorcentaje,@Var,@IdNumCuenta);


		COMMIT TRANSACTION T1
	END TRY
	BEGIN CATCH
	if @@TRANCOUNT>0
			ROLLBACK TRANSACTION T1;
			SET @OutCodeResult = 50005;
	END CATCH
	SET NOCOUNT OFF

END