 #!/bin/bash
echo "\033[1;32mClean source folder:\033[0m"
rm -rf locale/sources/*
sleep 1
echo "\033[1;32mCopy files to translate\033[0m"
cp wxgui/pinguino.py 		locale/sources/pinguino.py
cp wxgui/editor/debugger.py 	locale/sources/debugger.py
cp wxgui/editor/editeur.py 	locale/sources/editeur.py
cp wxgui/editor/general.py 	locale/sources/general.py
cp wxgui/frames/framesX3.py 	locale/sources/framesX3.py
sleep 1
echo "\033[1;32mInput language to translate\033[0m"
echo "\033[1;36m  * da -> Danish\033[0m"
echo "\033[1;36m  * en -> English\033[0m"
echo "\033[1;36m  * es -> Spanish\033[0m"
echo "\033[1;36m  * fr -> French\033[0m"
echo "\033[1;36m  * hr -> Croatian\033[0m"
echo "\033[1;36m  * it -> Italian\033[0m"
echo "\033[1;36m  * da -> Danish\033[0m"
echo "\033[1;36m  * nl -> Dutch\033[0m"
echo "\033[1;36m  * pt -> Portuguese\033[0m"
echo "\033[1;36m  * pt_BR -> Portuguese Brazilian\033[0m"
echo "\033[1;36m  * ro -> Romanian\033[0m"
echo -n "Please input the ID for language: "
read language
poedit /opt/pinguino/x3dev/locale/$language/LC_MESSAGES/pinguino.po

