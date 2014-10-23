# Calculator v2

# Line 16: do a method is_integer? for more clarity

def is_integer?(n)
  if n == n.to_i
    true
  else
    false
  end
end

def calculate(n1, n2, op)
  n1 = n1.to_f
  n2 = n2.to_f
  result = case op
    when "+"
      n1 + n2
    when "-"
      n1 - n2
    when "*"
      n1 * n2
    when "/"
      n1 / n2
  end
  if is_integer?(result)
    result.to_i
  else
    result
  end
end

def ask(str)
  print str + " >> "
  gets.chomp
end

number1 = ask "Enter first number"
operator = ask "Enter operator (+, -, *, /)"
number2 = ask "Enter second number"
puts "The result is #{calculate(number1, number2, operator)}."
