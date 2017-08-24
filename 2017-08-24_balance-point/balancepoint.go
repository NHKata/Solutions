package main

import (
	"fmt"
)

func main() {
	//Lets set up sonme arrays of ints
	firstList := []int{1, 2, 3, 4, 4, 3, 2, 1}
	balance := findBalance(firstList)
	fmt.Printf("Balance point %v  \n", balance)

	fmt.Printf("Balance 2 is %v \n ", findBalance([]int{1, 1, 2}))

	fmt.Printf("Balance 3 is %v \n ", findBalance([]int{1, 2, 1}))
	fmt.Printf("Balance 3 is %v \n ", findBalance([]int{1, 1, 1000, 1}))

}

//Count is a struct used to store the left and right value for each index
type Count struct {
	Left  int
	Right int
}

func findBalance(entry []int) float64 {
	var balance float64
	counts := make([]Count, len(entry))
	//We want to step through the array from left to right and calculate the Left total and the right total for the index
	rTotal := 0
	//Start at one because we want to count to left
	counts[0].Left = 0
	for i := 1; i < len(entry); i++ {
		counts[i].Left = counts[i-1].Left + entry[i-1]
	}

	for j := (len(entry) - 1); j >= 0; j-- {
		rTotal = rTotal + entry[j]
		counts[j].Right = rTotal
	}

	diff := 0
	for k := 0; k < len(counts); k++ {
		diff = counts[k].Left - counts[k].Right
		if diff == 0 {
			//found that shit
			return float64(k)
		}
		if diff > 0 {
			//Work out what's going on here
			fmt.Println("We crossed over")
			fmt.Println("Between %v and %v", counts[k-1], counts[k])
			//This tells us how much we moved between the indexes in difference. IE was there a swing from -6 to +9
			diffOfLeft := counts[k].Left - counts[k-1].Left

			//Get the total and then the desired midpoint (this is the pivot point)
			sum := counts[k].Left + counts[k].Right
			mid := float64(sum / 2)

			//What we want is the % of the index which hits the mid point
			//Work out how the left figure changes between indexes and then the distance to the midpoint from the last left index
			//We then want to work out the desired distance as a % of the difference
			midRange := (mid - float64(counts[k-1].Left)) / float64(diffOfLeft)
			fmt.Printf("sum %v mid %v diff %v diffOfLeft %v midRange %v  \n", sum, mid, diff, diffOfLeft, midRange)
			return float64(k-1) + midRange

		}

	}

	return balance
}
