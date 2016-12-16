
/* 2016.12.08 ,
   2016.12.16
*/

class BeamingOt extends Particle {

  float lifeSpan ;
  float r ;
  
  BeamingOt( PVector l , PVector v ) {
    super( l , v );
    
    lifeSpan = 255 ;
    r = 2 ;
  }
  
  void run() {
    super.run();
    lifeSpan -= 2 ;
  }
  
  void display() {

    //ellipse( location.x , location.y , 12 , 12 );    
    float theta = velocity.heading2D() + PI/2 ;
    fill(200);
    stroke(0);
    
    pushMatrix();
    translate( location.x , location.y );
    rotate( theta );
    
    beginShape();
    vertex(  0 , -(r*9) );
    vertex( -r , -(r*4) );
    vertex( -r ,     0  );
    vertex(  r ,     0  );
    vertex(  r , -(r*4) );    
    endShape( CLOSE );
    
    beginShape();    
    vertex( -r , -(r*2) );
    vertex( -(r*2) , 0 );
    vertex( -r ,     0  );
    endShape( CLOSE );

    beginShape();    
    vertex(  r , -(r*2) );
    vertex( r*2 , 0 );
    vertex( r ,     0  );
    endShape( CLOSE );
    
    popMatrix();
  }
  
}
