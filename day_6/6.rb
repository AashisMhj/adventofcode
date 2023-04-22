#!/usr/bin/ruby -w
require "set"

FILE_NAME = "input.txt"
my_array = []
$message_length = 14
marker = 0

def read_file
    File.open(FILE_NAME) do |file|
        while (buffer = file.read(1)) do
            yield buffer
        end
    end
end
def push_item(array, item)
    if(array.length >= $message_length)
        array.shift
    end
    array.push(item)
end
def is_unique(array)
    my_set = array.to_set    
    if(my_set.length() == $message_length )
        return true
    end
end

read_file do |data|
    marker += 1
    push_item(my_array, data)
    if(is_unique(my_array))
        puts my_array.join()
        break
    end
end

puts "maker #{marker}"
