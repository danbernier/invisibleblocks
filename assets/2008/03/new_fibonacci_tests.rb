require 'benchmark'
require 'test/unit'

class FibTest < Test::Unit::TestCase
	
	def setup
		@fib_new_memo = []
		@fib_orig_memo = []
	end
	
	def fib_new(n)
		@fib_new_memo[n] ||= if n < 3 # Note: remember, n must be a bit bigger for this definition.
							fib_orig n
						else
							# Detail: if n = 3, (n/2).to_i = 1, which makes y = 0.  
							# We're just picking a mid-way point, so bumping it up one won't hurt.
							x = (n / 2).to_i + 1
							y = x - 1
							
							# Fn = Fx Fny + Fy Fnx, for n > x, and y = x - 1
							fib_new(x) * fib_new(n-y) + fib_new(y) * fib_new(n-x)
						end
	end
	
	def fib_orig(n)
		@fib_orig_memo[n] ||= if n < 2
								n
							else
								fib_orig(n-1) + fib_orig(n-2)
							end
	end
	
	@@max_n = 6000
	
	def test_1_equality
		1.upto(@@max_n) { |n|
			assert_equal(fib_orig(n), fib_new(n), n)
		}
	end
	
	def test_2_benchmark
		puts "fib_new:"
		puts Benchmark.measure {
			fib_new(@@max_n)
		}
		puts "fib_new memo size: #{@fib_new_memo.compact.size}"
		puts "fib_new memoed indexes: #{@fib_new_memo.non_null_indexes * ' '}\n\n"
		
		puts "fib_orig:"
		puts Benchmark.measure {
			fib_orig(@@max_n)
		}
		puts "fib_orig memo size: #{@fib_orig_memo.compact.size}\n\n"
	end

	def test_3_fib_new_upper_bounds
		fib_new_max_n = 1000000
		puts "fib_new, trying to max out: F(#{fib_new_max_n})"
		puts Benchmark.measure {
			fib_new(fib_new_max_n)
		}
		puts "fib_new memo size: #{@fib_new_memo.compact.size}"
		puts "fib_new memoed indexes: #{@fib_new_memo.non_null_indexes * ' '}\n\n"
		puts
	end
	
	def test_4_golden_ratio
		n = 1400 # go too high, and get warning: Bignum out of Float range
		a = fib_new(n)
		b = fib_new(n+1)
		
		puts "actual golden ratio: 1.6180339887498948482"
		puts "approx. golden ratio: #{1+(a.to_f/b)}"
		puts "precision-level test: #{(1.to_f/3)}"
	end
end

class Array
	def non_null_indexes
		indexes = []
		each_with_index { |item, i|
			indexes.push i if item
		}
		indexes
	end
end