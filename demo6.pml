int s = 1, t = 1;

proctype Patron(int number) {
  int m;
  d_step {
    m = t;
    t++;
  }
  m == s;
  printf("Patron %d is running\n", number);
  s++
}

active proctype Main() {
  run Patron(1);
  run Patron(2);
  run Patron(3);
  run Patron(4);
}
