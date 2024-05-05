class Knap {
  String id, text;
  int x, y, w, h;
  color bg, fg;
  boolean klikket = false;
  int fontSize;

  Knap(String id, String text, int x, int y, int w, int h, color bg, color fg, int fontSize) {
    this.id = id;
    this.text = text;

    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;

    this.bg = bg;
    this.fg = fg;

    this.fontSize = fontSize;
  }

  void draw() {
    push();

    if (klikket) {
      fill(lerpColor(bg, 0, 0.1));
    } else {
      fill(bg);
    }
    rect(x, y, w, h, 20);

    fill(fg);
    textSize(fontSize);
    textAlign(CENTER, CENTER);
    text(text, x+w/2, y+h/2);

    pop();
  }
}
