#include "addon.h"


TF1_p TF1_New( const char* name, const char* formula, double xmin, double xmax )
{
  TF1* f = new TF1( name, formula, xmin, xmax ) ;
  return  to_nonconst<TF1_t, TF1>(f); 
}
