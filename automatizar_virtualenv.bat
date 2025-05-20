@echo off
setlocal enabledelayedexpansion

echo ======================================
echo Criador de Esqueleto de Projeto Python
echo ======================================

:: Solicita o nome do projeto
set /p NOME_PROJETO="Digite o nome do projeto: "

:: Define o diretório raiz do projeto
set PROJETO_DIR=%CD%\%NOME_PROJETO%

echo.
echo Criando estrutura do projeto em: %PROJETO_DIR%
echo.

:: Cria o diretório do projeto
mkdir "%PROJETO_DIR%"

:: Cria a estrutura básica de diretórios
mkdir "%PROJETO_DIR%\src"
mkdir "%PROJETO_DIR%\src\%NOME_PROJETO%"
mkdir "%PROJETO_DIR%\tests"

:: Cria arquivos __init__.py
echo # Pacote %NOME_PROJETO% > "%PROJETO_DIR%\src\%NOME_PROJETO%\__init__.py"
echo # Testes para %NOME_PROJETO% > "%PROJETO_DIR%\tests\__init__.py"

:: Cria módulos de exemplo
echo # Módulo 1 para %NOME_PROJETO% > "%PROJETO_DIR%\src\%NOME_PROJETO%\modulo1.py"
echo # Módulo 2 para %NOME_PROJETO% > "%PROJETO_DIR%\src\%NOME_PROJETO%\modulo2.py"

:: Cria arquivos de teste
echo # Testes para modulo1.py > "%PROJETO_DIR%\tests\test_modulo1.py"
echo # Testes para modulo2.py > "%PROJETO_DIR%\tests\test_modulo2.py"

:: Cria o arquivo requirements.txt
echo # Dependências do projeto > "%PROJETO_DIR%\requirements.txt"

:: Cria setup.py
echo from setuptools import setup, find_packages > "%PROJETO_DIR%\setup.py"
echo. >> "%PROJETO_DIR%\setup.py"
echo setup( >> "%PROJETO_DIR%\setup.py"
echo     name="%NOME_PROJETO%", >> "%PROJETO_DIR%\setup.py"
echo     version="0.1.0", >> "%PROJETO_DIR%\setup.py"
echo     packages=find_packages(where="src"), >> "%PROJETO_DIR%\setup.py"
echo     package_dir={"": "src"}, >> "%PROJETO_DIR%\setup.py"
echo     install_requires=[], >> "%PROJETO_DIR%\setup.py"
echo ) >> "%PROJETO_DIR%\setup.py"

:: Cria README.md
echo # %NOME_PROJETO% > "%PROJETO_DIR%\README.md"
echo. >> "%PROJETO_DIR%\README.md"
echo Descrição do projeto. >> "%PROJETO_DIR%\README.md"
echo. >> "%PROJETO_DIR%\README.md"
echo ## Instalação >> "%PROJETO_DIR%\README.md"
echo. >> "%PROJETO_DIR%\README.md"
echo ```bash >> "%PROJETO_DIR%\README.md"
echo pip install -e . >> "%PROJETO_DIR%\README.md"
echo ``` >> "%PROJETO_DIR%\README.md"

echo.
echo Criando ambiente virtual...

:: Verifica se o Python está instalado
python --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Python não encontrado! Certifique-se de que o Python está instalado e no PATH.
    goto :fim
)

:: Verifica se virtualenv está instalado e instala se necessário
pip show virtualenv >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Instalando virtualenv...
    pip install virtualenv
)

:: Cria o ambiente virtual
cd "%PROJETO_DIR%"
python -m virtualenv venv

:: Ativa o ambiente virtual e instala dependências básicas
echo.
echo Ativando ambiente virtual e instalando dependências básicas...
call venv\Scripts\activate.bat
pip install -e .

echo.
echo ============================================
echo Projeto "%NOME_PROJETO%" criado com sucesso!
echo ============================================
echo.
echo Estrutura do projeto:
echo.
echo %NOME_PROJETO%/
echo │ ├── venv/               # Ambiente virtual Python
echo │ ├── src/
echo │ │   └── %NOME_PROJETO%/ # Código-fonte do projeto
echo │ │       ├── __init__.py
echo │ │       ├── modulo1.py
echo │ │       └── modulo2.py
echo │ ├── tests/              # Testes do projeto
echo │ │   ├── __init__.py
echo │ │   ├── test_modulo1.py
echo │ │   └── test_modulo2.py
echo │ ├── requirements.txt    # Dependências do projeto
echo │ ├── setup.py            # Configuração do pacote
echo │ └── README.md           # Documentação
echo.
echo Para ativar o ambiente virtual:
echo   - cd %NOME_PROJETO%
echo   - venv\Scripts\activate
echo.

:: Oferece opção para abrir o projeto no VS Code
set /p OPEN_VSCODE="Deseja abrir o projeto no VS Code? (S/N): "
if /i "%OPEN_VSCODE%"=="S" (
    code "%PROJETO_DIR%"
)

:fim
endlocal
