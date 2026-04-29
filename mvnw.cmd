@REM ----------------------------------------------------------------------------
@REM Maven Wrapper startup script, version 3.3.2
@REM ----------------------------------------------------------------------------
@echo off
setlocal

set BASE_DIR=%~dp0

if defined JAVA_HOME (
  set "JAVACMD=%JAVA_HOME%\bin\java.exe"
) else (
  set "JAVACMD=java.exe"
)

set WRAPPER_DIR=%BASE_DIR%\.mvn\wrapper
set WRAPPER_JAR=%WRAPPER_DIR%\maven-wrapper.jar
set WRAPPER_PROPERTIES=%WRAPPER_DIR%\maven-wrapper.properties

if not exist "%WRAPPER_PROPERTIES%" (
  echo ERROR: Missing %WRAPPER_PROPERTIES% 1>&2
  exit /b 1
)

for /f "usebackq tokens=1,* delims==" %%A in ("%WRAPPER_PROPERTIES%") do (
  if "%%A"=="distributionUrl" set "DISTRIBUTION_URL=%%B"
)

if not defined DISTRIBUTION_URL (
  echo ERROR: distributionUrl is not set in %WRAPPER_PROPERTIES% 1>&2
  exit /b 1
)

if not exist "%WRAPPER_JAR%" (
  echo Downloading Maven Wrapper jar... 1>&2
  if not exist "%WRAPPER_DIR%" mkdir "%WRAPPER_DIR%"
  set "WRAPPER_JAR_URL=https://repo.maven.apache.org/maven2/org/apache/maven/wrapper/maven-wrapper/3.3.2/maven-wrapper-3.3.2.jar"
  powershell -NoProfile -ExecutionPolicy Bypass -Command "(New-Object Net.WebClient).DownloadFile('%WRAPPER_JAR_URL%','%WRAPPER_JAR%')" || (
    echo ERROR: Failed to download Maven Wrapper jar. 1>&2
    exit /b 1
  )
)

"%JAVACMD%" %MAVEN_OPTS% -classpath "%WRAPPER_JAR%" -Dmaven.multiModuleProjectDirectory="%BASE_DIR%" org.apache.maven.wrapper.MavenWrapperMain %*
endlocal
