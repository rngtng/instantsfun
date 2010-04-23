#!/bin/bash
if [ -h "code/libcocoautils.jnilib" ] 
then
    rm code/libcocoautils.jnilib
    rm code/xulrunner
    echo "removed links"
else
    ln -s ../mozswing_native/macosx/libcocoautils.jnilib code/libcocoautils.jnilib
    ln -s ../mozswing_native/macosx/xulrunner/  code/xulrunner    
    echo "created links"
fi