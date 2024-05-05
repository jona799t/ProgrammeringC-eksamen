class WindowNavigation extends Window {
  Knapper knapper;

  Scroller scroller;

  String status = "Sidst trykket:";
  String trykket = "Intet";

  Vej vej;

  int fra = -1;
  int til = -1;

  String sidstKlikket;

  Knap fraKnap;
  Knap tilKnap;

  WindowNavigation() {
    knapper = new Knapper();
    knapper.add(new Knap("fra", "Fra", margin/2, margin/2, width-margin, h, color(223, 67, 37), color(255), 104));
    knapper.add(new Knap("til", "Til", margin/2, height-h-margin/2, width-margin, h, color(105, 178, 76), color(255), 104));
    fraKnap = knapper.knapper.get("fra");
    tilKnap = knapper.knapper.get("til");

    scroller = new Scroller(h+margin, height-(h+margin));
  }

  void draw() {
    background(255);

    push();
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(54);
    if (fra == -1) {
      text("Vælg lokalet du starter ved", width/2, height/2);
    } else if (til == -1) {
      text("Vælg lokalet du skal til", width/2, height/2);
    } else {
      scroller.draw();
      fill(255);
      noStroke();
      rect(0, 0, width, h+margin, 0); // Så scrolleren ikke er i baggrunden
      rect(0, height-(h+margin), width, h+margin, 0); // Så scrolleren ikke er i baggrunden
    }
    pop();
    knapper.draw();
  }

  void knapKlikket(String knapId) {
    switch (knapId) {
    case "fra":
      fra = -1;
      scroller.y = scroller.yMin;
      sidstKlikket = "fra";
      windowManager.changeWindow("select");
      break;
    case "til":
      til = -1;
      scroller.y = scroller.yMin;
      sidstKlikket = "til";
      windowManager.changeWindow("select");
      break;
    default:
      if (sidstKlikket == "fra") {
        fra = int(knapId);
        fraKnap.text = lokaler.getString(fra);
        fraKnap.fontSize = 52;
      } else if (sidstKlikket == "til") {
        til = int(knapId);
        tilKnap.text = lokaler.getString(til);
        tilKnap.fontSize = 52;
      }
      sidstKlikket = "lokale";

      if (fra != -1 && til != -1) updateNavigation();

      break;
    }
  }

  void updateNavigation() {
    vej = findVej(fra, til);

    scroller.reset();
    for (int i = 1; i < vej.vej.length-1; i++) {
      scroller.add(new Knap(str(i), lokaler.getString(vej.vej[i]), margin/2, (h+margin/2)*(i-1), width-margin, h, color(255, 242, 45), color(255), 52));
    }
  }

  // Inspireret af CSES-bogen
  Vej findVej(int fra, int til) {
    boolean[] processed = new boolean[antalKnuder];
    int[] distance = new int[antalKnuder];
    for (int i = 0; i < antalKnuder; i++) {
      distance[i] = Integer.MAX_VALUE; // Højt tal som altid vil være større end alle mulige korteste veje.
    }

    distance[fra] = 0;

    int[][] vej = new int[antalKnuder][];
    vej[fra] = new int[1];
    vej[fra][0] = fra;

    HeapQ q = new HeapQ();
    int[] start = {0, fra};
    q.add(start);

    while (q.queue.size() > 0) {
      int[] da = q.pop();
      if (processed[da[1]]) {
        continue;
      }
      processed[da[1]] = true;

      for (int i = 0; i < kanter.getJSONArray(da[1]).size(); i++) {
        JSONArray bw = kanter.getJSONArray(da[1]).getJSONArray(i);
        if (distance[da[1]] + bw.getInt(1) < distance[bw.getInt(0)]) {
          distance[bw.getInt(0)] = distance[da[1]] + bw.getInt(1);
          vej[bw.getInt(0)] = append(vej[da[1]], bw.getInt(0));
          int[] next = {distance[bw.getInt(0)], bw.getInt(0)};
          q.add(next);
        }
      }
    }

    return new Vej(distance[til], vej[til]);
  }

  void mousePressed() {
    knapper.mousePressed();
    scroller.mousePressed();
  }

  void mouseDragged() {
    scroller.mouseDragged();
  }

  void mouseReleased() {
    knapper.mouseReleased();
    scroller.mouseReleased();
  }
}

class Vej {
  int tid;
  int[] vej;

  Vej(int tid, int[] vej) {
    this.tid = tid;
    this.vej = vej;
  }
}
