public class PBvh
{
  public BvhParser parser;  

  public PBvh(String[] data)
  {
    parser = new BvhParser();
    parser.init();
    parser.parse( data );
  }
  
  public void update( int ms )
  {
    parser.moveMsTo( ms );//30-sec loop 
    parser.update();
  }
  
  public void draw(float r)
  {
    fill(color(255));
    
    for( BvhBone b : parser.getBones())
    {
      pushMatrix();
      translate(b.absPos.x, b.absPos.y, b.absPos.z);
      ellipse(0, 0, 2+r, 2+r);
      popMatrix();
      if (!b.hasChildren())
      {
        pushMatrix();
        fill(255,255-r*r*4,255-r*r*4);
        translate( b.absEndPos.x, b.absEndPos.y, b.absEndPos.z);
        ellipse(0, 0, 8+r*3, 8+r*3);
        popMatrix();
      }
        
    }
  }
}
