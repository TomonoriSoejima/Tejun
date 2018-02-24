import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.InetAddress;
import java.net.ServerSocket;
import java.net.Socket;
public class MyServerSocket {
    private ServerSocket server;
    public MyServerSocket(String bindAddr) throws Exception {
        this.server = new ServerSocket(514);
        // this.server = new ServerSocket(0, 1, InetAddress.getByName(bindAddr));
    }
    private void listen() throws Exception {
        String data = null;
        Socket client = this.server.accept();
        String clientAddress = client.getInetAddress().getHostAddress();
        System.out.println("\r\nNew connection from " + clientAddress);
        
        BufferedReader in = new BufferedReader(
                new InputStreamReader(client.getInputStream()));        
        while ( (data = in.readLine()) != null ) {
            System.out.println("\r\nMessage from " + clientAddress + ": " + data);
        }
    }
    public InetAddress getSocketAddress() {
        return this.server.getInetAddress();
    }
    
    public int getPort() {
        return this.server.getLocalPort();
    }
    public static void main(String[] args) throws Exception {
        MyServerSocket app = new MyServerSocket(args[0]);
        
        System.out.println("\r\nRunning Server: " + 
                "Host=" + app.getSocketAddress().getHostAddress() + 
                " Port=" + app.getPort());
        
        app.listen();
    }
}

