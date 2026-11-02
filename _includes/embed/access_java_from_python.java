// COMPILE-CMD: javac {file}
// RUN-CMD: java -ea {file}
import java.util.concurrent.Callable;
import org.graalvm.polyglot.*;

public class access_java_from_python {

// BEGIN-SNIPPET
public static class MyClass {
    public int               id    = 42;
    public String            text  = "42";
    public int[]             arr   = new int[]{1, 42, 3};
    public Callable<Integer> ret42 = () -> 42;
}

public static void main(String[] args) {
    try (Context context = Context.newBuilder()
                               .allowAllAccess(true)
                           .build()) {
        context.getPolyglotBindings().putMember("javaObj", new MyClass());
        boolean valid = context.eval("python",
               "import polyglot \n"                            +
               "javaObj =  polyglot.import_value('javaObj')\n" +
               "javaObj.id                   == 42"            +
               " and javaObj.text            == '42'"          +
               " and javaObj.arr[1]          == 42"            +
               " and javaObj.ret42() == 42")
           .asBoolean();
        assert valid == true;
    }
}
// END-SNIPPET
}
