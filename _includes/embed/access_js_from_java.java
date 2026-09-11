// COMPILE-CMD: javac {file}
// RUN-CMD: java -ea {file}
import org.graalvm.polyglot.*;

public class access_js_from_java {
    public static void main(String[] args) {
// BEGIN-SNIPPET
try (Context context = Context.create()) {
    Value result = context.eval("js", 
                    "({ "                   +
                        "id   : 42, "       +
                        "text : '42', "     +
                        "arr  : [1,42,3] "  +
                    "})");
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
