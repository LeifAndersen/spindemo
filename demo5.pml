int s = 1, t = 1;

active [4] proctype Patron() {
  int m;
  d_step {
    m = t;
    t++;
  }
  m == s;
  printf("Patron %d is running\n", m)
  s++
}
