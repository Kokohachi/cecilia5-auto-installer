@echo off

REM check if python is installed and if so, get the version number
echo Stage1: Checking if Python is installed ...
for /f "tokens=1-3" %%i in ('python -c "import sys; print(sys.version_info[0],sys.version_info[1],sys.version_info[2])"') do (
    set py_major=%%i
    set py_minor=%%j
    set py_patch=%%k
)

if "%py_major%"=="" (
    echo Error: Python is not installed. Please install Python 3.7 or greater.
    exit /b 1
)

REM check if python version is < 3.7 or >= 3.11 and display error message if true
if "%py_major%"=="3" (
    if %py_minor% LSS 7 (
        echo Error: Python version is %py_major%.%py_minor%.%py_patch%. Python version must be 3.7 or greater.
        exit /b 1
    ) else if %py_minor% GEQ 11 (
        echoError: Python version is %py_major%.%py_minor%.%py_patch%. Python version must be less than 3.11.
        exit /b 1
    )
) else (
    echo Error: Python version is %py_major%.%py_minor%.%py_patch%. Python version must be 3.7 or greater.
    exit /b 1
)

REM create virtualenv
echo Stage2: Create virtualenv
echo         Creating virtualenv in .venv ...
python -m venv .venv
echo         Virtualenv created successfully.
echo         Activating virtualenv ...
call .venv\Scripts\activate
echo         Virtualenv activated successfully.
echo Stage3: Install dependencies
echo         Installing dependencies ...
pip install pyo wxPython numpy GitPython
echo        Dependencies installed successfully.
echo Stage4: Clone git repository
echo cloning git repository ...
python -c "import git; git.Repo.clone_from('https://github.com/belangeo/cecilia5.git', 'cecilia5')"
echo        Git repository cloned successfully.
echo Stage5: Start Cecilia5
echo        Starting Cecilia5 ...
cd cecilia5
python Cecilia5.py
echo        Cecilia5 started successfully.
exit /b 0
