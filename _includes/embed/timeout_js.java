// COMPILE-CMD: javac {file}
// RUN-CMD: java -ea {file}
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.Callable;
import org.graalvm.polyglot.*;

public class timeout_js {

public static void main(String[] args) {
// BEGIN-SNIPPET
try (Context context = Context.create()) {
    context.initialize("js");

    Timer timer = new Timer(true);
    timer.schedule(new TimerTask() {
        @Override
        public void run() {
            context.close(true);
        }
    }, 1000);

    String lessTrustedCode = "while(true);";
    context.eval("js", lessTrustedCode);
    assert false;
} catch (PolyglotException e) {
    assert e.isCancelled();
}
// END-SNIPPET
}

}
