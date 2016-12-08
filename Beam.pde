
/* 2016.12.08 */

Fighter fighter ;
ArrayList<Particle> objects ; 
ArrayList<BeamingOt> bos ;
PVector mouse ;

void setup() {
  
  size(640 , 360);
  
  mouse = new PVector( mouseX , mouseY ) ;  

  fighter = new Fighter( new PVector(width/2 , height/2) , 
                         new PVector(2 , 2) , 
                         8 , 
                         200 
                       );
  
  objects = new ArrayList<Particle>() ;
  for(int i = 0 ; i < 10 ; i++) {
    objects.add( new Particle() );
  }
  
  bos = new ArrayList<BeamingOt>() ;
  
}

void draw() {
  
  background(200);
  
  fighter.run();


  for(int i = objects.size()-1 ; i >= 0 ; i--) {
    
    Particle pc = objects.get(i);
    
    for(int k = bos.size()-1 ; k >= 0 ; k--) {
      
      BeamingOt bo = bos.get(k) ;
      float dist = PVector.dist( pc.location , bo.location ) ;
      if( dist > 0 && dist <= 10 ) {
        bos.remove(k);
        objects.remove(i);
      }
      
    }
    pc.run() ;
  }
  
  for(int j = bos.size()-1 ; j >= 0 ; j--) {
    bos.get(j).run();
    if( bos.get(j).lifeSpan < 0 ) {
      bos.remove(j);
    }
  }
  
}

void mousePressed() {
  
  PVector mouseLoc = new PVector( mouseX , mouseY ) ; 
  PVector bm = PVector.sub( mouseLoc , fighter.location ) ;
  bm.normalize();
  bm.mult(2);
  
  BeamingOt bo = new BeamingOt( fighter.location , bm ) ;
  bos.add(bo);
}
