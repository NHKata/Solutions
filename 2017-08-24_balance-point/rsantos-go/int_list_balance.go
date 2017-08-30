package main

import "fmt"

func findBalance(list []int) (bidx int, foundInt bool, fbidx float64) {

	bidx = 0
	var lh int

	var ridx = len(list)
	var rh int

	for bidx < ridx {
		if lh > rh {
			ridx = ridx - 1
			rh = rh + list[ridx]
		} else {
			lh = lh + list[bidx]
			bidx = bidx + 1
		}
	}
	foundInt = lh == rh

	if !foundInt {
		var delta int
		var balanceBreaker int

		if lh > rh {
			bidx = bidx - 1
			balanceBreaker = list[bidx]
			delta = rh - (lh - balanceBreaker)
		} else {
			balanceBreaker = list[bidx]
			delta = (rh - balanceBreaker) - lh
		}

		fbidx = float64(bidx) + 0.5 + (float64(delta) / float64(balanceBreaker))
	}

	return
}

func main() {
	var input []int

	var idx int
	var found bool
	var idxClose float64

	input = []int{1, 2, 3, 4, 4, 3, 2, 1}
	idx, found, idxClose = findBalance(input)
	if found {
		fmt.Printf("Balance at %d\n", idx)
	} else {
		fmt.Printf("Balance NOT FOUND Closest point at %f\n", idxClose)
	}

	input = []int{1, 1, 2}
	idx, found, idxClose = findBalance(input)
	if found {
		fmt.Printf("Balance at %d\n", idx)
	} else {
		fmt.Printf("Balance NOT FOUND Closest point at %f\n", idxClose)
	}

	input = []int{1, 2, 1}
	idx, found, idxClose = findBalance(input)
	if found {
		fmt.Printf("Balance at %d\n", idx)
	} else {
		fmt.Printf("Balance NOT FOUND Closest point at %f\n", idxClose)
	}

	input = []int{1, 1, 1000, 1}
	idx, found, idxClose = findBalance(input)
	if found {
		fmt.Printf("Balance at %d\n", idx)
	} else {
		fmt.Printf("Balance NOT FOUND Closest point at %f\n", idxClose)
	}
}
