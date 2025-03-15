#!/bin/bash
sed -E 's#https://github.com/([^/]*)/(.*).git#git@github.com:\1/\2.git#g' $1