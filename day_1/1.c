#include <stdio.h>
#include <stdlib.h>

/*
1. Read file
2. declare variable to store the highest calorie with default 0
3. declare variable to store the no of elf
4. declare variable to store the no of item
5. loop through the individual character
delcare a variable to store the current bag sum
while looping the char
declare a variable to store the last char 
declare a variable to store the calorie of current item
if the char code is between 0 and 9 then it is a number in which case parse it as int and append it to the current_item (current_item * 10 + current_char)
if the char code is \n then and last_char is also \n then the count of an bag has ended and thus the bag_sum needs to be compared with the highest calorie 
    if the highest calorie is less then bag_sum then replace the bag_sum with it
if the only the current char is \n then the sum of a current item has ended thus sum the current_item with the bag_sum
*/
int main(){
    FILE * fPtr;
    char ch;
    // open file
    fPtr = fopen("./input.txt", "r");

    // check if file open was success
    if(fPtr == NULL){
        printf("Unable to pen file");
        exit(EXIT_FAILURE);
    }
    // variable declare
    int highest_calorie = 0;
    int second_highest = 0;
    int third_highest = 0;
    int highest_elf_no  = 0;
    int second_highest_elf_no = 0;
    int third_highest_elf_no = 0;
    int total_elf = 0;
    int no_of_item = 0;
    int current_item = -1;
    char last_char = 0;
    int bag_sum = 0;

    do{
        ch = fgetc(fPtr);
        
        if(ch >= '0' && ch <= '9' ){
            if(current_item == -1){
                current_item = ch-48;

            }else{
                int decimal_number = current_item * 10;
                int int_value = ch - 48;
                current_item = decimal_number + int_value;
            }
        }else if((ch == 10 || ch == EOF) && last_char == 10){
            // case when count of a bag has ended
            total_elf++;
            // printf(" check %d > %d , %s \n", bag_sum, highest_calorie, bag_sum>highest_calorie ? "true" : "false");
            // if the current bag total the highest
            if(bag_sum >=  highest_calorie){
                third_highest = second_highest;
                second_highest = highest_calorie;
                highest_calorie = bag_sum;
                //
                third_highest_elf_no = second_highest_elf_no;
                second_highest_elf_no =highest_elf_no;
                highest_elf_no = total_elf;
            }else if(bag_sum >= second_highest){
                third_highest = second_highest;
                second_highest = bag_sum;
                //
                third_highest_elf_no = second_highest_elf_no;
                second_highest_elf_no = total_elf;
            }else if(bag_sum >= third_highest){
                third_highest = bag_sum;
                third_highest = total_elf;
            }
            bag_sum = 0;
            current_item = -1;
        }else if(ch == 10){
            // case when we are at the end of line           
            no_of_item++;
            bag_sum = bag_sum + current_item;
            current_item = -1;
        }
        last_char = ch;
        // putchar(ch);
    }while(ch != EOF);
    printf("The elf with the highest calorie %d th with  %d calorie \n", highest_elf_no, highest_calorie);
    printf("The elf with the second highest calorie is %dth with calorie %d\n", second_highest_elf_no, second_highest);
    printf("The elf with the third highest calorie is %dth with calorie %d \n", third_highest_elf_no, third_highest);
    printf("Sum of the highest %d \n", highest_calorie + second_highest + third_highest);
    printf("No of elf %d \n", total_elf);
    printf("Total No of Item %d \n", no_of_item);
    // close
    fclose(fPtr);

    return 0;
}