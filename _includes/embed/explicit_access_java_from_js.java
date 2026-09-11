// COMPILE-CMD: javac {file}
// RUN-CMD: java -ea {file}
import org.graalvm.polyglot.Context;
import org.graalvm.polyglot.HostAccess;
import org.graalvm.polyglot.PolyglotException;

public class explicit_access_java_from_js {

static
// BEGIN-SNIPPET
public class Employee {
    private final String name;
    Employee(String name) {this.name = name;}

    @HostAccess.Export
    public String getName() {
        return name;
    }
}
//END-SNIPPET
static
//BEGIN-SNIPPET
public class Services {
    @HostAccess.Export
    public Employee createEmployee(String name) {
        return new Employee(name);
    }
    
    public void exitVM() {
        System.exit(1);
    }
}

public static void main(String[] args) {
    try (Context context = Context.create()) {
        Services services = new Services();
        context.getBindings("js").putMember("services", services);
        String name = context.eval("js",
                "let emp = services.createEmployee('John Doe');" + 
                "emp.getName()").asString();
        assert name.equals("John Doe");
        
        try {
            context.eval("js", "services.exitVM()");
            assert false;
        } catch (PolyglotException e) {
            assert e.getMessage().endsWith(
                    "Unknown identifier: exitVM");
        }
    }
}
// END-SNIPPET
}
