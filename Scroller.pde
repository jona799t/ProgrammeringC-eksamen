class Scroller {
  int forrigeMouseY = -1;

  int y = 0;
  int yMin, yMax;

  int yStart;

  int scrollMin;
  int scrollMax = Integer.MAX_VALUE;

  Knapper scrollKnapper;
  Knap klikketKnap;

  Scroller(int yMin, int yMax) {
    this.yMin = yMin;
    this.yMax = yMax;
    y = yMin;
    scrollMin = yMin;

    scrollKnapper = new Knapper();
  }

  void draw() {
    push();
    translate(0, y);
    scrollKnapper.draw();
    pop();
  }

  void add(Knap knap) {
    int yEnd = -(knap.y+knap.h+margin-yMax-yMin);
    if (yEnd < scrollMax) scrollMax = yEnd;
    scrollKnapper.add(knap);
  }

  void reset() {
    scrollKnapper.reset();
    scrollMax = Integer.MAX_VALUE;
  }

  void mouseDragged() {
    int Δy = mouseY-forrigeMouseY;
    if (yMin <= mouseY && mouseY <= yMax && scrollMax <= y+Δy && y+Δy <= scrollMin && forrigeMouseY != -1) y += Δy; // Når man har scrollet ned er y meget negativ. Derfor skal scrollMin og scrollMax ikke tænkes som det laveste tal (da max er den laveste af de to), men som den længste distance man må scrolle.
    forrigeMouseY = mouseY;
  }

  void mousePressed() {
    yStart = mouseY;
    if (yMin <= mouseY && mouseY <= yMax) {
      float klikket = (mouseY-y)/(h+margin/2);
      if (klikket < scrollKnapper.knapper.size()) {
        klikketKnap = scrollKnapper.knapper.get(scrollKnapper.knapper.keySet().toArray()[int(klikket)]); // .values() virker ikke da den ikke returnerer Collection som ikke har index
        klikketKnap.klikket = true;
      }
    }
  }

  void mouseReleased() {
    forrigeMouseY = -1;
    if (klikketKnap != null) {
      if (abs(yStart-mouseY) <= 5) { // Hvis der er blevet scrollet mindre end 5 px
        knapKlikket(klikketKnap.id);
      }
      klikketKnap.klikket = false;
      klikketKnap = null;
    }
  }
}
