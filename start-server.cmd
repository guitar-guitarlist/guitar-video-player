@echo off
cd /d "%~dp0"
where node >nul 2>nul
if errorlevel 1 (
  echo Node.js is required to use YouTube links.
  pause
  exit /b 1
)
echo Opening Guitar Video Player...
start "" "http://localhost:8787/index.html"
node -e "const http=require('http'),fs=require('fs'),path=require('path');const root=process.cwd();http.createServer((req,res)=>{const file=path.join(root,decodeURIComponent(req.url.split('?')[0]==='/'?'/index.html':req.url.split('?')[0]));if(!file.startsWith(root)){res.writeHead(403);return res.end('Forbidden');}fs.readFile(file,(err,data)=>{if(err){res.writeHead(404);return res.end('Not found');}const ext=path.extname(file).toLowerCase();const type={'.html':'text/html; charset=utf-8','.js':'text/javascript; charset=utf-8','.css':'text/css; charset=utf-8','.mp4':'video/mp4','.webm':'video/webm','.mov':'video/quicktime','.m4a':'audio/mp4','.mp3':'audio/mpeg','.wav':'audio/wav'}[ext]||'application/octet-stream';res.writeHead(200,{'Content-Type':type,'Referrer-Policy':'strict-origin-when-cross-origin'});res.end(data);});}).listen(8787,'localhost',()=>console.log('Open http://localhost:8787/index.html'));"
