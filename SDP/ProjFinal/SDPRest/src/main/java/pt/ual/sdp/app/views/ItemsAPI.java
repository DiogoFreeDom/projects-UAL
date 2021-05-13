package pt.ual.sdp.app.views;

import pt.ual.sdp.app.models.PostgreInteraction;

import javax.json.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/Items/*")
public class ItemsAPI extends HttpServlet {


    @Override   //envia um json {"nomedoItem" : {"quantidade": valor, "descricao": "descrição do item"}
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<List<String>> consulta;
        if (req.getPathInfo() == null || req.getPathInfo().equals("/")) {
            consulta = PostgreInteraction.consultaItems();
        } else if (req.getPathInfo().equals("/Stock")) {
            consulta = PostgreInteraction.consultaItemsStock();
        } else {
            super.doGet(req, resp);
            return;
        }

        resp.setContentType("application/json");
        JsonObjectBuilder jsonBuilder = Json.createObjectBuilder();
        // por cada lista da matriz (por cada tuplo da tabela) cria um "nome do item": {"quantidade": "quantidade", "descrição": descrição]
        for (List<String> lista : consulta) {
            JsonObjectBuilder innerJson = Json.createObjectBuilder();
            innerJson.add("quantidade", lista.get(1)).add("descricao", lista.get(2));
            jsonBuilder.add(lista.get(0), innerJson);
        }
        JsonWriter jsonWriter = Json.createWriter(resp.getWriter());
        jsonWriter.writeObject(jsonBuilder.build());
        jsonWriter.close();
    }

    @Override       //cria o item recebendo um json {"nome":"nome do item", "descricao":"descrição do item"}
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        JsonObject json = Json.createReader(req.getReader()).readObject();
        String nome;
        String descricao;
        nome = json.getString("nome");
        descricao = json.getString("descricao");
        String respPostgres = PostgreInteraction.criaItem(nome, descricao);
        JsonWriter respJsonWriter = Json.createWriter(resp.getWriter());
        JsonObjectBuilder jsonObject = Json.createObjectBuilder();
        jsonObject.add("msg", respPostgres);
        respJsonWriter.writeObject(jsonObject.build());
        respJsonWriter.close();
    }

    @Override       //altera o item recebendo um json {"nome": "nome do item", "descricao": "descrição"}
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        JsonWriter respJsonWriter = Json.createWriter(resp.getWriter());
        JsonObject json = Json.createReader(req.getReader()).readObject();
        String nome = json.getString("nome");
        String descricao = json.getString("descricao");
        String respPostgres = PostgreInteraction.atualizaDescricaoItem(nome, descricao);
        JsonObjectBuilder jsonObject = Json.createObjectBuilder();
        jsonObject.add("msg", respPostgres);
        respJsonWriter.writeObject(jsonObject.build());
        respJsonWriter.close();
    }

    @Override       //elimina o item recebendo um json {"nome": "nome do item"}
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        JsonWriter respJsonWriter = Json.createWriter(resp.getWriter());
        JsonObject json = Json.createReader(req.getReader()).readObject();
        String nome = json.getString("nome");
        String respPostgres = PostgreInteraction.eliminaItem(nome);
        JsonObjectBuilder jsonObject = Json.createObjectBuilder();
        jsonObject.add("msg", respPostgres);
        respJsonWriter.writeObject(jsonObject.build());
        respJsonWriter.close();
    }
}

