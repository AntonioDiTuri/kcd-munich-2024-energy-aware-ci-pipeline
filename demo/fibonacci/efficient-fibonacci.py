def efficient_fibonacci(n):
  """
  This function calculates the nth Fibonacci number using an iterative approach.
  """
  # Initialize first two Fibonacci numbers
  a, b = 0, 1

  # Iterate for n times, calculating the next Fibonacci number
  for _ in range(n):
    a, b = b, a + b

  return a

# Example usage (can be included in the same file for demo purposes)
if __name__ == "__main__":
  n = int(input("Enter a number: "))
  result = efficient_fibonacci(n)
  print(f"Fibonacci of {n} is: {result}")
