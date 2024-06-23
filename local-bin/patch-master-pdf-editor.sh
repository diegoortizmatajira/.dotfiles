#!/bin/bash
sudo perl -pi -e 's/(\xE8...\xFF)\x88(..\xBF\x30)/$1\xFE$2/g' /opt/master-pdf-editor-5/masterpdfeditor5
