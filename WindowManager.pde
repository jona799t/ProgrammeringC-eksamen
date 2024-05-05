import java.util.Map;

class WindowManager {
  HashMap<String, Window> windows;
  Window currentWindow = null;

  WindowManager() {
    windows = new HashMap<String, Window>();
  }

  void addWindow(String name, Window window) {
    windows.put(name, window);
  }

  void changeWindow(String name) {
    currentWindow = windows.get(name);
  }

  void draw() {
    currentWindow.draw();
  }

  void mousePressed() {
    currentWindow.mousePressed();
  };

  void mouseDragged() {
    currentWindow.mouseDragged();
  };

  void mouseReleased() {
    currentWindow.mouseReleased();
  };

  void knapKlikket(String knapId) {
    currentWindow.knapKlikket(knapId);
  }
}
