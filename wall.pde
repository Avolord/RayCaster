public static class wall {
  public PVector start, end;

  public static PVector GetIntersect(PVector s1, PVector e1, PVector s2, PVector e2) {
    PVector d1, d2;
    d1 = PVector.sub(e1, s1);
    d2 = PVector.sub(e2, s2);

    float t, s, c = crossP(d1, d2);
    
    if(c == 0) {
      return null;
    }
    
    t = (crossP(s2, d2) - crossP(s1, d2)) / c;
    s = (crossP(s1, d1) - crossP(s2, d1)) / -c;

    return (t <= 1 && t>= 0 && s <= 1 && s>= 0) ? PVector.add(s1, PVector.mult(d1, t)) : null;
  }

  public static boolean intersects(PVector s1, PVector e1, PVector s2, PVector e2) {
    PVector d1, d2;
    d1 = PVector.sub(e1, s1);
    d2 = PVector.sub(e2, s2);

    float t, s, c = crossP(d1, d2);
    
    if(c == 0) {
      return false;
    }
    
    t = (crossP(s2, d2) - crossP(s1, d2)) / c;
    s = (crossP(s1, d1) - crossP(s2, d1)) / -c;

    return (t <= 1 && t>= 0 && s <= 1 && s>= 0);
  }
  
  public static float crossP(PVector a, PVector b) {
    return (a.x * b.y - a.y * b.x);
  }
}
