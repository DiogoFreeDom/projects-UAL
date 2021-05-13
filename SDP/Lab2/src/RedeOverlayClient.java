import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.Scanner;

public class RedeOverlayClient {

    public static void main(String[] args) {

        String mainNodeIP = args[0]; // recebe o ip do main node como argumento

        Scanner inputTeclado = new Scanner(System.in);
        PrintWriter saida;
        BufferedReader entrada;
        Socket socketDoCliente;



        do {
            String command = inputTeclado.nextLine();
            if (command.startsWith("Q")){
                break;
            }

            try {
                socketDoCliente = new Socket(mainNodeIP, 4242);
                saida = new PrintWriter(socketDoCliente.getOutputStream(), true);
                entrada = new BufferedReader(new InputStreamReader(socketDoCliente.getInputStream()));
                System.out.println("Ligação Estabelecida.");
            } catch (IOException e) {
                mensagemErro();
                System.out.println("Servidor não encontrado.");
                continue;
            }

            saida.println(command); // Envia comando

            try {
                command = entrada.readLine();
                switch (command) {  // Recebe Confirmação
                    case "R", "C", "D" -> System.out.println(entrada.readLine()); // Recebe resultado
                    case "E", "L" -> System.out.println("Comando recebido pelo servidor");

                }
            } catch (IOException e){
                mensagemErro();
                System.out.println("Servidor não respondeu");
            }

            try {
                entrada.close();
                saida.close();
                socketDoCliente.close();
            } catch (IOException e) {
                mensagemErro();
                break;
            }
        } while (true);
        inputTeclado.close();
        System.out.println("Cliente encerrado");
    }
    public static void mensagemErro(){
        System.out.println("Ocorreu um erro.");
    }
}
