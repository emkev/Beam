
/* 2016.12.08 , 
   2016.12.09
*/

Fighter fighter ;
ArrayList<Object> objects ; 
ArrayList<BeamingOt> bos ;
ArrayList<BangOt> bns ;
ArrayList<PVector> bangCenters ;
ArrayList<PVector> bangStarList ;
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

  // 
  for(int i = objects.size()-1 ; i >= 0 ; i--) {
    
    Object oc = objects.get(i);
    
    for(int k = bos.size()-1 ; k >= 0 ; k--) {
      
      // 
      BeamingOt bo = bos.get(k) ;
      float dist = PVector.dist( oc.location , bo.location ) ;

      /* beamingObject has reached a object , remove the beamingObject .
         And be ready to remove the object .
      */
      if( dist > 0 && dist <= 10 ) {
        bos.remove(k);
        oc.isBang = true ;
      }
            
    }

    if( objects.get(i).isBang == true ) {
      // store the object location for the central point of Bang .
      bangCenters.add( objects.get(i).location );
      objects.remove(i);
    }
    else {
      oc.run() ;
    }
    
  }

  // beaming Objects process
  for(int j = bos.size()-1 ; j >= 0 ; j--) {
    bos.get(j).run();
    if( bos.get(j).lifeSpan < 0 ) {
      bos.remove(j);
    }
  }
  
  /* the central point of a Bang .
     store six bang-fire from a central point of Bang .
   */
  for(int m = 0 ; m < bangCenters.size() ; m++) {
    PVector bcenter = bangCenters.get(m) ;
    
    for(int n = 0 ; n < 6 ; n++) {
      BangOt bangOt = new BangOt( bcenter , bangStarList.get(n) ) ;
      bns.add(bangOt);
    }
        
  }
  
  // Bang-Fire display
  for(int p = bns.size()-1 ; p >= 0 ; p--) {
    BangOt bangOt = bns.get(p) ;
    
    if(bangOt.lifeSpan < 0) 
      bns.remove(p);
      
    bangOt.run();
    
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
