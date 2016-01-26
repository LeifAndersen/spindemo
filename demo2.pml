byte state = 1;

active proctype runner () {
  if :: skip -> state = state + 1
     :: skip -> state = state + 2
  fi
}

active proctype monitor() {
  printf("s = %d\n", state)
}
