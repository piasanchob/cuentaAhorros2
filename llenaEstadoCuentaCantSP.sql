
CREATE PROCEDURE llenaEstadoCuentaCant
AS
Declare @IdMov INT = 1, @IdTipoMov INT, @CantRetiroHumano INT, @CantRetiroAtm INT,
@IdCuenta INT, @IdEstadoCuenta INT, @FechaInicial DATE, @FechaFinal DATE

WHILE @IdMov<3564
BEGIN 
	SET @IdTipoMov =(SELECT IdTipoMov FROM Movimientos WHERE Id=@IdMov)
	SET @FechaInicial = (SELECT Fecha FROM Movimientos WHERE Id=@IdMov)
	SET @IdCuenta = (SELECT IdCuenta FROM Movimientos WHERE Id=@IdMov)



	IF @IdTipoMov = 6
		UPDATE EstadoCuenta
		SET CantOpATM = CantOpATM + 1
		WHERE IdCuentaAhorros=@IdCuenta


	IF @IdTipoMov = 7 
		
		UPDATE EstadoCuenta
		SET CantOpHumano = CantOpHumano + 1
		WHERE IdCuentaAhorros=@IdCuenta

	

	SET @IdMov+=1
END

