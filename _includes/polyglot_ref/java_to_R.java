// BEGIN-SNIPPET
import org.graalvm.polyglot.*;

class Polyglot {
    public static void main(String[] args) {
        Context polyglot = Context.newBuilder().
    	    		               allowAllAccess(true).build();
        Value array = polyglot.eval("R", "c(1,2,42,4)");
        int result = array.getArrayElement(2).asInt();
        System.out.println(result);
    }
}
// END-SNIPPET
