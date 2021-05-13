import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;

public class MainNodeSecNodeThread extends Thread {

    private static ServerSocket serverSocketSecNode;

    public MainNodeSecNodeThread(int nodePort){
        try{
            serverSocketSecNode = new ServerSocket(nodePort);
            System.out.println("*Servidor de nós iniciou em "
                    + serverSocketSecNode.getInetAddress().getHostAddress() + ":" + nodePort +"*");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void run() {
        while(!serverSocketSecNode.isClosed()){
            try{
                Socket clientNode = serverSocketSecNode.accept();
                String ip = clientNode.getInetAddress().getHostAddress();
                int port = clientNode.getLocalPort();
                System.out.println("*conexão Nó* " + clientNode.getInetAddress().getHostName() +
                        "@" + ip + ":" + port);
                PrintWriter saidaSecNode = new PrintWriter(clientNode.getOutputStream(), true);
                BufferedReader entradaSecNode = new BufferedReader(new InputStreamReader(clientNode.getInputStream()));
                String portSecNode = entradaSecNode.readLine(); // recebe o port do participante
                saidaSecNode.println(RedeOverlayMainNode.adicionarSecNode(ip, portSecNode)); // chama a função que adiciona o participante à rede enviando o resultado


                saidaSecNode.close();

            } catch (IOException e) {
                if (serverSocketSecNode.isClosed()){
                    System.out.println("*Servidor de nós encerrou*");
                } else { e.printStackTrace(); }
            }
        }
    }

    public static void closeServerSocketSecNode() { //função chamada para encerrar o socket
        try {
            serverSocketSecNode.close();
        } catch (IOException e){
            e.printStackTrace();
        }
    }
}
