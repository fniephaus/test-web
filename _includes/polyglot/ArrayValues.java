Value value = context.eval("[1, 2, 3]");
assert value.hasArrayElements();
int x = value.getArrayElement(0).asInt();
assert x == 1;
