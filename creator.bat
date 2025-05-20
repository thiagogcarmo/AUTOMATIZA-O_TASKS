::NOMEAR COMO creator.bat
::PREPARAR O AMBIENTE VIRTUAL E CRIAR
::COMANDOS
@echo off
echo ====================================
echo Configuracao de Ambiente Virtual Python
echo ====================================

:: Verificar se o Python esta instalado
python --version > nul 2>&1
if %errorlevel% neq 0 (
    echo Python nao encontrado. Por favor, instale o Python antes de continuar.
    pause
    exit /b 1
)

echo [1/4] Atualizando pip...
python -m pip install --upgrade pip
if %errorlevel% neq 0 (
    echo Erro ao atualizar o pip.
    pause
    exit /b 1
)
echo Pip atualizado com sucesso!

echo [2/4] Instalando virtualenv...
pip install virtualenv
if %errorlevel% neq 0 (
    echo Erro ao instalar virtualenv.
    pause
    exit /b 1
)
echo Virtualenv instalado com sucesso!

:: Definir o nome do ambiente virtual
set VENV_NAME=venv
if not "%1"=="" (
    set VENV_NAME=%1
)

echo [3/4] Criando ambiente virtual '%VENV_NAME%'...
python -m virtualenv %VENV_NAME%
if %errorlevel% neq 0 (
    echo Erro ao criar o ambiente virtual.
    pause
    exit /b 1
)
echo Ambiente virtual criado com sucesso!

echo [4/4] Ativando o ambiente virtual...
call %VENV_NAME%\Scripts\activate
if %errorlevel% neq 0 (
    echo Erro ao ativar o ambiente virtual.
    pause
    exit /b 1
)

echo ====================================
echo Ambiente virtual '%VENV_NAME%' configurado e ativado com sucesso!
echo Para desativar o ambiente, digite 'deactivate'
echo ====================================

:: Manter a janela CMD aberta com o ambiente ativado
cmd /k
