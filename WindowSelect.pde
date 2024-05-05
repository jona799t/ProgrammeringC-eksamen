class WindowSelect extends Window {
  Scroller scroller;

  WindowSelect() {
    scroller = new Scroller(margin/2, height-margin/2);
    for (int i = 0; i < lokaler.size(); i++) {
      scroller.add(new Knap(str(i), lokaler.getString(i), margin/2, (h+margin/2)*i, width-margin, h, color(255, 242, 45), color(255), 52));
    }
  }

  void draw() {
    background(255);
    scroller.draw();
  }

  void mousePressed() {
    scroller.mousePressed();
  }

  void mouseDragged() {
    scroller.mouseDragged();
  }

  void mouseReleased() {
    scroller.mouseReleased();
  }

  void knapKlikket(String knapId) {
    scroller.y = scroller.yMin;
    windowManager.windows.get("navigation").knapKlikket(knapId);
    windowManager.changeWindow("navigation");
  }
}
