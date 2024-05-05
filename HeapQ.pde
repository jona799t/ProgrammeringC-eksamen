class HeapQ {
  ArrayList<int[]> queue;
  HeapQ() {
    queue = new ArrayList<int[]>();
  }

  void add(int[] item) {
    queue.add(item);

    int i = queue.size()-1;
    while (i > 0) {
      int iParent = floor((i-1)/2);
      int[] parent = queue.get(iParent);
      if (item[0] < parent[0]) { // Hvis det er mindre end den oven over
        queue.set(i, parent);
        i = iParent;
      } else { // Ellers har den fundet sin plads
        queue.set(i, item);
        break;
      }
    }
  }

  int[] pop() {
    // Ombytning og fjernelse af toppen
    int[] top = queue.get(0);
    int[] last = queue.get(queue.size()-1);
    queue.set(0, last);
    queue.remove(last);

    int i = 0;
    int længde = queue.size();

    if (længde > 0) {
      while (i < længde) {
        int iBarnVenstre = 2*i+1;
        int iBarnHøjre = 2*i+2;
        if (iBarnHøjre >= længde || iBarnVenstre >= længde) break;

        int[] barnVenstre = queue.get(iBarnVenstre);
        int[] barnHøjre = queue.get(iBarnHøjre);

        if ((barnVenstre[0] < last[0] && barnHøjre[0] < last[0])) { // Den sidder på sin plads
          break;
        } else if (barnHøjre[0] < barnVenstre[0]) {
          queue.set(i, barnHøjre);
          i = iBarnHøjre;
        } else {
          queue.set(i, barnVenstre);
          i = iBarnVenstre;
        }
      }
      queue.set(i, last);
    }

    return top;
  }
}
