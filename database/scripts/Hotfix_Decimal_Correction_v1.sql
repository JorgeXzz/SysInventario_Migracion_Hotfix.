-- AUTOR: Equipo GCP - Vigil
-- FECHA: 03/12/2025
-- DESCRIPCION: Script de emergencia para corregir error de separador decimal.
-- TICKET: RFC-INV-001

PRINT 'Iniciando corrección de datos masiva...';

BEGIN TRANSACTION;

BEGIN TRY
    -- 1. Crear tabla de respaldo temporal antes de tocar nada
    SELECT * INTO Mae_Articulos_Backup_Crisis
    FROM Mae_Articulos;

    -- 2. Corregir items donde el stock es ilógico (> 50,000 unidades) debido al error de coma
    UPDATE Mae_Articulos
    SET Stock_Actual = Stock_Actual / 1000,
        Fecha_Modificacion = GETDATE(),
        Usuario_Modificacion = 'ADMIN_HOTFIX'
    WHERE Stock_Actual > 50000
      AND Unidad_Medida = 'UND';

    PRINT 'Filas corregidas exitosamente.';
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error crítico detectado. Se ha revertido el cambio.';
END CATCH;
