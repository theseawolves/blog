# blog
### 如何发表博客

```
You：

folk 本仓库 到 你的仓库
git clone ...
cd blog
npm install

git pull 
hexo new "post title" //新建博客
edit /source/_posts/[post title.md] //编辑博客
hexo server //预览效果
git push 你的仓库
提交 pull Request 到 本仓库

Me：

merge
git pull 本仓库
hexo server
hexo generate
hexo deploy

```
