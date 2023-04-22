#!/usr/bin/ruby -w
require 'set'

FILE_NAME = "input2.txt"
trees_array = []

File.foreach(FILE_NAME){
    |line|
    trees_array.push(line.strip.split(""))
}


visible_out_side = (trees_array.length * 2) + ((trees_array[0].length-2) * 2)

puts visible_out_side

count = Set.new
# check from left side and right
trees_array.each_with_index{|row, index|
    highest_tree_left = Integer(row[0]);
    highest_tree_right = Integer(row[row.length-1])
    row.each_with_index{
        |column, column_index|
        tree_height = Integer(column)
        if(tree_height > highest_tree_left)
            count << "#{index}-#{column_index}-#{column}"
            highest_tree_left = tree_height
        end
    }
    row.reverse.each_with_index{|column, column_index|
        tree_height = Integer(column)
        if(tree_height > highest_tree_right)
            count << "#{index}-#{column_index}-#{column}"
            highest_tree_right = tree_height
        end
    }

}

highest_tree_top = trees_array[0].slice(1, trees_array[0].length -2)
highest_tree_bottom = trees_array[trees_array.length - 1]
for a in trees_array do
    for b in 1..highest_tree_top.length do
        puts trees_array[a][b]
    end 
end

puts count.count
