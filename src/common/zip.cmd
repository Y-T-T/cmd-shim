@echo off
:: Usage: zip [output_file.zip] [source_file_or_folder]
:: Example: zip backup.zip ./logs

if "%~2"=="" (
    echo Usage: zip [output.zip] [source_path]
    exit /b 1
)

:: -Force: If the destination file exists, it will be overwritten
:: -CompressionLevel Optimal: Use optimal compression
powershell -NoProfile -Command "Compress-Archive -Path '%~2' -DestinationPath '%~1' -CompressionLevel Optimal -Force"