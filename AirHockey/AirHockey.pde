// AirHockey.pde
// Source code is available under the Creative Commons Attribution-ShareAlike License
// cc by Shigeto R. Nishitani, 2015 

int p_x, p_y; // pack x,y
int v_x, v_y; // pack velocity

int w_width=300, w_height=450; // window width,height
int s_y=w_height-10, s_h=5, s_w=20; //stick, y, height, width

void setup() {
  //  size(w_width,w_height);
  size(300, 450); //for JavaScript
  init_pack();
}

void init_pack() {
  p_x=w_width/2;
  p_y=0;
  v_x=(int) random(1, 5);
  //  v_y=(int) random(1,5);
  v_y=5;
}
void draw() {
  boolean b=true;
  if (b) {
    background(100);
  } else {
    fill(128, 0, 0, 10 );
    rect( 0, 0, width, s_y);
    fill(128, 0, 0, 100 );
    rect( 0, s_y, width, height);
  }
  // stick move
  noStroke();
  fill(255);
  rect(mouseX-s_w, s_y, s_w*2, s_h);

  // pack move
  noStroke();
  fill(255);
  int r=10;

  // wall bound
  if (p_x>w_width || p_x<0) {
    v_x = -v_x;
  }
  if (p_y<0) {
    v_y = -v_y;
  }
  // stick bound
  if (p_y<s_y+s_h && p_y>s_y-s_h && 
    p_x>mouseX-s_w && p_x<mouseX+s_w ) {
    v_y = -v_y;
  }
  p_x += v_x;
  p_y += v_y;
  ellipse(p_x, p_y, r, r);

  // out of bounds
  if (p_y>w_height) {
    init_pack();
  }
}