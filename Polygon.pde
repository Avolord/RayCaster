static ArrayList<Polygon> polygons = new ArrayList<Polygon>();

public class Polygon {
  PVector[] verts;
  int[][] edges;

  public Polygon(PVector[] verts) {
    this.verts = verts;
    initEdges();
    polygons.add(this);
  }

  public Polygon(int amount) {
    verts = new PVector[amount];
    initEdges();
    polygons.add(this);
  }

  public Polygon(float x, float y, float radius, int points) {
    verts = new PVector[points];
    initEdges();
    regularPolygon(x, y, radius, points);
    polygons.add(this);
  }

  private void regularPolygon(float x, float y, float radius, int points) {
    float angle = TWO_PI / points;
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius;
      float sy = y + sin(a) * radius;
      verts[(int) (a/angle)] = new PVector(sx, sy);
    }
  }

  public void initEdges() {
    edges = new int[verts.length][2];
    edges[0] = new int[] {verts.length - 1, 0};
    for (int i = 0; i < verts.length - 1; i++) {
      edges[i+1] = new int[] {i, i+1};
    }
  }

  public void draw_indiv() {
    for (int i=0, am=verts.length-1; i<am; i++) {
      line(verts[i].x, verts[i].y, verts[i+1].x, verts[i+1].y);
    }
    line(verts[0].x, verts[0].y, verts[verts.length-1].x, verts[verts.length-1].y);
  }

  public void draw() {
    fill(0);
    beginShape();
    for (PVector p : verts) {
      vertex(p.x, p.y);
    }
    endShape();
  }

  public void drawEdges() {
    stroke(0);
    noFill();
    beginShape();
    for (PVector p : verts) {
      vertex(p.x, p.y);
    }
    endShape();
  }

  public PVector intersects(PVector start, PVector end) {
    PVector inter = end;
    for (int[] e : edges) {
      PVector pt = wall.GetIntersect(start, end, verts[e[0]], verts[e[1]]);
      if (pt != null && start.dist(pt) < start.dist(inter)) {
        inter = pt;
      }
    }
    return inter;
  }
}

public void renderPolys() {
  for (Polygon p : polygons)
    p.drawEdges();
}
