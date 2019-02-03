# Oh my git
omgurl=https://github.com/arialdomartini/oh-my-git.git
omgfolder=~/.oh-my-git
if [ ! -d "$omgfolder" ] ; then
    git clone $omgurl $omgfolder
else
    cd "$omgfolder"
	git checkout master
    git pull
fi

fonturl=https://github.com/gabrielelana/awesome-terminal-fonts.git
fontfolder=~/.awesome-terminal-fonts
if [ ! -d "$fontfolder" ] ; then
    git clone $fonturl $fontfolder
fi

git -C $fontfolder checkout patching-strategy
cp $fontfolder/patched/*.ttf /Library/Fonts

