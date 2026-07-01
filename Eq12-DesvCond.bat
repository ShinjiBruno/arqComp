@echo off
setlocal

set VHDL_FILES= Eq12-PC.vhd Eq12-PC_plus1.vhd Eq12-PC_Top.vhd Eq12-Rom.vhd Eq12-Maq_Estados.vhd Eq12-un_controle.vhd Eq12-reg20bits.vhd Eq12-RegFile.vhd Eq12-ULA.vhd Eq12-Reg_ULA_Top.vhd Eq12-ROM_PC_UC.vhd Eq12-Proc_Top.vhd Eq12-DesvCond_tb.vhd

set TOP_ENTITY=Eq12_DesvCond_tb
set SIM_TIME=1us
set VHDL_STANDARD=--std=08

if "%~1"=="" (
    set OUTPUT_DIR=build
) else (
    set OUTPUT_DIR=%~1
)

set VCD_WAVE_FILE=%OUTPUT_DIR%\tb_wave.vcd
set GHW_WAVE_FILE=%OUTPUT_DIR%\tb_wave.ghw

set EXECUTABLE=%OUTPUT_DIR%\%TOP_ENTITY%.exe


if not exist "%OUTPUT_DIR%" (
    mkdir "%OUTPUT_DIR%"
    if errorlevel 1 (
        echo ERRO ao criar diretorio %OUTPUT_DIR%
        exit /b 1
    )
)

del /Q /F "%OUTPUT_DIR%\*.o" "%OUTPUT_DIR%\*.cf" "%VCD_WAVE_FILE%" "%GHW_WAVE_FILE%" "%OUTPUT_DIR%\*.ghw" 2>nul

for %%f in (%VHDL_FILES%) do (
    if not exist "%%f" (
        echo ERRO: Arquivo VHDL nao encontrado: %%f
        exit /b 1
    )
    ghdl -a %VHDL_STANDARD% --workdir="%OUTPUT_DIR%" "%%f"
    if errorlevel 1 (
        echo ERRO na compilacao de %%f
        exit /b 1
    )
)

ghdl -e %VHDL_STANDARD% --workdir="%OUTPUT_DIR%" -o "%EXECUTABLE%" "%TOP_ENTITY%"
if errorlevel 1 (
    echo ERRO na elaboracao
    exit /b 1
)

set RUNTIME_ARGS=--stop-time="%SIM_TIME%" --vcd="%VCD_WAVE_FILE%" --wave="%GHW_WAVE_FILE%"

if exist "%EXECUTABLE%" (
    "%EXECUTABLE%" %RUNTIME_ARGS%
    if errorlevel 1 (
        echo ERRO durante a simulacao ^(binario .exe^)
        exit /b 1
    )
) else if exist "%OUTPUT_DIR%\%TOP_ENTITY%" (
    echo Executando binario elaborado: %OUTPUT_DIR%\%TOP_ENTITY%
    "%OUTPUT_DIR%\%TOP_ENTITY%" %RUNTIME_ARGS%
    if errorlevel 1 (
        echo ERRO durante a simulacao ^(binario sem extensao^)
        exit /b 1
    )
) else (
    echo Binario nao encontrado. Executando via 'ghdl -r'...
    ghdl -r %VHDL_STANDARD% --workdir="%OUTPUT_DIR%" "%TOP_ENTITY%" %RUNTIME_ARGS%
    if errorlevel 1 (
        echo ERRO durante a simulacao ^(ghdl -r^)
        exit /b 1
    )
)

exit /b 0