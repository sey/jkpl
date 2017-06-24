#!/bin/bash
#

PACKAGE_NAME=jkpl
PACKAGE_VERSION=1.0.0-snapshot
PACKAGE_FILE=${PACKAGE_NAME}-${PACKAGE_VERSION}.tgz
PACKAGE_URL=${NPM_REPO_URL}/${PACKAGE_NAME}/-/${PACKAGE_FILE}

TMP_DIR=/tmp/deploy/${PACKAGE_NAME}
TMP_FILE=${TMP_DIR}/${PACKAGE_FILE}
TARGET_DIR=/var/www/${PACKAGE_NAME}

if [ -d ${TMP_DIR} ]; then
  rm -rf ${TMP_DIR} || exit
fi

echo 'Create tmp directory:' ${TMP_DIR}
mkdir -p ${TMP_DIR} || exit

echo 'Download file: wget -O' ${TMP_FILE} ${PACKAGE_URL}
wget --user=${NPM_REPO_USR} --password=${NPM_REPO_USR} -O ${TMP_FILE} ${PACKAGE_URL} || exit

echo 'Extract file:' tar xf ${TMP_FILE} '-C' ${TMP_DIR}
tar xf ${TMP_FILE} -C ${TMP_DIR} || exit

pushd ${TMP_DIR}/package || exit

npm install --production || exit

popd || exit

if [ -d ${TARGET_DIR} ]; then
  sudo rm -rf ${TARGET_DIR}/* || exit
fi

sudo mkdir -p ${TARGET_DIR} || exit

sudo mv ${TMP_DIR}/package/* ${TARGET_DIR} || exit

pm2 start ${TARGET_DIR}/src/app.js --name jkpl || exit
