// COMPILE-CMD: javac {file}
// RUN-CMD: java -ea {file}
import org.graalvm.polyglot.*;

public class function_js {
    public static void main(String[] args) {
// BEGIN-SNIPPET
try (Context context = Context.create()) {
    Value function = context.eval("js", "x => x+1");
    assert function.canExecute();
    int x = function.execute(41).asInt();
    assert x == 42;
}
// END-SNIPPET
    }
}
