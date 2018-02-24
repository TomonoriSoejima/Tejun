import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.*;
import java.nio.channels.ServerSocketChannel;

public class SocketTest {
    public static void main(String[] args) throws Exception {
        try {
            InetAddress addr = InetAddress.getByName("localhost");

            ServerSocketChannel ssc = ServerSocketChannel.open();
            ssc.socket().setReuseAddress(true);

            InetSocketAddress socket_address = new InetSocketAddress(addr, 514);

            ssc.socket().bind(socket_address);

           // initSocket(newChannelFD(runtime, ssc));

        } catch(UnknownHostException e) {
            //throw SocketUtils.sockerr(runtime, "initialize: name or service not known");

        } catch(BindException e) {
            //throw runtime.newErrnoEADDRFromBindException(e);

        } catch(SocketException e) {
            System.out.println("error" + e.getMessage());
//            if(msg.indexOf("Permission denied") != -1) {
//                throw runtime.newErrnoEACCESError("bind(2)");
//            } else {
//                throw SocketUtils.sockerr(runtime, "initialize: name or service not known");
//            }

        } catch(IOException e) {
            System.out.println("error" + e.getMessage());
//            throw runtime.newIOErrorFromException(e);
//
//        } catch (IllegalArgumentException iae) {
//            throw SocketUtils.sockerr(runtime, iae.getMessage());
        }

        while ( true ) {
            Thread.sleep(30000);
            System.out.println("no error");
        }
    }

}






