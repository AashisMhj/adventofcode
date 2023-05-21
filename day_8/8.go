package main
import (
	"fmt"
	"io/ioutil"
	"strings"
	"strconv"
)
const FILE_PATH string = "./input.txt"

func getTreeArray()[][]int{
	content, err := ioutil.ReadFile(FILE_PATH)
	if err != nil{
		fmt.Printf("Error reading file: %v", err)
	}
	lines :=  strings.Split(string(content), "\n")
	var my_array [][]int
	for _, line := range lines {
		line = strings.TrimSpace(line)
		if line != ""{
			chars := strings.Split(line, "")
			intArray := make([]int, len(chars))
			for index, value := range chars{
				num, err := strconv.Atoi(value)
				if err != nil{
					fmt.Printf("Error converting element at index %d: %s \n", index, err.Error())
					continue
				}
				intArray[index] =num
			}
			my_array = append(my_array, intArray)
		}
	}
	return my_array;

}

func main(){
	count := 0
	
	multiArray := getTreeArray()
	multiArray2 := getTreeArray()

	

	highestCountTop := multiArray[0]
	highestCountBottom := multiArray[len(multiArray)-1]
	highestCountLeft := make([]int, len(multiArray))
	highestCountRight := make([]int, len(multiArray))
	for i:= 0; i < len(multiArray); i++{
		highestCountLeft[i] = multiArray[i][0]
		highestCountRight[i] = multiArray[i][len(multiArray)-1]
	}
	
	treesMap := make(map[string]int)

	for i := len(multiArray) -2; i >= 1; i--{
		for j := len(multiArray[i]) -2; j >= 1; j--{
			current_tree := multiArray[i][j]
			if(current_tree > highestCountRight[i]){
				map_key := string(fmt.Sprint(strconv.Itoa(i), "-", strconv.Itoa(j)))
				highestCountRight[i] = current_tree
				_, exists := treesMap[map_key]
				if !exists{
					treesMap[map_key] = current_tree
					count += 1
				} 
			}
			if(current_tree > highestCountBottom[j]){
				map_key := string(fmt.Sprint(strconv.Itoa(i), "-", strconv.Itoa(j)))
				highestCountBottom[j] = current_tree
				_, exists := treesMap[map_key]
				if !exists{
					treesMap[map_key] = current_tree
					count += 1
				}
			}
		}
	}


	

	// checking top
	for i:=1; i <= len(multiArray)-2; i++{
		for j:=1; j <= len(multiArray[i])-2; j++{
			current_tree := multiArray[i][j]
			if(current_tree > highestCountTop[j]){
				map_key := string(fmt.Sprint(strconv.Itoa(i), "-", strconv.Itoa(j)))
				highestCountTop[j] = current_tree
				_, exists := treesMap[map_key]
				if !exists{
					treesMap[map_key] = current_tree
					count += 1
				}
			}
			if(multiArray[i][j] > highestCountLeft[i]){
				map_key := string(fmt.Sprint(strconv.Itoa(i), "-", strconv.Itoa(j)))
				highestCountLeft[i] = current_tree
				_, exists := treesMap[map_key]
				if !exists{
					treesMap[map_key] = current_tree
					count += 1
				}
			}
		}
	}
	


	lengthX := (len(multiArray[0])) * 2
	lengthY := (len(multiArray) -2) * 2
	

	fmt.Printf("Total no of visible trees %d \n", count + lengthX + lengthY)

	highest_point := 0;
	location_i := 0
	location_j := 0
	

	// part two calcualte the senic point
	for i := 1; i <= len(multiArray2)-2; i++{
		for j := 1; j <= len(multiArray2[i])-2; j++{
			
			current_tree := multiArray2[i][j]
			view_count := 0
			top_count := 0
			bottom_count := 0
			left_count := 0
			right_count := 0
			for a:= i-1; a >=0; a--{
				if(current_tree <= multiArray2[a][j]){
					top_count += 1
					break
				}else{
					top_count += 1
				}
			}

			for b:= i+1; b < len(multiArray2); b++{
				if(current_tree <= multiArray2[b][j]){
					bottom_count += 1
					break
				}else{
					bottom_count += 1
				}
				
			}
			for c:= j-1; c >=0; c--{
				if(current_tree <= multiArray2[i][c]){
					left_count += 1
					break
				}else{
					left_count += 1
				}
			}
			for d:= j+1; d < len(multiArray2); d++{
				if(current_tree <= multiArray2[i][d]){
					right_count += 1
					break
				}else{
					right_count += 1
				}
				
			}
			view_count = left_count * right_count * top_count * bottom_count
			if(view_count > highest_point){
				location_i = i
				location_j = j
				highest_point = view_count
			}

		}
	}	

	fmt.Printf("Highest view point: %d, location [%d][%d] \n", highest_point, location_i, location_j)
}