CICD=/Volumes/hardcore/git-clone-repo/kenerl_hack_include_changelog
SRC=/Volumes/hardcore/git-clone-repo/linux
STRUCTURE=feature-structure.txt

cd $SRC
find . -name \*.h -print > $CICD/feature-structure.txt
cd $CICD

sed 's/^..//' feature-structure.txt > tmp.out
mv tmp.out feature-structure.txt

declare -a codes=()

cd $SRC
echo -e "\n[START] synchronizing files...\n"
cat $CICD/$STRUCTURE | while read var
do
    if [ ! -f "$CICD/${var}" ]; then
        echo "acquire ${var}"
        /usr/local/opt/coreutils/libexec/gnubin/cp --parents ${var} $CICD/
    else
        echo "update ${var}"
        /usr/local/opt/coreutils/libexec/gnubin/cp $SRC/${var} $CICD/${var} 
    fi
done
cd $CICD

echo -e "\n[DONE] synchronizing files \n"
