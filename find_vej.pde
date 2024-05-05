int h;
int margin = 20;

JSONArray lokaler;
JSONArray kanter;
int antalKnuder;

WindowManager windowManager;

void setup() {
  // Responsive højde
  h = height/10-margin/2;

  // Indlæsning af filer
  lokaler = loadJSONArray("knuder.json");
  kanter = loadJSONArray("kanter.json");
  antalKnuder = kanter.size();

  // WindowManager
  windowManager = new WindowManager();
  windowManager.addWindow("navigation", new WindowNavigation());
  windowManager.addWindow("select", new WindowSelect());
  windowManager.changeWindow("navigation");
}

void draw() {
  windowManager.draw();
}

void mousePressed () {
  windowManager.mousePressed();
}

void mouseDragged () {
  windowManager.mouseDragged();
}

void mouseReleased () {
  windowManager.mouseReleased();
}

void knapKlikket(String knapId) {
  windowManager.knapKlikket(knapId);
}
