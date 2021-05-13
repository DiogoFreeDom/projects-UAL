import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;

public class MainNodeClientThread extends Thread {

    private static ServerSocket serverSocketClient;

    public MainNodeClientThread (int clientPort){
        try{
            serverSocketClient = new ServerSocket(clientPort);
            System.out.println("*Servidor de clientes iniciou em "
                    + serverSocketClient.getInetAddress().getHostAddress() + ":" + clientPort+"*");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void run() {
        while(!serverSocketClient.isClosed()){
            try{
                Socket cliente = serverSocketClient.accept();
                System.out.println("*conexão Cliente* " + cliente.getInetAddress().getHostName() +
                        "@" + cliente.getInetAddress().getHostAddress() + ":" + cliente.getLocalPort() );
                new RedeOverlayMainNode(cliente).start(); //cria um objecto do main node e começa a thread para dar handle ao cliente
            } catch (IOException e) {
                if (serverSocketClient.isClosed()){
                    System.out.println("*Servidor de clientes encerrou*");
                } else { e.printStackTrace(); }
            }
        }
    }

    public static void closeServerSocketCliente() { //função chamada para encerrar o socket
        try {
            serverSocketClient.close();
        } catch (IOException e){
            e.printStackTrace();
        }
    }
}
