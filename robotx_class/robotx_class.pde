/* 
original from robots in 'Getting Started with Processing' by Casey Reas and Ben Fry
Source code is available under the Creative Commons Attribution-ShareAlike License
 cc by Shigeto R. Nishitani, 2019
 */
Robot myRobot1;
Robot myRobot2;

void setup() {
    size(720, 480);
    strokeWeight(2);
    ellipseMode(RADIUS);
    myRobot1 = new Robot(120,420,110,140);
    myRobot2 = new Robot(240,470,220,70);
}

void draw() {
    background(0, 0, 255);//d green blue
    myRobot1.easing();
    myRobot1.display();
    myRobot2.display();
}

class Robot {
  int x,y;
  int bodyHeight, neckHeight;
  int radius = 45;

  Robot(int t_x, int t_y, int t_bodyHeight, int t_neckHeight){
    x = t_x;
    y = t_y;
    bodyHeight = t_bodyHeight;
    neckHeight = t_neckHeight;
  }
  
  float easing = 0.02;
  void easing(){
    int targetX = mouseX;
    x += (targetX-x)*easing;
  }
  
  void display(){
    int ny = y - bodyHeight - neckHeight -radius;

    //neck
    stroke(255, 255, 0);
    line(x+2, y-bodyHeight, x+2, ny);//(266, 257, 266, 162);
    line(x+12, y-bodyHeight, x+12, ny);//(276, 257, 276, 162);
    line(x+22, y-bodyHeight, x+22, ny);//(286, 257, 286, 162);

    //antenna
    line(x+12, ny, x-18, ny-43);//276, 155, 246, 112);
    line(x+12, ny, x+42, ny-99);//(276, 155, 306, 56);
    line(x+12, ny, x+78, ny+15);//(286, 155, 342, 170);

    //body
    noStroke();
    fill(255, 255, 0);
    ellipse(x, y-33, 33, 33);//(264, 377, 33, 33);
    fill(0);
    rect(x-45, y-bodyHeight, 90, bodyHeight-33);//(219, 257, 90, 120);
    fill(255, 255, 0);
    rect(x-45, y-bodyHeight+17, 90, 6);

    //head
    fill(0);
    ellipse(x+12, ny, radius, radius);//276, 155, 45, 45);
    fill(255);
    ellipse(x+24, ny-6, 14, 14);
    fill(0);
    ellipse(x+24, ny-6, 3, 3);
    fill(153);
    ellipse(x, ny-8, 5, 5);
    ellipse(x+30, ny-26, 4, 4);
    ellipse(x+41, ny+6, 3, 3);
  }
}
