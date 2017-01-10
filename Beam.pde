
/* 2016.12.08 
   2016.12.09
   2016.12.16
   2016.12.18
   2016.12.30 , 12.31
   2017.01.02
   2017.01.03
   2017.01.05
   2017.01.07 , 01.08 , 01.10 , 01.11
*/

Fighter fighter ;                 // attacking-ship
ArrayList<Object> objects ;       // object-ship
ArrayList<BeamingOt> bos ;        // Beaming-ray
ArrayList<BangOt> bns ;           // Bang-Fire
ArrayList<PVector> bangCenters ;  // Bang-Fire-Center-Point
ArrayList<PVector> bangStarList ; // Angle-Stars of a Bang-Fire
ArrayList<BigBomb> bigBombList ;
ArrayList <PVector> bombWaveList ;
ArrayList<ObjParents> ParentsList ;

float BeamingOtSpeed ;  // speed of a missile 
float ObjectsNum ;      // object-ship numbers
float BigBombSpeed ;    // speed of Big Bomb
float BigBombBangRadius ;
PVector FighterSpeed ;  // speed of the Fighter
float MutationRate ;
/* testing */
//int tmp_rd1 = -1 , tmp_rd2 = -1 ;

void setup() {
  
  size(1200 , 600);

  BeamingOtSpeed = 6 ;
  ObjectsNum = 10 ;
  BigBombSpeed = 3 ;
  BigBombBangRadius = 300 ;
  FighterSpeed = new PVector(2 , 2) ;
  MutationRate = 0.1 ;
  
  fighter = new Fighter( new PVector(width/2 , height/2) , 
                         FighterSpeed , 
                         8 , 
                         200 
                       );
  
  objects = new ArrayList<Object>() ;
  for(int i = 0 ; i < ObjectsNum ; i++) {
    objects.add( new Object( new DNA() ) );
  }
  
  bos = new ArrayList<BeamingOt>() ;
  bns = new ArrayList<BangOt>() ;
  
  bangCenters = new ArrayList<PVector>() ;
  bangStarList = new ArrayList<PVector>() ;
  bigBombList = new ArrayList<BigBomb>() ;
  bombWaveList = new ArrayList<PVector>() ;
  
  ParentsList = new ArrayList<ObjParents>() ;
  
  bangStarListProcessFor12() ;

}

void draw() {
    
  background(200);
  
  fighter.run();

  // Each object-ship ...
  for(int i = objects.size()-1 ; i >= 0 ; i--) {
    
    Object oc = objects.get(i);
    PVector sum = new PVector(0 , 0);
    int count = 0 ;

    /* when object-ships meet each other . Encounting each other start  */
    for(int r = objects.size()-1 ; r >= 0 ; r--) {
    
      Object ocm_r = objects.get(r);
      
      float dist_qr = PVector.dist( oc.location , ocm_r.location );
      
      if( dist_qr > 0 && dist_qr <= (oc.size/2 + ocm_r.size/2) ) {
        //println("i = " + i + " , r = " + r);
        PVector diff = PVector.sub( oc.location , ocm_r.location ) ;      
        diff.normalize();
        sum.add( diff ) ;  
        count++ ;
        
        /*testing , start*/
        /*  2010.01.10 */
        /*
        if( (i == tmp_rd1 && r == tmp_rd2) || (i == tmp_rd2 && r == tmp_rd1) ) {
        }
        else
        {
          tmp_rd1 = i ;
          tmp_rd2 = r ;
          println("tmp_rd1 = " + tmp_rd1 + " , tmp_rd2 = " + tmp_rd2);
          ObjParents ops = new ObjParents( oc , ocm_r ) ;
          //ParentsList.add( ops ) ;
        }
        */
        /* testing , end */
        
        /* 2017.01.08 , Parents meet , then produce a child by CROSSOVER dna . */
        //DNA newDna = oc.dna.CrossOver( ocm_r.dna ) ;
        /* 2017.01.10 , add Mutation activity */
        //newDna.Mutate( MutationRate ) ;
        //oc_child = new Object( newDna ) ;
        //objects.add( oc_child ) ;
        
      } /*  if( dist_qr > 0 && dist_qr <= 16 )  */
    } /*  for(int r = 0 ; r < objects.size() ; r++)  */

    if( count > 0 ) {
      sum.div( count ) ;
      sum.normalize();
      sum.mult( 0.9 ) ;
      
      PVector steer = PVector.sub( sum , oc.velocity ) ;
      oc.applyForce( steer ) ;
    }
    /* Encounting each other end */
    
    
    // What if current object-ship meet Beaming-rays
    /* current object-ship encounts beams , start . */
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
    /* current object-ship encounts beams , end . */
    
    // if a object-ship has been hitted ... , OR run normally .
    if( objects.get(i).isBang == true ) {
      // store the object-ship (has been hitted) location for the central point of Bang .
      bangCenters.add( objects.get(i).location );
      objects.remove(i);
    }
    else {
      
      /* 2017.01.07 , add Gene-Vector as forces to each Object-ship . */
      oc.applyForce( oc.dna.genes[oc.geneCount] ) ;
      if( oc.geneCount >= oc.dna.geneSum - 1 ) {
        oc.geneCount = 0 ;
      }
      else {
        oc.geneCount++ ;
      }
      
      oc.run() ;
    }
    /* testing , start */
    /*
    if( isCross == true ) {
      oc_child = new Object( newDna ) ;
      objects.add( oc_child ) ;
    }
    */
    /* testing , end */
    
  } /*  for(int i = objects.size()-1 ; i >= 0 ; i--)  */


  /* 2017.01.02 , The Big BOMB ! */
  for(int g = bigBombList.size()-1 ; g >= 0 ; g--) {

    BigBomb bomb = bigBombList.get(g) ;
    bomb.run();
    PVector bbLoc = bomb.location.get() ;
    
    if( bomb.setTimeSpan <= 0 ) {
      /* Object-Ships in ALL RANGE of BOMB , ALL BANG !!! */
      for(int s = objects.size()-1 ; s >= 0 ; s--) {
    
        Object orb = objects.get(s);
    
        // so , must be in the Bang Range
        if( orb.location.x < bomb.location.x + BigBombBangRadius 
         && orb.location.x > bomb.location.x - BigBombBangRadius
         && orb.location.y < bomb.location.y + BigBombBangRadius 
         && orb.location.y > bomb.location.y - BigBombBangRadius )
        {
          bangCenters.add( objects.get(s).location );
          objects.remove(s);
        }
    
      } /*  for(int s = objects.size()-1 ; s >= 0 ; s--)  */
      
      bigBombList.remove(g);
      
      // 2017.01.03 , BANG WAVE !
      for(int t = 0 ; t < 20 ; t++) {
        bombWaveList.add(bbLoc);
      }
      
    } /*  if( bomb.setTimeSpan <= 0 )  */
  } /*  for(int g = bigBombList.size()-1 ; g >= 0 ; g--)  */
  
  // 2017.01.03 , Play a BOMB Bang Wave each frame until none .
  if( bombWaveList.size() > 0 ) {
    int waveCount = bombWaveList.size() ;
    PVector waveLoc = bombWaveList.get(waveCount-1) ;
    fill(200);
    stroke(0);
    ellipse( waveLoc.x , waveLoc.y , 30*(20 - waveCount +1) , 30*(20 - waveCount +1) );
    // Delete one after displaying a circle wave .
    bombWaveList.remove( waveCount-1 );
  }  
  
  // beaming-rays process ...
  for(int j = bos.size()-1 ; j >= 0 ; j--) {
    bos.get(j).run();
    // if beaming-ray-point times out , then it disappears 
    if( bos.get(j).lifeSpan < 0 ) {
      bos.remove(j);
    }
  }
  
  
  /* the Bang central points process ...
     store many bang-fire (from the central point of a Bang) for each Bang .
   */
  for(int m = bangCenters.size()-1 ; m >= 0 ; m--) {
    PVector bcenter = bangCenters.get(m) ;
    
    for(int n = 0 ; n < bangStarList.size() ; n++) {
      BangOt bangOt = new BangOt( bcenter , bangStarList.get(n).get() ) ;
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

  /* testing , start */
  /*  2010.01.10 , object-Children */
  /*
  for(int w = ParentsList.size()-1 ; w >= 0 ; w--) {
    ObjParents objPt = ParentsList.get(w) ;
    Object mo = objPt.Mobj ;
    Object fo = objPt.Fobj ;

    DNA newDna = mo.dna.CrossOver( fo.dna ) ;
    newDna.Mutate( MutationRate ) ;
    Object oc_child = new Object( newDna ) ;
    objects.add( oc_child ) ;
    
    ParentsList.remove(w);
  }
  */
  /* testing, end */
}

// press mouse to fire ! fire ! fire !
void mousePressed() {
  
  PVector mouseLoc = new PVector( mouseX , mouseY ) ; 
  PVector bm = PVector.sub( mouseLoc , fighter.location ) ;
  bm.normalize();
  bm.mult( BeamingOtSpeed );
  
  // Fighter Fires !  :)
  BeamingOt bo = new BeamingOt( fighter.location , bm ) ;
  bos.add(bo);
}

void keyPressed() {

  // press key "o" to add objects-ships
  if( key == 'o' || key == 'O') {
    for(int i = 0 ; i < ObjectsNum ; i++) {
      objects.add( new Object( new DNA() ) );
    }
  }
  else if( key == CODED && keyCode == LEFT ) {
    fighter.turnLeft();
  }
  else if( key == CODED && keyCode == RIGHT ) {
    fighter.turnRight();
  }
  else if( key == CODED && keyCode == UP ) {
    fighter.forwardRun();
  }
  else if( key == CODED && keyCode == DOWN ) {
    fighter.reverseRun();
  }  
  else if( key == 'c' || key == 'C' ) {
    FireCircle();
  }    
  else if( key == 'b' || key == 'B' ) {
    LetsBigBomb();
  }    
  else {
  }
}


void bangStarListProcessFor8() {
  
  float starAngle ; // the circling-angle of a Bang-Fire
  float starLen ;
  
  starAngle = PI/4 ;
  starLen = 1.0 ;
  
  PVector BangStar1  = new PVector(0 , -1) ;    
  PVector BangStar2  = new PVector(  ( starLen * sin(starAngle) ) ,
                                    -( starLen * cos(starAngle) )
                                   );

  PVector BangStar3  = new PVector(1 , 0) ;    
  PVector BangStar4  = new PVector(  ( starLen * cos(starAngle) ) ,
                                     ( starLen * sin(starAngle) )
                                   );

  PVector BangStar5  = new PVector(0 , 1) ;    
  PVector BangStar6  = new PVector( -( starLen * sin(starAngle) ) ,
                                     ( starLen * cos(starAngle) )
                                   );

  PVector BangStar7  = new PVector(-1 , 0) ;    
  PVector BangStar8  = new PVector( -( starLen * cos(starAngle) ) ,
                                    -( starLen * sin(starAngle) )
                                   );
                                   
  bangStarList.add(BangStar1);
  bangStarList.add(BangStar2);
  bangStarList.add(BangStar3);
  bangStarList.add(BangStar4);
  
  bangStarList.add(BangStar5);
  bangStarList.add(BangStar6);
  bangStarList.add(BangStar7);
  bangStarList.add(BangStar8);

}

void bangStarListProcessFor12() {
  
  float starAngle ; // the circling-angle of a Bang-Fire
  float starLen ;
  
  starAngle = PI/6 ;
  starLen = 1.0 ;
  
  PVector BangStar1  = new PVector(0 , -1) ;    
  PVector BangStar2  = new PVector(  ( starLen * sin(starAngle) ) ,
                                    -( starLen * cos(starAngle) )
                                   );
  PVector BangStar12 = new PVector( -( starLen * sin(starAngle) ) ,
                                    -( starLen * cos(starAngle) )    
                                   );
  
  PVector BangStar4  = new PVector(1 , 0) ;
  PVector BangStar3  = new PVector(  ( starLen * cos(starAngle) ) ,
                                    -( starLen * sin(starAngle) ) 
                                   ) ;
  PVector BangStar5  = new PVector(  ( starLen * cos(starAngle) ) ,
                                     ( starLen * sin(starAngle) ) 
                                   ) ;

  PVector BangStar7  = new PVector(0 , 1) ;
  PVector BangStar6  = new PVector(  ( starLen * sin(starAngle) ) ,
                                     ( starLen * cos(starAngle) ) 
                                   ) ;
  PVector BangStar8  = new PVector( -( starLen * sin(starAngle) ) ,
                                     ( starLen * cos(starAngle) ) 
                                   ) ;

  PVector BangStar10 = new PVector(-1 , 0) ;
  PVector BangStar11 = new PVector( -( starLen * cos(starAngle) ) ,
                                    -( starLen * sin(starAngle) ) 
                                   ) ;
  PVector BangStar9  = new PVector( -( starLen * cos(starAngle) ) ,
                                     ( starLen * sin(starAngle) ) 
                                   ) ;


  bangStarList.add(BangStar1);
  bangStarList.add(BangStar2);
  bangStarList.add(BangStar3);
  bangStarList.add(BangStar4);
  bangStarList.add(BangStar5);
  bangStarList.add(BangStar6);

  bangStarList.add(BangStar7);
  bangStarList.add(BangStar8);
  bangStarList.add(BangStar9);
  bangStarList.add(BangStar10);
  bangStarList.add(BangStar11);
  bangStarList.add(BangStar12);

}

// 2016.12.18 , fire circle-beaming . Bang ! Bang ! Bang !
void FireCircle() {
    
  for(int i = 0 ; i < bangStarList.size() ; i++) {
    
    PVector bmv = bangStarList.get(i).get() ;
    /* NOTE !!!
       PVector bmv = bangStarList.get(i) ;
       Means that : 
       "bmv" IS the "bangStarList" factor .
       Operating "bmv" IS operating the "bangStarList" factor absolutely .
    */
    bmv.normalize();
    bmv.mult( BeamingOtSpeed );
    
    BeamingOt bmot = new BeamingOt( fighter.location , bmv ) ;
    bos.add(bmot);

  }
}


/* 2017.01.02 am 02:43 */
void LetsBigBomb() {

  // Only one BOMB in a time .
  if( bigBombList.size() == 0 ) {
      
    PVector mouseLocation = new PVector( mouseX , mouseY ) ; 
    PVector lbb = PVector.sub( mouseLocation , fighter.location ) ;
    lbb.normalize();
    lbb.mult( BigBombSpeed );
  
    BigBomb bb = new BigBomb( fighter.location , lbb ) ;
    bigBombList.add(bb);
  }
  
}

