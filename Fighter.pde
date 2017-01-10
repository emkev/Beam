
/* 2016.12.08 , 
   2017.01.11
*/

class Fighter extends Particle {
 
  float turnStrength ;
  float runStrength ; 
  
  Fighter(PVector l) {
    super(l);
    turnStrength = 3.0 ;
    runStrength = 1.5 ;
    
    bodyColor1 = 204.0 ;
    bodyColor2 = 102.0 ;
    bodyColor3 = 0.0 ;
    
  }
  
  Fighter(PVector l , PVector v , float s , float c) {
    super( l , v , s , c );
    turnStrength = 3.0 ;
    runStrength = 1.5 ;

    bodyColor1 = 204.0 ;
    bodyColor2 = 102.0 ;
    bodyColor3 = 0.0 ;
  }
  
  void display() {
    fill( bodyColor1 , bodyColor2 , bodyColor3 ) ;
    ellipse( location.x , location.y , 20 , 20 );
    ellipse( location.x , location.y ,  8 ,  8 );
    
    // four circles
    ellipse( location.x-8  , location.y , 2 , 2 );
    ellipse( location.x+8 , location.y ,  2 , 2 );
    ellipse( location.x , location.y-8 ,  2 , 2 );
    ellipse( location.x , location.y+8 ,  2 , 2 );
  }
  
  void turnLeft() {

    float theta , alpha ;
    float steerX , steerY ;
    
    PVector steer ;
    PVector vh ;
    
    vh = velocity.get();

    if( vh.x == 0 && vh.y == 0 ) {
      steer = new PVector( -1 , 0 ) ;
    }
    else if( vh.x == 0 && vh.y < 0 ) {  
      steer = new PVector( -1 , 0 ) ;
    }
    else if( vh.x == 0 && vh.y > 0 ) {
      steer = new PVector( 1 , 0 ) ;
    }
    else if( vh.x < 0 && vh.y == 0 ) {
      steer = new PVector( 0 , 1 ) ;
    }
    else if( vh.x > 0 && vh.y == 0 ) {
      steer = new PVector( 0 , -1 ) ;
    }
    
    else if( vh.x < 0 && vh.y < 0 ) {  
      theta = asin( -(vh.y) / vh.mag() );
      alpha = PI/2 - theta ;
      steerX = -( cos(alpha) * vh.mag() ) ;
      steerY =  ( sin(alpha) * vh.mag() ) ;
      steer = new PVector( steerX , steerY ) ;
    }
    else if( vh.x > 0 && vh.y < 0 ) {
      theta = asin( vh.x / vh.mag() );
      alpha = PI/2 - theta ;
      steerX = -( sin(alpha) * vh.mag() ) ;
      steerY = -( cos(alpha) * vh.mag() ) ;
      steer = new PVector( steerX , steerY ) ;
    }
    else if( vh.x > 0 && vh.y > 0 ) {
      theta = asin( vh.y / vh.mag() );
      alpha = PI/2 - theta ;
      steerX =  ( cos(alpha) * vh.mag() ) ;
      steerY = -( sin(alpha) * vh.mag() ) ;
      steer = new PVector( steerX , steerY ) ;
    }
    else if( vh.x < 0 && vh.y > 0 ) {
      theta = asin( -(vh.x) / vh.mag() );
      alpha = PI/2 - theta ;
      steerX = ( sin(alpha) * vh.mag() ) ;
      steerY = ( cos(alpha) * vh.mag() ) ;
      steer = new PVector( steerX , steerY ) ;
    }
    else {
      steer = new PVector( -1 , 0 ) ;
    }
    
    steer.normalize();
    // turning strength
    steer.mult(turnStrength);
    
    applyForce(steer);    
  }

  void turnRight() {
    
    float theta , alpha ;
    float steerX , steerY ;
    
    PVector steer ;
    PVector vh ;
    
    vh = velocity.get();
    
    if( vh.x == 0 && vh.y == 0 ) {
      steer = new PVector( 1 , 0 ) ;
    }
    else if( vh.x == 0 && vh.y < 0 ) {  
      steer = new PVector( 1 , 0 ) ;
    }
    else if( vh.x == 0 && vh.y > 0 ) {
      steer = new PVector( -1 , 0 ) ;
    }
    else if( vh.x < 0 && vh.y == 0 ) {
      steer = new PVector( 0 , -1 ) ;
    }
    else if( vh.x > 0 && vh.y == 0 ) {
      steer = new PVector( 0 , 1 ) ;
    }
    
    else if( vh.x < 0 && vh.y < 0 ) {  
      theta = asin( -(vh.x) / vh.mag() );
      alpha = PI/2 - theta ;
      steerX =  ( sin(alpha) * vh.mag() ) ;
      steerY = -( cos(alpha) * vh.mag() ) ;
      steer = new PVector( steerX , steerY ) ;
    }    
    else if( vh.x > 0 && vh.y < 0 ) {
      theta = asin( (-vh.y) / vh.mag() );
      alpha = PI/2 - theta ;
      steerX = sin(alpha) * vh.mag() ;
      steerY = cos(alpha) * vh.mag() ;
      steer = new PVector( steerX , steerY ) ;
    }    
    else if( vh.x > 0 && vh.y > 0 ) {
      theta = asin( vh.x / vh.mag() );
      alpha = PI/2 - theta ;
      steerX = -( sin(alpha) * vh.mag() ) ;
      steerY = cos(alpha) * vh.mag() ;
      steer = new PVector( steerX , steerY ) ;
    }
    else if( vh.x < 0 && vh.y > 0 ) {
      theta = asin( vh.y / vh.mag() );
      alpha = PI/2 - theta ;
      steerX = -( cos(alpha) * vh.mag() ) ;
      steerY = -( sin(alpha) * vh.mag() ) ;
      steer = new PVector( steerX , steerY ) ;
    }
    else {
      steer = new PVector( 1 , 0 ) ;
    }
    
    steer.normalize();
    // turning strength
    steer.mult(turnStrength);
    
    applyForce(steer);    
  }
 
  // run run run 
  void forwardRun() {
    
    PVector steer ;
    
    PVector vh = velocity.get();
    vh.normalize();
    vh.mult(runStrength);
    
    steer = vh ;
    
    applyForce(steer);
  }

  // slow slow slow  
  void reverseRun() {
    
    PVector steer ;
    PVector vh = velocity.get();

    if( vh.x == 0 && vh.y == 0 ) {
      steer = new PVector( 0 , 0 ) ;
    }
    else if( vh.x == 0 && vh.y < 0 ) {  
      steer = new PVector( 0 , -(vh.y) ) ;
    }
    else if( vh.x == 0 && vh.y > 0 ) {
      steer = new PVector( 0 , -(vh.y) ) ;
    }
    else if( vh.x < 0 && vh.y == 0 ) {
      steer = new PVector( -(vh.x) , 0 ) ;
    }
    else if( vh.x > 0 && vh.y == 0 ) {
      steer = new PVector( -(vh.x) , 0 ) ;
    }
    else {
      steer = new PVector( -(vh.x) , -(vh.y) ) ;
    }
    
    steer.normalize();
    steer.mult(runStrength);
    
    applyForce(steer);
  }
  
}
