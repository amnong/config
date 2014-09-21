#!/bin/bash

HERE=`dirname $0`
cd $HERE

function backup {
  local old_name
  local new_name
  old_name=$HOME/$1
  new_name=$HOME/_$1
  if [ -a $old_name ]; then
    echo "Backing up $old_name to $new_name"
    mv $old_name $new_name
  fi
}

if [ -a "copy" ]; then
  for entry in `ls -A copy`; do
    backup $entry
    cp -r copy/$entry $HOME/
  done
fi

if [ -a "link" ]; then
  for entry in `ls -A link`; do
    backup $entry
    ln -s $HERE/link/$entry $HOME/$entry
  done
fi

if [ -a "patch" ]; then
  for entry in `ls -A patch`; do
    if [ -a "$HOME/$entry" ]; then
      echo "Patching $HOME/$entry"
      cp -r patch/$entry $HOME/
    fi
  done
fi

