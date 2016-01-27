#define ACK 1

mtype = {RED, YELLOW, GREEN};

chan ch[2] = [1] of {mtype};
chan ack[2] = [1] of {bit};

inline switchlights(toG, toGack, toR, toRack) {
  toR ! RED;
  toRack ? ACK;
  toG ! GREEN;
  toGack ? ACK;
}

inline toYellow(toY, toYack) {
  toY ! YELLOW;
  toYack ? ACK;
}

active proctype Controller() {
  /* Start Proceses */
  run Light(ch[0], ack[0]);
  run Light(ch[1], ack[1]);

  /* Start Lights */
  ch[0] ! GREEN;
  ack[0] ? ACK;

  /* Main Loop */
  do :: skip ->
        toYellow(ch[0], ack[0]);
        switchlights(ch[0], ack[0], ch[1], ack[1]);
        toYellow(ch[1], ack[1]);
        switchlights(ch[1], ack[1], ch[0], ack[0]);
  od;
}

proctype Light(chan c, a) {
  byte light = RED;
  do :: c ? RED    -> light = RED;
                      a ! ACK
     :: c ? YELLOW -> light = YELLOW;
                      a ! ACK
     :: c ? GREEN  -> light = GREEN;
                      a ! ACK
     :: timeout -> light = RED
  od;
}
