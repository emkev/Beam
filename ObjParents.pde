
/*  2017.01.10 , 
    2017.01.11 , add Reproduce function 
*/

class ObjParents {
  
  Object Mobj ;
  Object Fobj ;
  //float MutationRate ;
  
  ObjParents( Object m , Object f ) {
    Mobj = m ;
    Fobj = f ;
  }
  
  Object Reproduce( float mur , int objSize ) {
    
    DNA childDna = Mobj.dna.CrossOver( Fobj.dna ) ;
    childDna.Mutate( mur ) ;
    Object obj = new Object( childDna , objSize ) ;
    
    return obj ;
  }
  
}
