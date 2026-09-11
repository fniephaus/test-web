public class HelloPolyglot {
    public static void main(String[] args) {
        System.out.println("Hello, Graal VM! " + System.getProperties().get("java.version"));
    }
}
