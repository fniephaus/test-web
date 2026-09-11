Value function = context.eval("js", "(function(x) { return x + 1 })");
assert function.canExecute();
int x = function.execute(41).asInt();
assert x == 42;
