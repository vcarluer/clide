@echo off
echo Searching %1...
dir *%1*.* /s /b | grep -v "~"
