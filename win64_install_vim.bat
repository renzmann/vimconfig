@echo off

:: ===========================================================================
:: Setup // variables
:: ===========================================================================

:: vim install variables
set vimurl="https://github.com/vim/vim"
set pyinstall=%USERPROFILE%\\miniconda3
set pyver=37

:: dotfile variables
set mygit="https://github.com/renzmann/dotfiles"
set mygitout=%USERPROFILE%\\dotfiles
set vundleurl="https://github.com/VundleVim/Vundle.vim"


:: ===========================================================================
:: Main script
:: ===========================================================================

:: Run from user home
cd %USERPROFILE%

:: compile correct version of vim
git clone %vimurl%
cd vim\\src
nmake -f Make_mvc.mak GUI=yes PYTHON3=%pyinstall% DYNAMIC_PYTHON=yes PYTHON3_VER=%pyver%

:: copy dotfiles/configuration
cd %USERPROFILE%
git clone %mygit% %mygitout%
cp .vimrc %USERPROFILE%
cp .pylintrc %USERPROFILE%

:: Install plugins
mkdir .vim
mkdir .vim\\bundle
git clone %vundleurl% %USERPROFILE%\\.vim\\bundle\\Vundle.vim
gvim -u %mygitout%\\pluginrc.vim -s %mygitout%\\doplugins.txt
:: TODO download and install gvimfullscreen.dll

:: Compile YouCompleteMe
cd %USERPROFILE%\\.vim\\bundle\\YouCompleteMe
python install.py
