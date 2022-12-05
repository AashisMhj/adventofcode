#!/usr/bin/ruby -w

=begin
1. declare variable to store the sum
2. read file and loop thought
3. split the row into two parts
4. get the min and max of both parts
5. check if the main and max of part1 is less then or equal to the other part and check vice versa for the other part again
6. if yes then add the part
=end
FILE_NAME = "input.txt"
count = 0
overlap_count = 0
total = 0
File.foreach(FILE_NAME) { 
    |line| 
    a,b = line.strip.split(",")
    a_min, a_max = a.split("-")
    b_min, b_max = b.split("-")
    # puts "#{a_min}-#{a_max},#{b_min}-#{b_max}"
    a_min = Integer(a_min)
    a_max = Integer(a_max)
    b_min = Integer(b_min)
    b_max = Integer(b_max)
    total += 1;
    if a_min <= b_min && a_min <= b_max && a_max >= b_min && a_max >= b_max
        # puts "Case of A #{a_min} - #{b_min} #{b_max} - #{a_max}"
        count += 1
    elsif b_min <= a_min && b_min <= a_max && b_max >= a_min && b_max >= a_max
        # puts "Case of B #{b_min} - #{a_min} #{a_max} - #{b_max}"
        count += 1
    end
    # for overlap case
    if a_min>= b_min && a_min <= b_max
        puts "#{a_min}-#{a_max},#{b_min}-#{b_max}"
        overlap_count += 1
    elsif a_max >= b_min && a_max <= b_max
        puts "#{a_min}-#{a_max},#{b_min}-#{b_max}"
        overlap_count += 1
    elsif b_min >= a_min && b_min <= a_max
        puts "#{a_min}-#{a_max},#{b_min}-#{b_max}"
        overlap_count += 1
    elsif b_max >= a_min && b_max <= a_max
        puts "#{a_min}-#{a_max},#{b_min}-#{b_max}"
        overlap += 1
    end
}

puts "Total #{total}"
puts "No fo Pair #{count}"
puts "Overlap Count: #{overlap_count}"