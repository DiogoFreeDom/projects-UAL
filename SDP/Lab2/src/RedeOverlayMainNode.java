import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.ArrayList;


public class RedeOverlayMainNode extends Thread {

    private static final ArrayList<String> listaDeNos = new ArrayList<>(); // registo de ip:porta de cada participante
    private static int numParticipantes = 0;    // registo do número de nós participantes da rede
    private final Socket cliente;
    private static final int clientPort = 4242;     // port usado para recessão de clientes
    private static final int nodeEntryPort = 4343;  // port usado para recessão de participantes


    public static void main(String[] args) {
        new MainNodeClientThread(clientPort).start();
        new MainNodeSecNodeThread(nodeEntryPort).start();
    }

    public RedeOverlayMainNode(Socket cliente) { this.cliente = cliente; }

    public void run(){
            Socket socketDoMain;
            PrintWriter saidaParticipante;
            BufferedReader entradaParticipante;
            PrintWriter saidaCliente;
            BufferedReader entradaCliente;

            try {
                saidaCliente = new PrintWriter(cliente.getOutputStream(), true);
                entradaCliente = new BufferedReader(new InputStreamReader(cliente.getInputStream()));

                String command = entradaCliente.readLine();
                String[] commandArray = command.split(" ");
                saidaCliente.println(commandArray[0]);              // envia ao cliente um ack que representa o comando recebido

                switch (commandArray[0]) {
                    case "R", "C", "D" -> {

                        if (commandArray.length < 2){                   // se o comando tiver menos de dois campos então considera-se incompleto
                            saidaCliente.println("Ocorreu um erro");
                            break;
                        }

                        int keyHashValue = MeuHash.funcHash(commandArray[1], numParticipantes); // calcula o hash da chave

                        String[] ip_port = listaDeNos.get(keyHashValue).split(":");     // obtem o ip : porta 

                        socketDoMain = new Socket(ip_port[0], Integer.parseInt(ip_port[1]));            // conecta ao nó participante consoante o valor do hash
                        saidaParticipante = new PrintWriter(socketDoMain.getOutputStream(), true);
                        entradaParticipante = new BufferedReader(new InputStreamReader(socketDoMain.getInputStream()));

                        saidaParticipante.println(command);

                        if (!entradaParticipante.readLine().equals(String.valueOf(keyHashValue))){  // se o valor do hash retornado pelo participante for diferente então ocorreu um erro
                            saidaCliente.println("Ocorreu um erro");
                            break;
                        }

                        command = entradaParticipante.readLine();
                        saidaCliente.println(command);

                        entradaParticipante.close();
                        saidaParticipante.close();
                        socketDoMain.close();
                    }

                    case "E" -> {
                        for(String address : listaDeNos){               // dá indicação a todos os nós da rede para encerrar
                            String[] ip_port = address.split(":");

                            socketDoMain = new Socket(ip_port[0], Integer.parseInt(ip_port[1]));
                            saidaParticipante = new PrintWriter(socketDoMain.getOutputStream(), true);
                            entradaParticipante = new BufferedReader(new InputStreamReader(socketDoMain.getInputStream()));

                            saidaParticipante.println(commandArray[0]);

                            if (!entradaParticipante.readLine().equals(commandArray[0])){   // avisa caso não haja recessão do ack
                                saidaCliente.println("Um dos participantes não encerrou");
                            }

                            entradaParticipante.close();
                            saidaParticipante.close();
                            socketDoMain.close();
                        }
                        // encerra os serversockets do nó principal
                        MainNodeClientThread.closeServerSocketCliente();
                        MainNodeSecNodeThread.closeServerSocketSecNode();
                    }

                    case "L" -> {
                        for (String address : listaDeNos){      // dá indicação a todos os nós da rede para colocarem o seu conteúdo na command line
                            String[] ip_port = address.split(":");

                            socketDoMain = new Socket(ip_port[0], Integer.parseInt(ip_port[1]));
                            saidaParticipante = new PrintWriter(socketDoMain.getOutputStream(), true);
                            entradaParticipante = new BufferedReader(new InputStreamReader(socketDoMain.getInputStream()));

                            saidaParticipante.println(commandArray[0]);

                            entradaParticipante.close();
                            saidaParticipante.close();
                            socketDoMain.close();
                        }
                    }

                    default -> saidaCliente.println("Este comando não é reconhecido.");
                }

                saidaCliente.println(command);

                cliente.close();
                saidaCliente.close();
                entradaCliente.close();
            } catch (IOException e){
                e.printStackTrace();
            }
    }

    // work in progress
    public static int adicionarSecNode(String ip, String port){

        listaDeNos.add(ip + ":" + port); // adiciona o ip e porta (concatenados com ":") ao array da rede
        numParticipantes++;               // incrementa o contador de nós da rede (utilizado para  o cálculo do hash)

        try {
            for (int i = 0; i < listaDeNos.size()-1; i++) { // avisa todos os nós da adição dum novo nó
                String[] ip_port = listaDeNos.get(i).split(":");
                Socket socketDoMain = new Socket(ip_port[0], Integer.parseInt(ip_port[1]));
                PrintWriter saidaParticipante = new PrintWriter(socketDoMain.getOutputStream(), true);
                BufferedReader entradaParticipante = new BufferedReader(new InputStreamReader(socketDoMain.getInputStream()));

                saidaParticipante.println("A " + numParticipantes); // avisa a alteração na rede e indica o novo total de nós

                if (!entradaParticipante.readLine().equals("A")){
                    System.out.println("Um dos participantes não recebeu alteração na topologia.");
                }

                entradaParticipante.close();
                saidaParticipante.close();
                socketDoMain.close();
            }
        } catch (IOException e){
            e.printStackTrace();
        }

        return numParticipantes; // retorna o novo total de nós na rede

    }
}

