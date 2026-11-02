// COMPILE-CMD: javac {file}
// RUN-CMD: java -ea {file}
import org.graalvm.polyglot.*;

public class function_R {
    public static void main(String[] args) {
// BEGIN-SNIPPET
try (Context context = Context.newBuilder()
                           .allowAllAccess(true)
                       .build()) {
    Value function = context.eval("R", "function(x) x + 1");
    assert function.canExecute();
    int x = function.execute(41).asInt();
    assert x == 42;
}
// END-SNIPPET
    }
}
