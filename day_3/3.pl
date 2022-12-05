#!/usr/bin/perl
use strict;

my $filename = "input.txt";
open(my $fh, $filename) or die "File '$filename' can't be opened";

my $sum = 0;
my $group_sum = 0;
# function to trim the string
sub trim {
    my $s = shift;
    $s =~ s/^\s+|\s+$//g;
    return $s;
}
# function to get the prority of character
sub getPriority{
    my $increment_number = 0;
    my $val = @_[0];
    if($val =~/[a-z]/){
        $increment_number = ord($val) - 96;
    }elsif($_ =~ /[A-Z]/){
        $increment_number = ord($val) - 38;
    }
    return $increment_number;
}
my $firstLine = <fh>;
my @group_array = ();
while(my $row = <$fh>){
    $row = trim($row);
    my $len = length($row)/2;
    my @my_array = unpack("(A$len)*", $row);
    # print @my_array,"\n"; never do this 
    my @split_characters =  split("",@my_array[0]);
    # get unique items from the array
    @split_characters = do {my %seen; grep { !$seen{$_}++ } @split_characters};
    foreach(@split_characters){
        my $match_index = index($my_array[1], $_);
        if($match_index >= 0){
            $sum += getPriority($_);
        }
            
    }
    push(@group_array, $row);
    my $group_length = @group_array;
    if($group_length == 3){
        # calculate the part here
        my @sack_one = sort(do {my %seen; grep { !$seen{$_}++ } split("",@group_array[0])});
        my $sack_two = join("",sort(do {my %seen; grep { !$seen{$_}++ } split("",@group_array[1])}));
        my $sack_three = join("",sort(do {my %seen; grep { !$seen{$_}++ } split("",@group_array[2])}));
        foreach(@sack_one){
            my $match_one = index($sack_two, $_);
            my $match_two = index($sack_three, $_);

            if($match_one >= 0 and $match_two >=0){
                $group_sum += getPriority($_);
                
            }
        }
        @group_array = ();

    }
}
print "Total $sum \n";
print "Group $group_sum \n";

