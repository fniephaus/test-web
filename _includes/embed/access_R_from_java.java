// COMPILE-CMD: javac {file}
// RUN-CMD: java -ea {file}
import org.graalvm.polyglot.*;

public class access_R_from_java {
    public static void main(String[] args) {
// BEGIN-SNIPPET
try (Context context = Context.newBuilder()
                           .allowAllAccess(true)
                       .build()) {
    Value result = context.eval("R", 
                    "list("                +
                        "id   = 42, "      +
                        "text = '42', "    +
                        "arr  = c(1,42,3)" +
                    ")");
    assert result.hasMembers();
    
    int id = result.getMember("id").asInt();
    assert id == 42;
    
    String text = result.getMember("text").asString();
    assert text.equals("42");
    
    Value array = result.getMember("arr");
    assert array.hasArrayElements();
    assert array.getArraySize() == 3;
    assert array.getArrayElement(1).asInt() == 42;
}
// END-SNIPPET
    }
}
