#!/usr/bin/env bash
set -eu

# Usage
#   create.sh <dir>
#
#   The directory will be the target directory, *excluding* the project
#   name. This means it should be an existing directory.
#
# Example
#   create.sh $HOME/projects

##########################################################################
# Input & Validation
##########################################################################

YEAR=$(date +%Y)

TARGET=$1
if [ ! -e "${TARGET}" ]; then
    echo "[E] The target directory doesn't exist. Aborting."
    exit 1
fi

echo -n "Please enter your name: "
read AUTHOR
if [ -z "${AUTHOR}" ]; then
    echo "[E] You must enter a name. Aborting."
    exit 1
fi

echo -n "Please enter your email address: "
read EMAIL
if [ -z "${EMAIL}" ]; then
    echo "[E] You must enter an email address for the man page. Aborting."
    exit 1
fi

echo -n "Please enter the name of the project: "
read PROJECT
PROJECT=$(echo "${PROJECT}" | tr '[:upper:]' '[:lower:]')
if [ -z "${PROJECT}" ]; then
    echo "[E] You must enter a project name. Aborting."
    exit 1
fi

echo -n "Please enter a short one-line description of your project: "
read DESCRIPTION
if [ -z "${DESCRIPTION}" ]; then
    echo "[E] You must enter a description for the man page. Aborting."
    exit 1
fi

##########################################################################
# Main
##########################################################################

echo "[I] Copying template to target directory..."
cp -r "./template" "${TARGET}/${PROJECT}"
cd "${TARGET}/${PROJECT}"

echo "[I] Updating project name in files..."
sed -i "s,PROJECT,${PROJECT},g" .gitignore
sed -i "s,PROJECT,${PROJECT},g" README.md
sed -i "s,PROJECT,${PROJECT},g" Makefile
sed -i "s,PROJECT,${PROJECT},g" man/project.man
sed -i "s,PROJECT,${PROJECT},g" src/project.c
sed -i "s,DESCRIPTION,${DESCRIPTION},g" man/project.man
sed -i "s,EMAIL,${EMAIL},g" man/project.man

echo "[I] Updating author name in files..."
sed -i "s,\[AUTHOR\],[${AUTHOR}],g" LICENSE
sed -i "s,AUTHOR,${AUTHOR},g" man/project.man

echo "[I] Updating year in files..."
sed -i "s,\[YEAR\],[${YEAR}],g" LICENSE

echo "[I] Renaming files..."
mv "src/project.c" "src/${PROJECT}.c"
mv "man/project.man" "man/${PROJECT}.man"

echo "[I] Initializing git repository..."
git init
git add -A
git commit -m "Initial commit"

echo "[I] All done. You can now run 'make && sudo make install'"
echo "[I] Enjoy!"
