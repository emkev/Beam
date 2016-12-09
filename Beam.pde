
/* 2016.12.08 , 
   2016.12.09
*/

Fighter fighter ; // attacking-ship
ArrayList<Object> objects ; // object-ship
ArrayList<BeamingOt> bos ; // Beaming-ray
ArrayList<BangOt> bns ; // Bang-Fire
ArrayList<PVector> bangCenters ; // Bang-Fire-Center-Point
ArrayList<PVector> bangStarList ; // Bang-Fire
float starAngle ;

void setup() {
  
  size(640 , 360);
  starAngle = PI / 3 ;
    
  fighter = new Fighter( new PVector(width/2 , height/2) , 
                         new PVector(2 , 2) , 
                         8 , 
                         200 
                       );
  
  objects = new ArrayList<Object>() ;
  for(int i = 0 ; i < 10 ; i++) {
    objects.add( new Object() );
  }
  
  bos = new ArrayList<BeamingOt>() ;
  bns = new ArrayList<BangOt>() ;
  bangCenters = new ArrayList<PVector>() ;
  bangStarList = new ArrayList<PVector>() ;
  
  bangStarListProcess() ;
}

void draw() {
  
  background(200);
  
  fighter.run();

  // All object-ships
  for(int i = objects.size()-1 ; i >= 0 ; i--) {
    
    Object oc = objects.get(i);
    
    // All Beaming-rays
    for(int k = bos.size()-1 ; k >= 0 ; k--) {
      
      BeamingOt bo = bos.get(k) ;

      // judge that whether hitting .
      float dist = PVector.dist( oc.location , bo.location ) ;

      /* beaming-ray has hitted a object-ship , remove the beaming point .
         And being ready to remove the object-ship .
      */
      if( dist > 0 && dist <= 10 ) {
        bos.remove(k);
        oc.isBang = true ;
      }
            
    } /*  for(int k = bos.size()-1 ; k >= 0 ; k--)  */

    // if a object has been hitted ...
    if( objects.get(i).isBang == true ) {
      // store the object-ship (has been hitted) location for the central point of Bang .
      bangCenters.add( objects.get(i).location );
      objects.remove(i);
    }
    else {
      oc.run() ;
    }
    
  } /*  for(int i = objects.size()-1 ; i >= 0 ; i--)  */


  // beaming-rays process ...
  for(int j = bos.size()-1 ; j >= 0 ; j--) {
    bos.get(j).run();
    // if beaming-ray-point times out , then it disappears 
    if( bos.get(j).lifeSpan < 0 ) {
      bos.remove(j);
    }
  }
  
  
  /* the Bang central points process ...
     store six bang-fire (from the central point of a Bang) for each Bang .
   */
  for(int m = bangCenters.size()-1 ; m >= 0 ; m--) {
    PVector bcenter = bangCenters.get(m) ;
    
    for(int n = 0 ; n < bangStarList.size() ; n++) {
      BangOt bangOt = new BangOt( bcenter , bangStarList.get(n) ) ;
      bns.add(bangOt);
    }
    
    // After storing Bang-Fire , remove all Bang-Center-Point data .
    // It is necessary .
    bangCenters.remove(m);
  }
  
  
  // Bang-Fire display
  for(int p = bns.size()-1 ; p >= 0 ; p--) {
    
    BangOt bangOt = bns.get(p) ;
    
    if(bangOt.lifeSpan < 0) { 
      bns.remove(p);
    }
    
    bangOt.run();
    
  }
  
}

void mousePressed() {
  
  PVector mouseLoc = new PVector( mouseX , mouseY ) ; 
  PVector bm = PVector.sub( mouseLoc , fighter.location ) ;
  bm.normalize();
  bm.mult(2);
  
  // Fighter Fires !  :)
  BeamingOt bo = new BeamingOt( fighter.location , bm ) ;
  bos.add(bo);
}

void bangStarListProcess() {
  
  PVector BangStar1 = new PVector(0 , -1) ;    
  PVector BangStar2 = new PVector(    BangStar1.mag() * sin(starAngle)   ,
                                   -( BangStar1.mag() * cos(starAngle) )
                                   );
  PVector BangStar6 = new PVector( -( BangStar1.mag() * sin(starAngle) ) ,
                                   -( BangStar1.mag() * cos(starAngle) )    
                                    );
  PVector BangStar4 = new PVector(0 , 1) ;
  PVector BangStar3 = new PVector(    BangStar1.mag() * sin(starAngle)   ,
                                      BangStar1.mag() * cos(starAngle)
                                   );
  PVector BangStar5 = new PVector( -( BangStar1.mag() * sin(starAngle) ) ,
                                      BangStar1.mag() * cos(starAngle)    
                                    );
  bangStarList.add(BangStar1);
  bangStarList.add(BangStar2);
  bangStarList.add(BangStar3);
  bangStarList.add(BangStar4);
  bangStarList.add(BangStar5);
  bangStarList.add(BangStar6);

}
