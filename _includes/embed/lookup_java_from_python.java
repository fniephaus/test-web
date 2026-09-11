// COMPILE-CMD: javac {file}
// RUN-CMD: java -ea {file}
import org.graalvm.polyglot.Context;

public class lookup_java_from_python {


public static void main(String[] args) {
// BEGIN-SNIPPET
try (Context context = Context.newBuilder()
                           .allowAllAccess(true)
                       .build()) {
    java.math.BigDecimal v = context.eval("python",
            "import java\n" +
            "BigDecimal = java.type('java.math.BigDecimal')\n" + 
            "BigDecimal.valueOf(10).pow(20)")
        .asHostObject();
    assert v.toString().equals("100000000000000000000");
}
// END-SNIPPET
}
}
