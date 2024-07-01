import os 
import sys
import time


def efficient_fibonacci(n):
  """
  This function calculates the nth Fibonacci number using an iterative approach.
  """
  # Initialize first two Fibonacci numbers
  a, b = 0, 1

  # Iterate for n times, calculating the next Fibonacci number
  for i in range(n):
    print("iteration: "+str(i))
    print("a= " +str(a) + " b= " +str(b))
    time.sleep(0.3)
    a, b = b, a + b

  return a

# Example usage (can be included in the same file for demo purposes)
if __name__ == "__main__":
  sys.set_int_max_str_digits(100000)
  n = os.getenv("INPUT")
  result = efficient_fibonacci(int(n))
  print(f"Fibonacci of {n} is: {result}")
