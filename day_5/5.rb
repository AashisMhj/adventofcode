#!/usr/bin/ruby -w

FILE_NAME = "input.txt";
crane_9000 = []
crane_9001 = []
temp = []
fill_up = true
File.foreach(FILE_NAME){
    |line|
    if(fill_up)
        if(line == "\n")
            fill_up = false;
            temp.to_enum.with_index.reverse_each do |word, index| 
                if index == temp.length - 1
                    stacks = word.split(" ")
                    stacks.each{ |item| crane_9000.push([])}
                    stacks.each{ |item| crane_9001.push([])}

                else
                    take_length = 3
                    cursor = 0
                    creates_index = 0
                    until cursor == word.length do
                        create = word.slice(cursor, take_length)
                        if create.strip.length > 0
                            # crates.push(create)
                            crane_9000[creates_index].push(create)
                            crane_9001[creates_index].push(create)
                        end
                        creates_index += 1
                        cursor += take_length+1
                    end
                end
            end
        else
            temp.push(line);
        end
    else
        move, from, to = line.scan(/\s\d+/)
        move_one = Integer(move)
        move_two = move_one
        from = Integer(from) -1
        to = Integer(to) -1
        until move_one == 0 do
            pop_item = crane_9000[from].pop
            crane_9000[to].push(pop_item)
            move_one -= 1
        end
        moving_items = crane_9001[from].slice(crane_9001[from].length - move_two, crane_9001[from].length)
        crane_9001[to] = crane_9001[to] + moving_items
        crane_9001[from] = crane_9001[from].slice(0, crane_9001[from].length - move_two)
        # do some thing here
    end
}

result1 = crane_9000.map{|item| puts item[-1]}
puts "result 2"
result2 = crane_9001.map{|item| puts item[-1]}