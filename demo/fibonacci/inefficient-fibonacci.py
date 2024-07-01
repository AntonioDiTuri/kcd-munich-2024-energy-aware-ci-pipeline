# inefficient_fibonacci.py
import os

def inefficient_fibonacci(n):
  if n <= 1:
    return n
  return inefficient_fibonacci(n-1) + inefficient_fibonacci(n-2)

def calculate_fibonacci(n):
  return inefficient_fibonacci(n)

if __name__ == "__main__":
  n = os.getenv("INPUT")
  result = calculate_fibonacci(int(n))
  print(f"Fibonacci of {n} is: {result}")
