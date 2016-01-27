mtype = {RED, YELLOW, GREEN};

chan ch[2] = [1] of {mtype};
chan ack[2] = [1] of {mtype};

byte lights[2];

inline switchlights(toG, toGack, toGid, toR, toRack, toRid) {
  toR ! RED;
  atomic {
    toRack ? RED;
    lights[toRid] = RED;
  };
  toG ! GREEN;
  atomic {
    toGack ? GREEN;
    lights[toGid] = GREEN;
  };
}

inline toYellow(toY, toYack, toYid) {
  toY ! YELLOW;
  atomic {
    toYack ? YELLOW;
    lights[toYid] = YELLOW;
  };
}

active proctype Controller() {

  lights[0] = RED;
  lights[1] = RED;

  /* Start Proceses */
  run Light(ch[0], ack[0]);
  run Light(ch[1], ack[1]);

  /* Start Lights */
  ch[0] ! GREEN;
  atomic {
    ack[0] ? GREEN;
    lights[0] = GREEN;
  };

  /* Main Loop */
  do :: skip ->
        toYellow(ch[0], ack[0], 0);
        switchlights(ch[0], ack[0], 0, ch[1], ack[1], 1);
        toYellow(ch[1], ack[1], 1);
        switchlights(ch[1], ack[1], 1, ch[0], ack[0], 0);
  od;
}

proctype Light(chan c, a) {
  byte light = RED;
  do :: c ? RED    -> light = RED;
                      a ! RED
     :: c ? YELLOW -> light = YELLOW;
                      a ! YELLOW
     :: c ? GREEN  -> light = GREEN;
                      a ! GREEN
     :: timeout -> light = RED
  od;
}
