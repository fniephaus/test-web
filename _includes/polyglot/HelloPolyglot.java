import org.graalvm.polyglot.*;

public class HelloPolyglot {
    public static void main(String[] args) {
        Context context = Context.createContext();
        context.eval("js", "print('hello from JS!')");
    }
}
