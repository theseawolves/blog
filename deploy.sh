hexo generate
cp -R public/* .deploy/theseawolves.github.io
cd .deploy/theseawolves.github.io
git add .
git commit -m “update”
git push origin master
