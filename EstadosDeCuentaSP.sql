USE cuentaAhorros


CREATE PROCEDURE EstadosDeCuenta
@OutCodeResult INT
AS
	
DECLARE @cont INT=1, @IdCuentaAhorros INT, @IdEstadoCuenta INT, @IdTipoCuentaAhorro INT, 
@SaldoMin INT, @Saldo INT,@MultaSaldoMin INT, @SaldoFinal INT,@NumRetirosHumano INT,
@NumRetirosAutomatico INT, @ComisionRetiroHumano INT, @ComisionRetiroAutomatico INT,
@diferenciaRetirosHumano INT, @diferenciaRetirosATM INT, @ContRetiroAtm INT, 
@ContRetiroHumano INT, @TasaInteres INT, @Suma INT, @CargoMensual INT

WHILE @cont<25
	BEGIN


	SET @IdCuentaAhorros = (SELECT Id FROM CuentaAhorros WHERE Id= @cont)
	-- SET IDCUENTA AHORRO DE LA TABLA ESTADO DE CUENTA 
	SET @IdEstadoCuenta = (SELECT Id FROM EstadoCuenta WHERE Id=@IdCuentaAhorros)

	SET @IdTipoCuentaAhorro =(SELECT IdTipoCuenta FROM cuentaAhorros WHERE Id=@IdCuentaAhorros)
	-- SET INTERES
	SET @TasaInteres = (SELECT TasaInteres FROM TiposCuentaAhorros WHERE  Id= @IdTipoCuentaAhorro)
	-- SET DE MULTAS
	SET @SaldoMin = (SELECT SaldoMin FROM dbo.TiposCuentaAhorros WHERE Id= @IdTipoCuentaAhorro)




	SET @MultaSaldoMin = (SELECT MultaSaldoMin FROM dbo.TiposCuentaAhorros WHERE Id= @IdTipoCuentaAhorro)



	SET @Saldo = (SELECT Saldo FROM cuentaAhorros WHERE Id = @IdCuentaAhorros )
	--CARGO MENSUAL 

	SET @CargoMensual = (SELECT CargoMensual FROM dbo.TiposCuentaAhorros WHERE Id= @IdTipoCuentaAhorro)
	-- SET NUMEROS DE RETIROS DE LA TABLA TIPOS CUENTA AHORROS 

	SET @NumRetirosHumano = (SELECT NumRetirosHumano FROM dbo.TiposCuentaAhorros WHERE Id= @IdTipoCuentaAhorro)

	SET @NumRetirosAutomatico=  (SELECT NumRetirosAutomatico FROM dbo.TiposCuentaAhorros WHERE Id= @IdTipoCuentaAhorro)

	-- SET DE COMISIONES DE LA TABLA TIPOS CUENTA AHORROS
	SET @ComisionRetiroHumano = (SELECT ComisionHumano FROM dbo.TiposCuentaAhorros WHERE Id= @IdTipoCuentaAhorro)

	SET @ComisionRetiroAutomatico=  (SELECT ComisionCajero FROM dbo.TiposCuentaAhorros WHERE Id= @IdTipoCuentaAhorro)

	
	--SET RETIROS DE CAJERO DE LA TABLA ESTADO DE CUENTA 
	SET @ContRetiroAtm = (SELECT CantOpATM FROM EstadoCuenta WHERE IdCuentaAhorros = @IdCuentaAhorros)
	SET @ContRetiroHumano = (SELECT CantOpHumano FROM EstadoCuenta WHERE IdCuentaAhorros = @IdCuentaAhorros)

	SET @diferenciaRetirosHumano =  (@ContRetiroHumano - @NumRetirosHumano)

	SET @diferenciaRetirosATM = (@ContRetiroAtm- @NumRetirosAutomatico)

	UPDATE EstadoCuenta 
	SET SaldoInicial = @Saldo
	WHERE Id= @IdEstadoCuenta
	 

	IF @TasaInteres =10

		SET @Suma = @Saldo * 0.1
		SET @SaldoFinal = (@Saldo + @Suma)

	IF @TasaInteres = 15

		SET @Suma = @Saldo * 0.15
		SET @SaldoFinal = @Saldo + @Suma

	IF  @TasaInteres = 20
		SET @Suma = @Saldo * 0.2
		SET @SaldoFinal = @Saldo + @Suma




	IF @Saldo<=@SaldoMin 
		SET @SaldoFinal = @Saldo - @MultaSaldoMin


	IF (@diferenciaRetirosHumano >0)

		SET @SaldoFinal = @Saldo - (@diferenciaRetirosHumano * @ComisionRetiroHumano)

	IF (@diferenciaRetirosATM >0)

		SET @SaldoFinal = @Saldo - (@diferenciaRetirosATM * @ComisionRetiroAutomatico)



	SET @SaldoFinal = @Saldo - @CargoMensual


	UPDATE EstadoCuenta
	SET SaldoFinal=@SaldoFinal
	WHERE Id=@IdEstadoCuenta
SET @cont+=1

END;
