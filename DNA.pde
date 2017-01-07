
/* 2017.01.05 am 01:19 
   DNA class as the force about the object-ship flying . 
   2017.01.07
*/

class DNA {
 
  PVector[] genes ;
  int geneSum ;
  
  DNA() {
    geneSum = 50 ;
    genes = new PVector[geneSum] ;
    
    for(int i = 0 ; i < geneSum ; i++) {
      PVector randomVec = new PVector( random(-100 , 100) , random(-100 , 100) ) ;
      randomVec.normalize();
      randomVec.mult(0.25);
      genes[i] = randomVec ;
    }
    
  }

  DNA( PVector[] newGenes ) {
    geneSum = newGenes.length ;
    genes = newGenes ;
  }
  
  
  DNA CrossOver( DNA partnerDNA ) {
    
    PVector[] childGenes = new PVector[geneSum] ;
    
    int midPoint = (int)random( 0 , geneSum-1 ) ;
    
    for(int i = 0 ; i <= midPoint ; i++) {
      childGenes[i] = genes[i] ;
    }
    
    for(int j = midPoint+1 ; j < geneSum ; j++) {
      childGenes[j] = partnerDNA.genes[j] ;
    }
    
    DNA childDNA = new DNA( childGenes ) ;
    
    return childDNA ;
  }
  
  void Mutate( float mutationRate ) {
    
    if( random(1) < mutationRate ) {
      
      int mutatePoint = (int)random( 0 , geneSum-1 ) ;
      genes[mutatePoint] = new PVector( random(0,1) , random(0,1) ) ;
    
    }
  }
 
}

