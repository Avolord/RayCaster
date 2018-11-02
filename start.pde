Player p1;
wall w1;
int darkness = 50, MODE = 1;

public void setup() {
  background(255);
  size(500, 500);
  strokeWeight(1);
  p1 = new Player(200, 200);
  println("Move the character using WASD.");
  println("press 1 for 100% darkness.");
  println("press 2 for 0% darkness.");
  println("press 3 for 30% darkness.");
  println("Use the MouseWheel to change the darkness manually.");
  println("RENDER MODES: M = Low Quality | N = High Quality");
}

public void draw() {
  background(darkness);
  p1.render();
  renderPolys();
  PlayerView();
}

public void PlayerView() {
  PVector dir = PVector.sub(new PVector(mouseX, mouseY), p1.getPos());
  dir.normalize();
  p1.setDir(dir.x, dir.y);
}

public void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  darkness-=e;
}

public void keyPressed() {
  switch(key) {
  case 'w':
    p1.up(true);
    break;
  case 'a':
    p1.left(true);
    break;
  case 's':
    p1.down(true);
    break;
  case 'd':
    p1.right(true);
    break;
  case '1':
    darkness = 0;
    break;
  case '2':
    darkness = 255;
    break;
  case '3':
    darkness = 80;
    break;
  case 'm':
    p1.setMODE(1); 
    break;
  case 'n':
    p1.setMODE(2);
    break;
  case '+':
    p1.changeRange(5);
    break;
  case '-':
    p1.changeRange(-5);
    break;
  }
}

public void keyReleased() {
  switch(key) {
  case 'w':
    p1.up(false);
    break;
  case 'a':
    p1.left(false);
    break;
  case 's':
    p1.down(false);
    break;
  case 'd':
    p1.right(false);
    break;
  }
}

public void mouseClicked() {
  //new Box(mouseX, mouseY, random(50, 150), random(50, 150));
  new Polygon(mouseX, mouseY, random(20, 50), (int) random(6, 9));
}
