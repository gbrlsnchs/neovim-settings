#!/bin/sh

if [ $# -eq 1 ]; then
    if [ -f $1 ]; then
        SCRIPT_DIR=$(dirname $0)
        CUR_BACKUP_INIT_VIM=$SCRIPT_DIR/$1
        CUR_INIT_VIM=$SCRIPT_DIR/init.vim
        CUR_INIT_VIM_MD5SUM=$SCRIPT_DIR/init.$(md5sum $CUR_INIT_VIM | awk '{ print $1 }').vim
        mv $CUR_INIT_VIM $SCRIPT_DIR/init.$(md5sum $SCRIPT_DIR/init.vim | awk '{ print $1 }').vim
        mv $CUR_BACKUP_INIT_VIM $CUR_INIT_VIM
    fi
fi
