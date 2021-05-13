package pt.ual.sdp.app.views;

import pt.ual.sdp.app.models.DataEntrega;
import pt.ual.sdp.app.models.PostgreInteraction;

import javax.json.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@WebServlet("/Entregas")
public class EntregasAPI extends HttpServlet {

    @Override   //envia "id entrega" : [ {"nome": "nome do item", "quantidade": quantidade do item} ... ] ... }
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<DataEntrega> consulta = PostgreInteraction.consultaEntregas();
        JsonObjectBuilder jsonBuilder = Json.createObjectBuilder();
        for(DataEntrega entrega : consulta){
            JsonObjectBuilder entradaJson = Json.createObjectBuilder();
            entradaJson.add("local", entrega.getLocal());
            JsonArrayBuilder jsonArray = Json.createArrayBuilder();
            for(Map.Entry<String, Integer> item: entrega.getItems().entrySet()) {
                JsonObjectBuilder jsonItem = Json.createObjectBuilder();
                jsonItem.add("nome", item.getKey());
                jsonItem.add("quantidade", item.getValue());
                jsonArray.add(jsonItem.build());
            }
            entradaJson.add("items", jsonArray.build());
            jsonBuilder.add(String.valueOf(entrega.getId()),entradaJson.build());
        }
        resp.setContentType("application/json");
        JsonWriter respWriter = Json.createWriter(resp.getWriter());
        respWriter.writeObject(jsonBuilder.build());
        respWriter.close();
    }

    @Override       //cria entrega recebendo um json {, "local": "local da entrega", "items": {"nomeItem": quantidade do item em int, ...}}
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Map<String,Integer> entrega = new HashMap<>();
        JsonObject json = Json.createReader(req.getReader()).readObject();
        JsonObject innerJson = json.getJsonObject("items");
        for(Map.Entry<String, JsonValue> par : innerJson.entrySet()){
            entrega.put(par.getKey(), Integer.parseInt(par.getValue().toString()));
        }
        String local = json.getString("local");
        String respPostgres = PostgreInteraction.criaEntrega(entrega, local);
        JsonObjectBuilder jsonBuilder = Json.createObjectBuilder();
        jsonBuilder.add("msg", respPostgres);
        resp.setContentType("application/json");
        JsonWriter respJsonWriter = Json.createWriter(resp.getWriter());
        respJsonWriter.writeObject(jsonBuilder.build());
        respJsonWriter.close();
    }

    @Override       //altera uma entrega recebendo um json {"entrega": num da entrega, "local": "local da entrega"}
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        JsonObject json = Json.createReader(req.getReader()).readObject();
        int entrega = json.getInt("entrega");
        String local = json.getString("local");
        String respPostgres = PostgreInteraction.atualizaLocalEntrega(entrega, local);
        JsonObjectBuilder jsonBuilder = Json.createObjectBuilder();
        jsonBuilder.add("msg", respPostgres);
        resp.setContentType("application/json");
        JsonWriter respJsonWriter = Json.createWriter(resp.getWriter());
        respJsonWriter.writeObject(jsonBuilder.build());
        respJsonWriter.close();
    }
}
