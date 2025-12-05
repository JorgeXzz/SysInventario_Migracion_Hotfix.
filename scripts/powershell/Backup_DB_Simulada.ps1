# Script: Backup_DB_Simulada.ps1
# Función: Crea un respaldo de la base de datos del inventario con fecha y hora

$fecha = Get-Date -Format "yyyyMMdd_HHmm"
$origen = "C:\Simulacion_Cambio_TI_Sem12\DB_Inventario_Simulada.txt"
$destino = "C:\Simulacion_Cambio_TI_Sem12\Backup_DB\DB_Inventario_Simulada_$fecha.bak"

# Simular proceso de copia
Write-Output "Iniciando respaldo..."
Copy-Item $origen $destino

Write-Output "[INFO] Respaldo completado: $destino"

# Registrar en Log
$logEntry = "$(Get-Date) - Respaldo generado: $destino"
Add-Content "C:\Simulacion_Cambio_TI_Sem12\Logs\Log_Respaldo.txt" $logEntry
