#include "fibonacci.h"

int fibonacci(int n) {
  int a=0;
  int b=1;
  int fibo=a;
  for (int i=0; i<n; i++) {
    fibo = a+b;
    a=b;
    b =fibo;
  }
  return a;
}

