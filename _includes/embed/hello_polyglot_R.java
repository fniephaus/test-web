// COMPILE-CMD: javac {file}
// RUN-CMD: java {file}
// BEGIN-SNIPPET
import org.graalvm.polyglot.*;
import org.graalvm.polyglot.proxy.*;
// END-SNIPPET

public class hello_polyglot_R {

static
// BEGIN-SNIPPET
public class HelloPolyglot {
    public static void main(String[] args) {
        System.out.println("Hello Java!");
        try (Context context = Context.newBuilder()
                                   .allowAllAccess(true)
                               .build()) {
            context.eval("R", "print('Hello R!');");
        }
    }
}
// END-SNIPPET

    public static void main(String[] args) {
        HelloPolyglot.main(null);
    }
}
