package pt.ual.sdp.app.views;

import pt.ual.sdp.app.models.PostgreInteraction;

import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonObjectBuilder;
import javax.json.JsonWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/Depositos")
public class DepositosAPI extends HttpServlet {

    @Override     //recebe json,  {"nome": "nome do item a adicionar", "quantidade": quantidade a adicionar}
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        JsonObject json = Json.createReader(req.getReader()).readObject();
        String nome = json.getString("nome");
        int quantidade = json.getInt("quantidade");
        String respPostgres = PostgreInteraction.criaDeposito(nome, quantidade);
        JsonObjectBuilder jsonBuilder = Json.createObjectBuilder();
        jsonBuilder.add("msg", respPostgres);
        resp.setContentType("application/json");
        JsonWriter respJsonWriter = Json.createWriter(resp.getWriter());
        respJsonWriter.writeObject(jsonBuilder.build());
        respJsonWriter.close();
    }
}
