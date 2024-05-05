import java.util.LinkedHashMap;

class Knapper {
  LinkedHashMap<String, Knap> knapper; // Linked da den ellers ikke gemmer rækkefølgen de bliver indsat
  Knap trykketKnap;

  Knapper() {
    knapper = new LinkedHashMap<String, Knap>();
  }

  void add(Knap knap) {
    knapper.put(knap.id, knap);
  }

  void reset() {
    knapper.clear();
  }

  void draw() {
    for (Knap knap : knapper.values()) {
      knap.draw();
    }
  }

  void mousePressed() {
    trykketKnap = null;
    for (Knap knap : knapper.values()) {
      if (knap.x < mouseX && mouseX < knap.x + knap.w && knap.y < mouseY && mouseY < knap.y + knap.h) {
        knap.klikket = true;
        trykketKnap = knap;
      }
    }
  }

  void mouseReleased() {
    if (trykketKnap != null) {
      if (trykketKnap.x < mouseX && mouseX < trykketKnap.x + trykketKnap.w && trykketKnap.y < mouseY && mouseY < trykketKnap.y + trykketKnap.h) {
        knapKlikket(trykketKnap.id);
      }
      trykketKnap.klikket = false;
    }
  }
}
