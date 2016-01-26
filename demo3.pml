byte n = 0, finish = 0;

active [2] proctype P() {
  byte reg, counter = 0;
  reg = n;
  reg++;
  n = reg;
  finish++
}

active proctype WaitForFinish() {
  finish == 2;
  printf("n = %d\n", n);
}
