# recursive approach
def fib(n)
  if n < 2
    return n
  end
   fib(n-1) + fib(n-2)
end

puts fib(5) # assumes fib(0) = 0
puts fib 10

# recrusion with memoization
memo = {0 => 0, 1 => 1}

def memo_fib(n, memo)
  unless memo.key?(n)
    memo[n] = memo_fib(n-1, memo) + memo_fib(n-2, memo)
  end
  memo[n]
end

puts memo_fib(5, memo)
puts memo_fib(49, memo)

# iterative fib
def interative_fib(n)
  if n == 0
    return 0
  end
  a = 0
  b = 1
  puts a
(1..n - 1).each do
    puts b
    a, b = b, a + b
  end
  b
end

puts interative_fib(50)
puts interative_fib(8)
