package main

import (
	"fmt"
	"io/ioutil"
)

func main(){
	filePath := "./input2.txt"
	content, err := ioutil.ReadFile(filePath)
	if err != nil {
		fmt.Printf("Error reading file: %v", err)
	}
	fmt.Println(string(content))
}