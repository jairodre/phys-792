#include <iostream>
#include <TRandom.h>

using std::cout;
using std::endl;

int main () {

   TRandom generator(0);

   cout<<generator.Poisson(2)<<endl;

   return 0;

}

