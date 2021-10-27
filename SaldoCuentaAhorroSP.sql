

DECLARE @i INT=1, @nuevoSaldo INT;

WHILE @i<25
BEGIN
	SET @nuevoSaldo = (SELECT SUM(MontoMonedaCuenta)
	FROM Movimientos
	WHERE IdCuenta=@i);

	UPDATE CuentaAhorros
	SET Saldo = @nuevoSaldo
	WHERE Id=@i


	SET @i +=1

END