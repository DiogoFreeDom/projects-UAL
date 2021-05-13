public class MeuHash {

    public static int funcHash(String key, int nodos){
        return Math.abs(key.hashCode()) % nodos;
    }
}
