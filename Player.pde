

public class Player {
  private float speed, range, len = 1000;
  private int ray_amount = 100, MODE = 1;
  private PVector dir, pos;
  private ArrayList<Ray> rays = new ArrayList<Ray>();
  private boolean up, down, left, right;

  public Player(float x, float y) {
    this.pos = new PVector(x, y);
    this.speed = 5;
    this.range = QUARTER_PI;
    this.dir = PVector.random2D();
    initRays(ray_amount, len);
    //this.ray = new Ray(pos, 100, dir);
  }

  public void renderRays() {
    for (Ray ray : rays) {
      ray.render();
    }
  }

  public void render() {
    move();
    switch(MODE) {
    case 1:
      renderRays();
      break;
    case 2:
      renderShape();
      break;
    default:
      renderRays();
    }
    draw();
  }

  public void renderShape() {
    fill(255, 255, 0);
    beginShape();
    vertex(pos.x, pos.y);
    for (Ray ray : rays) {
      ray.update();
      PVector pt = ray.checkPolys();
      vertex(pt.x, pt.y);
    }
    endShape();
  }

  public void renderVerts() {
    fill(255, 255, 0);
    beginShape();
    for (Ray ray : rays) {
      PVector pt = ray.checkPolys();
      vertex(pt.x, pt.y);
    }
    endShape();
  }

  private void initRays(int amount, float length) {
    float inc = range / amount;
    float start_angle = dir.heading() - range/2;

    for (int i = 0; i<amount; i++) {
      PVector direction = PVector.fromAngle(inc * i + start_angle);
      rays.add(new Ray(this.pos, length, direction));
    }
  }

  private void setRayAmount(int amount) {
    ray_amount = amount;
    rays.clear();
    initRays(ray_amount, len);
  }

  private void setMODE(int MODE) {
    switch(MODE) {
    case 1:
      ray_amount = 100;
      break;
    case 2:
      ray_amount = 2000;
      break;
    } 
    this.MODE = MODE;
    rays.clear();
    initRays(ray_amount, len);
  }

  private void move() {
    if (up)
      pos.y -= speed;
    if (down)
      pos.y += speed;
    if (left)
      pos.x -= speed;
    if (right)
      pos.x += speed;
  }

  public void rotate(float rad) {
    dir.rotate(rad);
    if (range < TWO_PI) {
      for (Ray r : rays)
        r.rotate(rad);
    }
  }

  private void draw() {
    fill(255);
    noStroke();
    ellipse(pos.x, pos.y, 20, 20);
  }

  public void setPos(float x, float y) {
    pos.set(x, y);
  }

  public PVector getPos() {
    return pos;
  }

  public void setDir(float x, float y) {
    dir.set(x, y);
    if (range < TWO_PI) {
      rays.clear();
      initRays(ray_amount, len);
    }
  }

  public PVector getDir() {
    return dir;
  }

  public void up(boolean state) {
    up = state;
  }

  public void down(boolean state) {
    down = state;
  }

  public void left(boolean state) {
    left = state;
  }

  public void right(boolean state) {
    right = state;
  }
  
  public void changeRange(int amount) {
    range += radians(amount);
    rays.clear();
    initRays(ray_amount, len);
  }
}
