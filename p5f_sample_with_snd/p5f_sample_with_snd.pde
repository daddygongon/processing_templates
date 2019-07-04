import ddf.minim.*;

Minim minim;
AudioPlayer player;
AudioSample samples;
AudioMetaData meta;

float[] s;
int music_bytes, music_len;
int prev_millis;
int num = 1;
int max = 500;

boolean effect = false;
BvhParser parserA = new BvhParser();
PBvh bvh1, bvh2, bvh3;
PVector[] base;

public void setup()
{
  size( 1280, 720, P3D );    // for effect like ERODE it's too big
//  size(640, 480, P3D);
  background( 0 );
  noStroke();
  frameRate( 30 );

  base = new PVector[max];
  base[0] = new PVector(0, 0);
  for (int i = 1; i< max; i++) {
    base[i] = new PVector(random(600)-300, random(600)-300);
  }
  bvh1 = new PBvh( loadStrings( "aachan.bvh" ) );
  bvh2 = new PBvh( loadStrings( "kashiyuka.bvh" ) );
  bvh3 = new PBvh( loadStrings( "nocchi.bvh" ) );

  minim = new Minim(this);
  player = minim.loadFile("Perfume_globalsite_sound.wav");
  samples = minim.loadSample("Perfume_globalsite_sound.wav");
  s = samples.getChannel(AudioSample.LEFT);  // only use left channel

  meta = player.getMetaData();
  music_len  = meta.length();
  music_bytes= meta.sampleFrameCount();
//  hint(DISABLE_DEPTH_TEST);  // for blur effect 
  player.play();
  prev_millis = millis();
//  player.loop();   // can't use because the length of music is shorter 
                     // than bvhs
}

// get millisecond in audio player's position
int snd_millis() {
  if (player.isPlaying()) { // if music is on, use music pos.
    return player.position();
  } else {                  // if music is done, use sys
    return millis()-prev_millis; 
  }
}

// convert sound level to size of sound marker
float calc_diameter(double pos) {
  float r;
  if (player.isPlaying()) { // if music is on, calc byte position
    int p = (int)(pos*music_bytes/music_len); //from players pos.
    r = s[p]*s[p]*6;  //         s hold samples, so we get power.
  } else r = 2;       // else return default value 2
  return r;
}

// draw ground
public void ground()
{
  for (int i = -900; i < 900; i+=30) {
    for (int j = -900; j < 900; j+=30) {
      line(width/2.0f+i, height/2.0f, -900, width/2.0f+i, height/2.0f, 900);
      line(width/2.0f-900, height/2.0f, j, width/2.0f+900, height/2.0f, j);
    }
  }
}

public void draw()
{ 
  //resetMatrix();     
  //  fill(0, 20); rect(0, 0, width, height);
  if (effect) {
      filter(ERODE);     // effects
  } else {
      background( 50, 50, 70, 20 );
  }
  //camera
  float _cos = cos(millis() / 5000.f);
  float _sin = sin(millis() / 5000.f);
  camera(width/4.f + width/4.f * _cos +200, height/2.0f-100, 
         550 + 150 * _sin,width/2.0f, height/2.0f, -400, 0, 1, 0);
 
  //ground 
  stroke(127, 111, 255);
  ground();
  stroke(255);
  
  for (int i = 0; i< num; i++) {
  pushMatrix();
   translate( width/2+base[i].x, height/2-10, +base[i].y);
   scale(-1, -1, -1);
  //model
   bvh1.update( snd_millis()+i*100 );
   bvh2.update( snd_millis()+i*100 );
   bvh3.update( snd_millis()+i*100 );
 
   float r = calc_diameter(player.position());
   bvh1.draw(r);
   bvh2.draw(r);
   bvh3.draw(r);
  popMatrix();
  }
  
  if (snd_millis()>70500) { // length of bvh
    prev_millis= millis();  //   => end of sequence
    player.rewind();        // repeat from start
    player.play();
  }
}

void keyPressed() {
  if (keyCode == UP) {
    if (max > num) {
        num++;
    }
  } else if (keyCode == DOWN) {
    if (0 < num) {
        num--;
    }
  } else if (keyCode == LEFT) {
      effect = true;
  } else if (keyCode == RIGHT) {
      effect = false;
  }
}