# inefficient_fibonacci.py
def inefficient_fibonacci(n):
  if n <= 1:
    return n
  return inefficient_fibonacci(n-1) + inefficient_fibonacci(n-2)

def calculate_fibonacci(n):
  return inefficient_fibonacci(n)

if __name__ == "__main__":
  n = int(input("Enter a number: "))
  result = calculate_fibonacci(n)
  print(f"Fibonacci of {n} is: {result}")
