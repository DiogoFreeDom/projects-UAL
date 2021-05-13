package pt.ual.sdp.app.models;


import java.util.Map;

public class DataEntrega{

    private final int id;
    private final String local;
    private final Map<String,Integer> items;

    public DataEntrega(final int id, final String local, final Map<String,Integer> items) {
        this.id = id;
        this.local = local ;
        this.items = items;
    }

    public int getId(){
        return id;
    }

    public String getLocal(){
        return local;
    }

    public Map<String, Integer> getItems() {
        return items;
    }
}
