public class Ray {
  private PVector dir, start, end;
  private float length;

  public Ray(PVector pos, float length, PVector dir) {
    this.dir = dir;
    this.length = length;
    this.start = pos;
    calcEnd();
  }

  private void calcEnd() {
    end = dir.copy();
    end.setMag(length);
    end.add(start);
  }

  public void update(PVector pos, PVector dir) {
    start = pos;
    this.dir = dir;
    calcEnd();
  }
  
  public void update() {
    calcEnd();
  }
  
  public void rotate(float angle) {
    dir.rotate(angle);
    calcEnd();
  }

  public void render() {
    calcEnd();
    PVector w = checkPolys();
    draw(w);
  }
  
  public PVector checkPolys() {
    PVector result = end;
    for(Polygon p : polygons) {
      PVector pt = p.intersects(start, end);
      result = (start.dist(pt) < start.dist(result)) ? pt : result;
    }
    return result;
  }

  public void draw(PVector end) {
    stroke(255, 255, 0);
    if (end == null) {
      line(start.x, start.y, this.end.x, this.end.y);
    } else {
      line(start.x, start.y, end.x, end.y);
    }
  }
}
