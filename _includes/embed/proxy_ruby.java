// COMPILE-CMD: javac {file}
// RUN-CMD: java -ea {file}
import org.graalvm.polyglot.Context;
import org.graalvm.polyglot.Value;
import org.graalvm.polyglot.proxy.ProxyArray;

public class proxy_ruby {

// BEGIN-SNIPPET
static class ComputedArray implements ProxyArray {
    public Object get(long index) {
        return index * 2;
    }
    public void set(long index, Value value) {
        throw new UnsupportedOperationException();
    }
    public long getSize() {
        return Long.MAX_VALUE;
    }
}

public static void main(String[] args) {
    try (Context context = Context.newBuilder()
                               .allowAllAccess(true)
                           .build()) {
        ComputedArray arr = new ComputedArray();
        context.getPolyglotBindings().putMember("arr", arr);
        long result = context.eval("ruby",
               "arr = Polyglot.import('arr') \n" +
               "arr[1] + arr[1000000000]")
           .asLong();
        assert result == 2000000002L;
    }
}
// END-SNIPPET
}
