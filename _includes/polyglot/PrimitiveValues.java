Value value = context.eval("js", "42");
int x = value.asInt();
assert x == 42;
