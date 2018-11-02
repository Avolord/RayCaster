public class Box extends Polygon {
  private float x,y,w,h;
  
  public Box(float x, float y, float w, float h) {
    super(4);
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    initWalls();
    for(int[] i : edges)
      printArray(i);
  }
  
  private void initWalls() {
    verts[0] = new PVector(x, y);
    verts[1] = new PVector(x+w, y);
    verts[2] = new PVector(x+w, y+h);
    verts[3] = new PVector(x, y+h);
  }
}
