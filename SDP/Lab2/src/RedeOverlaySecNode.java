
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Objects;

public class RedeOverlaySecNode extends Thread {

    private static final HashMap<String,String> tabelaDeDispersaoLocal = new HashMap<>();
    private static ServerSocket serverSocket;
    private final Socket mainNode;
    private static int nodeID;                  // ID na rede
    private static int numParticipantes;        // número de nós na rede
    private static final int mainNodePort = 4343;


    public RedeOverlaySecNode(Socket mainNode) {
        this.mainNode = mainNode;
    }

    public static void main(String[] args) {
        String mainNodeIP = args[0];                        //recebe o IP do nó principal por argumento
        final int servicePort = Integer.parseInt(args[1]);  //recebe o port do participante por argumento

        try {
            Socket clientNode = new Socket(mainNodeIP, mainNodePort);
            PrintWriter saida = new PrintWriter(clientNode.getOutputStream(), true);
            BufferedReader entrada = new BufferedReader(new InputStreamReader(clientNode.getInputStream()));
            saida.println(servicePort);         //envia o port ao nó principal

            System.out.println("Ligação estabelecida");

            numParticipantes = Integer.parseInt(entrada.readLine());

            nodeID = numParticipantes - 1;      //o ID na rede do nó que acabou de ser adicionado é o total de participantes -1
                                                // porque o array vai de 0 a n-1

            saida.close();
            entrada.close();
            clientNode.close();

        } catch (IOException e){
            System.out.println("Não foi possível alcançar o servidor principal.");
            e.printStackTrace();
            System.exit(1);
        }

        try{
            serverSocket = new ServerSocket(servicePort);
            System.out.println("*Servidor iniciou em " + serverSocket.getInetAddress().getHostName()
                    + ":" + servicePort + "*");
        } catch (IOException e) {
            e.printStackTrace();
            System.exit(1);
        }

        while(!serverSocket.isClosed()){
            try{
                Socket mainNode = serverSocket.accept();
                System.out.println("*conexão* " + mainNode.getInetAddress().getHostName() +
                        "@" + mainNode.getInetAddress().getHostAddress() + ":" + mainNode.getLocalPort() );

                new RedeOverlaySecNode(mainNode).start();       //corre a thread para dar handle ao nó principal
            } catch (IOException e) {
                if (serverSocket.isClosed()){
                    System.out.println("*Servidor Encerrou*");
                } else {
                    e.printStackTrace();
                }
            }
        }
    }

    public String reescreveValor (String[] lista) { // Junta o args dados pelo comando num string, excluindo a chave e a letra do comando
        return String.join(" ", Arrays.copyOfRange(lista, 2, lista.length));
    }

    public void run(){
        try{
            PrintWriter saida = new PrintWriter(mainNode.getOutputStream(), true);
            BufferedReader entrada = new BufferedReader(new InputStreamReader(mainNode.getInputStream()));
            String command = entrada.readLine();
            String[] commandArray = command.split(" ");

            if (commandArray[0].equals("E")){           // se receber o comando E encerra o nó
                saida.println(command);
                serverSocket.close();
            } else {

                switch (commandArray[0]) {
                    case "R" -> {
                        int hashValue = MeuHash.funcHash(commandArray[1], numParticipantes); // calcula o hash para ter a certeza que o par chave,valor está no nó certo
                        saida.println(hashValue);
                        if (hashValue != nodeID){
                            System.out.println("Chave/Valor no nó errado!\nNó: " + nodeID
                                    + " Valor do Hash: " + hashValue);
                        }
                        if (!tabelaDeDispersaoLocal.containsKey(commandArray[1])) {
                            tabelaDeDispersaoLocal.put(commandArray[1], reescreveValor(commandArray));
                            saida.println("Item registado com sucesso.");
                        } else {
                            saida.println("Chave existente.");
                        }
                    }
                    case "C" -> {
                        int hashValue = MeuHash.funcHash(commandArray[1], numParticipantes);
                        saida.println(hashValue);
                        if (hashValue != nodeID){
                            System.out.println("Chave/Valor no nó errado!\nNó: " + nodeID
                                    + " Valor do Hash: " + hashValue);
                        }
                        String valorPedido = tabelaDeDispersaoLocal.get(commandArray[1]);
                        saida.println(Objects.requireNonNullElse(valorPedido, "Chave Inexistente.")); // se valorPedido valer "null" então retorna texto de erro
                    }
                    case "D" -> {
                        int hashValue = MeuHash.funcHash(commandArray[1], numParticipantes);
                        saida.println(hashValue);
                        if (hashValue != nodeID){
                            System.out.println("Chave/Valor no nó errado!\nNó: " + nodeID
                                    + " Valor do Hash: " + hashValue);
                        }
                        if (tabelaDeDispersaoLocal.remove(commandArray[1]) != null) {
                            saida.println("Item removido com sucesso.");
                        } else {
                            saida.println("Chave Inexistente.");
                        }
                    }
                    case "A" -> {               // caso para a adição de nós (muda o valor do numParticipantes)
                        saida.println("A");
                        numParticipantes = Integer.parseInt(commandArray[1]);
                    }
                    case "L" -> {
                        if(!tabelaDeDispersaoLocal.isEmpty()) {
                            tabelaDeDispersaoLocal.forEach((k,v) -> System.out.println(k + " "
                                    + tabelaDeDispersaoLocal.get(k))); //coloca no ecrã todas as chave/valor
                        } else {
                            System.out.println("Sem itens");
                        }
                    }
                }
            }

            saida.close();
            entrada.close();
            mainNode.close();

        } catch (IOException e){
            e.printStackTrace();
        }
    }
}
