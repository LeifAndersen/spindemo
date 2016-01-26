byte state = 1;

active proctype runner() {
  state++
}

active proctype monitor() {
  printf("s = %d\n", state)
}
