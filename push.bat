@echo off
git init
git add -A
git commit -m "first commit"
git branch -M current
git remote add origin https://github.com/islamicCodes/flutter_downloader.git
git push -u origin current
pause