#!/bin/bash

PKG_NAME="req"

QHOME=$PREFIX/q
mkdir -p $QHOME/pkg/${PKG_NAME}
cp -r ${SRC_DIR}/src/*.q $QHOME/pkg/${PKG_NAME}/
