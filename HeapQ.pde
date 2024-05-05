class HeapQ { // min-heap så første indeks altid er det mindste. Kraftigt inspireret af Pythons HeapQ implementation: https://github.com/python/cpython/blob/3.8/Lib/heapq.py
  ArrayList<int[]> queue;
  HeapQ() {
    queue = new ArrayList<int[]>();
  }

  void add(int[] item) {
    queue.add(item);
    shiftdown(0, queue.size()-1);
  }

  int[] pop() {
    int[] last = queue.get(queue.size()-1);
    queue.remove(queue.size()-1);
    if (queue.size() > 0) {
      int[] item = queue.get(0);
      queue.set(0, last);
      shiftup(0);

      return item;
    }
    return last;
  }

  void shiftdown(int startpos, int pos) {
    int[] item = queue.get(pos);

    while (pos > startpos) {
      int parentpos = floor(pos/2);
      int[] parent = queue.get(parentpos);
      if (item[0] < parent[0]) {
        queue.set(pos, parent);
        pos = parentpos;
      } else {
        break;
      }
    }

    queue.set(pos, item);
  }

  void shiftup(int pos) {
    int endpos = queue.size();
    int startpos = pos;
    int[] newitem = queue.get(pos);
    int childpos = pos * 2 + 1;

    while (childpos < endpos) {
      int rightpos = childpos + 1;
      if (rightpos < endpos && queue.get(childpos)[0] > queue.get(rightpos)[0]) {
        childpos = rightpos;
      }
      queue.set(pos, queue.get(childpos));
      pos = childpos;
      childpos = pos * 2 + 1;
    }
    queue.set(pos, newitem);
    shiftdown(startpos, pos);
  }
}
