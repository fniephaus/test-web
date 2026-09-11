Value value = context.eval("js", "{x: 1, y: 2}");
assert value.hasMember("x");
int x = value.getMember("x").asInt();
assert x == 1;
