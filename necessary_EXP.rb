#次のレベルに必要な経験値算出

sum = 50
pre = 0
200.times do |i|
  i += 1
  if i == 1
    exp = 50
  elsif i <= 15
    exp = 50 + i * 2
  elsif i <= 180
    exp = (pre * 1.1 + i * 5) / 2
  else
    exp = 1000
  end
  exp = exp.round
  sum += exp
  puts "#{i}レベル 次のレベルに必要な経験値: #{exp} 累計: #{sum}"
  pre = exp
end
