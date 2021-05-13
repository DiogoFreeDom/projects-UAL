package pt.ual.sdp.app.models;

import java.sql.*;
import java.util.*;
import java.util.function.Consumer;

public class PostgreInteraction {

    public static String url = "jdbc:postgresql://DBpostgres:5432/SDP";
    public static Connection connection = null;
    private final static String user = "postgres";
    private final static String password = "postgres";

    //faz uma ligação à BD
    public static void connectDB(){
        try {
            connection = DriverManager.getConnection(url, user, password);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
            System.out.println("Falha de connecção à bd");
        }
    }

    //fecha a ligação à BD
    public static void disconnectDB(){
        try {
            connection.close();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
            System.out.println("Falha de encerramento da conecção");
        }
    }

    //retorna o id que corresponde ao nome passado por parâmetro
    public static int queryItemsID(String itemNome) throws SQLException {
        connectDB();
        Statement statement = connection.createStatement();
        ResultSet result = statement.executeQuery("select id from items where nome = '%s'".formatted(itemNome));
        int id;
        if (result.next()){
            id = result.getInt(1);
        } else {
            throw new SQLException();
        }
        disconnectDB();
        return id;
    }

    //retorna o nome que corresponde ao id passado por parâmetro
    public static String queryItemsNome (int id) throws SQLException {
        String nome;
        connectDB();
        Statement statement = connection.createStatement();
        ResultSet result = statement.executeQuery("select nome from items where id = %d".formatted(id));
        if (result.next()){
            nome = result.getString(1);
        } else {
            throw new SQLException();
        }
        disconnectDB();
        return nome;

    }

    public static List<List<String>> consultaItems(){
        List<List<String>> consulta = new ArrayList<>();
        connectDB();
        try {
            Statement statement = connection.createStatement();
            ResultSet result = statement.executeQuery("select * from items");
            while (result.next()){
                consulta.add(Arrays.asList(result.getString(2),
                        result.getString(3), result.getString(4)));
            }

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return consulta;
    }

    public static List<List<String>> consultaItemsStock(){
        List<List<String>> consulta = new ArrayList<>();
        connectDB();
        try {
            Statement statement = connection.createStatement();
            ResultSet result = statement.executeQuery("select * from items where quantidade > 0");
            while (result.next()) {
                consulta.add(Arrays.asList(result.getString(2),
                        result.getString(3), result.getString(4)));
            }

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }

        return consulta;
    }

    //cria um item na base de dados, descricao pode ser omitida
    public static String criaItem (String nome, String descricao){
        connectDB();
        try {
            Statement statement = connection.createStatement();
            descricao = descricao.replace("'", "''");
            statement.execute("insert into items (nome, quantidade, descricao) values ('%s', 0, '%s')".formatted(nome, descricao));
        } catch (SQLException throwables) {
            return throwables.getMessage();
        }
        disconnectDB();
        return "Item criado com sucesso.";
    }

    //atualiza a desdcrição de um item
    public static String atualizaDescricaoItem (String nome, String descricao){
        connectDB();
        try {
            Statement statement = connection.createStatement();
            int id = queryItemsID(nome);
            statement.executeUpdate("update items set descricao = '%s' where id = %d".formatted(descricao, id));
        } catch (SQLException throwables) {
            return "Item inexistente";
        }
        disconnectDB();
        return "Descrição atualizada";
    }


    public static String eliminaItem (String itemNome) {

        try {
            int id = queryItemsID(itemNome);
            connectDB();
            Statement statement = connection.createStatement();
            ResultSet result = statement.executeQuery("select * from Entrega_Items join Depositos" +
                    " on Entrega_Items.id_item = Depositos.id_item" +
                    " where entrega_items.id_item = " + id);
            if (result.next()){
                return "Item não foi eliminado porque tem um depósito/entrega";
            } else {
                statement.execute("delete from items where id = " + id);
            }

        } catch (SQLException throwables) {
            return "Item não foi eliminado, item inexistente.";
        }
        disconnectDB();

        return "Item eliminado com sucesso.";
    }

    //cria um depósito, quantidade tem de ser maior que 0
    public static String criaDeposito (String nome, int quantidade){
        if (quantidade <= 0) {
            return "Depósito não foi criado, quantidade deve ser superior a zero";
        }
        try {
            int id = queryItemsID(nome);
            connectDB();
            Statement statement = connection.createStatement();
            statement.execute("insert into depositos (quantidade, id_item) values (%d, %d)".formatted(quantidade, id));
            statement.execute("update items set quantidade = quantidade + %d where id = %d".formatted(quantidade, id));
        } catch (SQLException throwables) {
            return "Depósito não foi criado, não existe tal nome.";
        }
        disconnectDB();

        return "Deposito criado com sucesso.";
    }

    //cria uma entrega, o parâmetro deve ser um mapa com chave nome do item e valor quantidade desse item
    public static String criaEntrega (Map<String,Integer> entrega, String local){
        connectDB();
        Statement statement;
        StringBuilder nomesBuilder = new StringBuilder();
        for(String entrada : entrega.keySet()){
            nomesBuilder.append("'%s', ".formatted(entrada));
        }
        String nomes = nomesBuilder.toString().trim();
        String nomesSub = nomes.substring(0, nomes.length() - 1);

        try {
            statement = connection.createStatement();
            Map<Integer, Integer> items = new HashMap<>();
            ResultSet result = statement.executeQuery("select id, nome, quantidade from items where nome in (%s)".formatted(nomesSub));
            int rowcount = 0;
            while (result.next()){

                String nome = result.getString(2);
                if (entrega.get(nome) < result.getInt(3)){
                    items.put(result.getInt(1), entrega.get(nome));
                } else {
                    return "Stock do item %s não é suficiente para esta entrega".formatted(nome);
                }
                rowcount++;
            }
            if (rowcount < entrega.size()){
                return "Algum dos items não existe";
            }
            statement.execute("insert into entregas (local_entrega) values ('%s') returning id".formatted(local), Statement.RETURN_GENERATED_KEYS);
            result = statement.getGeneratedKeys();
            result.next();
            String id_entrega = result.getString(1);
            disconnectDB();
            for (Map.Entry<Integer, Integer> item : items.entrySet()){
                connectDB();
                statement = connection.createStatement();
                statement.execute("insert into entrega_items values (%s, %d, %d)".formatted(id_entrega, item.getKey(), item.getValue()));
                statement.execute("update items set quantidade = quantidade - %d where id = %d".formatted(item.getValue(), item.getKey()));
                disconnectDB();
            }
        } catch (SQLException throwables) {
            return throwables.getMessage();
        }

        disconnectDB();

        return "Entrega criada com sucesso.";
    }

    // devolve a lista de entregas como uma classe que tem um id, uma quantidade e um mapa <String, Integer>
    public static List<DataEntrega> consultaEntregas(){
        List<DataEntrega> consulta = new ArrayList<>();
        connectDB();
        try {
            Statement statement = connection.createStatement();
            ResultSet result = statement.executeQuery("select * from entregas");
            while(result.next()){
                int id_entrega = result.getInt(1);
                String local = result.getString(2);
                ResultSet subresult = statement.executeQuery("select id_item, quantidade from entrega_items where id_entrega = %d".formatted(id_entrega));
                Map<String, Integer> itemList = new HashMap<>();
                while (subresult.next()){
                    String nomeItem = queryItemsNome(subresult.getInt(1));
                    int quantidade = subresult.getInt(2);
                    itemList.put(nomeItem, quantidade);
                }
                consulta.add(new DataEntrega(id_entrega, local, itemList));

            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        disconnectDB();
        return consulta;
    }

    // atualiza o local duma entrega
    public static String atualizaLocalEntrega(int id, String local) {
        connectDB();
        try {
            Statement statement = connection.createStatement();
            int result = statement.executeUpdate("update entregas set local_entrega = '%s' where id = %d".formatted(local, id));
            if (result < 1){
                return "Sem atualização, entrega inexistente";
            }
        } catch (SQLException throwables) {
            return throwables.getSQLState();
        }
        disconnectDB();
        return "Local atualizado";
    }
}
