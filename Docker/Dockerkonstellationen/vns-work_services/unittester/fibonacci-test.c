// include Unittester, mandatory
#include <libunittester/unittester.h>

// include header of code to test
#include "fibonacci.h"

/*!
  \brief test positive test-cases for the fibonacci function

  \return 0 always
  */
int testFibonacciPositive(void)
{
  int fibo0 = 0;
  int fibo1 = 1;
  int fibo2 = 1;
  int fibo3 = 2;
  int fibo4 = 3;
  int fibo5 = 5;
  assertEquals(fibo0,
      fibonacci(0),
      "expecting first fibonacci number");
  assertEquals(fibo1,
      fibonacci(1),
      "expecting second fibonacci number");
  assertEquals(fibo2,
      fibonacci(2),
      "expecting third fibonacci number");
  assertEquals(fibo3,
      fibonacci(3),
      "expecting forth fibonacci number");
  assertEquals(fibo4,
      fibonacci(4),
      "expecting fifth fibonacci number");
  assertEquals(fibo5,
      fibonacci(5),
      "expecting sixth fibonacci number");
  return 0;
}

/*!
  \brief test negative test-cases for the fibonacci function

  \return 0 always
  */
int testFibonacciNegative(void)
{
  for (int m = -10; m < 0; m++)
  {
    assertEquals(1,
        fibonacci(m),
        "for negative input (%d) fibonacci should return first number",
        m);
  }
  for (int n = 16; n < 42; n++)
  {
    assertFalse(fibonacci(n) <= 0,
        "fibonacci does not return a negative value or zero for %d",
        n);
  }
  return 0;
}
int main(int argc,
    char** argv)
{
  int configErrors = testerConfigure(argc, argv);
  if (!configErrors)
  {
    CommonTest tests[] = {
      {
        .name = "Test fibonacci function, positive test-cases",
        .testMethod = testFibonacciPositive,
      },
      {
        .name = "Test fibonacci function, negative test-cases",
        .testMethod = testFibonacciNegative,
      },
    };
    TestSuite s = {
      .name = "Fibonacci sequence - tests",
      .testsToRunLength = 2,
      .testsToRun = tests,
    };
    return testerRunSuite(&s);
  }
  return configErrors;
}

