#!/bin/sh
# ----------------------------------------------------------------------------
# Maven Wrapper startup script, version 3.3.2
#
# Required ENV vars:
#   JAVA_HOME - location of a JDK home dir
# Optional ENV vars:
#   MAVEN_OPTS - parameters passed to the Java VM when running Maven
#   MAVEN_SKIP_RC - flag to disable loading of mavenrc files
# ----------------------------------------------------------------------------

set -euf

BASE_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

# OS specific support.
cygwin=false
mingw=false
case "$(uname)" in
  CYGWIN*) cygwin=true ;;
  MINGW*) mingw=true ;;
  MSYS*) mingw=true ;;
  *) ;; 
esac

# Determine Java command
if [ -n "${JAVA_HOME:-}" ] ; then
  if [ -x "$JAVA_HOME/jre/sh/java" ] ; then
    # IBM's JDK on AIX uses strange locations for the executables
    JAVACMD="$JAVA_HOME/jre/sh/java"
  else
    JAVACMD="$JAVA_HOME/bin/java"
  fi
  if [ ! -x "$JAVACMD" ] ; then
    echo "ERROR: JAVA_HOME is set to an invalid directory: $JAVA_HOME" >&2
    exit 1
  fi
else
  JAVACMD=$(command -v java || true)
  if [ -z "$JAVACMD" ] ; then
    echo "ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH." >&2
    exit 1
  fi
fi

WRAPPER_DIR="$BASE_DIR/.mvn/wrapper"
WRAPPER_JAR="$WRAPPER_DIR/maven-wrapper.jar"
WRAPPER_PROPERTIES="$WRAPPER_DIR/maven-wrapper.properties"

if [ ! -f "$WRAPPER_PROPERTIES" ]; then
  echo "ERROR: Missing $WRAPPER_PROPERTIES" >&2
  exit 1
fi

# Read distributionUrl from properties
DISTRIBUTION_URL=$(sed -n 's/^distributionUrl=//p' "$WRAPPER_PROPERTIES" | tr -d '\r')
if [ -z "$DISTRIBUTION_URL" ]; then
  echo "ERROR: distributionUrl is not set in $WRAPPER_PROPERTIES" >&2
  exit 1
fi

# Download wrapper jar if missing
if [ ! -f "$WRAPPER_JAR" ]; then
  echo "Downloading Maven Wrapper jar..." >&2
  mkdir -p "$WRAPPER_DIR"
  WRAPPER_JAR_URL="https://repo.maven.apache.org/maven2/org/apache/maven/wrapper/maven-wrapper/3.3.2/maven-wrapper-3.3.2.jar"
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$WRAPPER_JAR_URL" -o "$WRAPPER_JAR"
  elif command -v wget >/dev/null 2>&1; then
    wget -q "$WRAPPER_JAR_URL" -O "$WRAPPER_JAR"
  else
    echo "ERROR: Neither curl nor wget is available to download Maven Wrapper jar." >&2
    exit 1
  fi
fi

exec "$JAVACMD" ${MAVEN_OPTS:-} \
  -classpath "$WRAPPER_JAR" \
  -Dmaven.multiModuleProjectDirectory="$BASE_DIR" \
  org.apache.maven.wrapper.MavenWrapperMain "$@"
