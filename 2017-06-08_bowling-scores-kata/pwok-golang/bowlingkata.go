package main

import (
	"fmt"
)

//Roll is a way of attaching metadata to a roll so we can identify strikes and spare
type Roll struct {
	Score  int
	Spare  bool
	Strike bool
	Bonus  bool
}

//Frame is a collection of scores. Normally 2 but round 10 can be 3
type Frame struct {
	Scores []int
}

//Game holds all the frames
type Game struct {
	Frames []Frame
}

func main() {
	games := []Game{
		Game{[]Frame{Frame{[]int{0, 0}}, Frame{[]int{0, 0}}, Frame{[]int{0, 0}}, Frame{[]int{0, 0}}, Frame{[]int{0, 0}}, Frame{[]int{0, 0}}, Frame{[]int{0, 0}}, Frame{[]int{0, 0}}, Frame{[]int{0, 0}}, Frame{[]int{0, 0}}}},
		Game{[]Frame{Frame{[]int{10, 0}}, Frame{[]int{10, 0}}, Frame{[]int{10, 0}}, Frame{[]int{0, 0}}, Frame{[]int{0, 0}}, Frame{[]int{0, 0}}, Frame{[]int{0, 0}}, Frame{[]int{0, 0}}, Frame{[]int{0, 0}}, Frame{[]int{0, 0}}}},
		Game{[]Frame{Frame{[]int{10, 0}}, Frame{[]int{10, 0}}, Frame{[]int{10, 0}}, Frame{[]int{10, 0}}, Frame{[]int{10, 0}}, Frame{[]int{10, 0}}, Frame{[]int{10, 0}}, Frame{[]int{10, 0}}, Frame{[]int{10, 0}}, Frame{[]int{0, 0}}}},
		Game{[]Frame{Frame{[]int{3, 3}}, Frame{[]int{3, 3}}, Frame{[]int{3, 3}}, Frame{[]int{3, 3}}, Frame{[]int{3, 3}}, Frame{[]int{3, 3}}, Frame{[]int{3, 3}}, Frame{[]int{3, 3}}, Frame{[]int{3, 3}}, Frame{[]int{3, 3}}}},
		Game{[]Frame{Frame{[]int{10, 0}}, Frame{[]int{10, 0}}, Frame{[]int{10, 0}}, Frame{[]int{10, 0}}, Frame{[]int{10, 0}}, Frame{[]int{10, 0}}, Frame{[]int{10, 0}}, Frame{[]int{10, 0}}, Frame{[]int{10, 0}}, Frame{[]int{10, 10, 10}}}}}
	for _, g := range games {
		fmt.Println(calculateScores(g))
	}
}

func calculateScores(g Game) int {
	var gameRolls []Roll
	//Let's flatten any strikes down then flatten everything into rolls
	for i, f := range g.Frames {
		//convert Frame into Rolls and append into gameRolls slice
		gameRolls = append(gameRolls, convertFrame(f, i)...)
	}
	return countRolls(gameRolls)
}

func countRolls(rolls []Roll) int {
	count := 0
	for i := 0; i < len(rolls); i++ {
		r := rolls[i]
		if !r.Bonus {
			//Add the score
			count = count + r.Score
			if r.Strike {
				//If strike add next two scores
				count = count + rolls[i+1].Score + rolls[i+2].Score
			} else if r.Spare {
				//If spare add the next score
				count = count + rolls[i+1].Score
			}
		}

	}
	return count
}

func convertFrame(f Frame, index int) []Roll {
	//Make an empty slice of rolls
	var rolls []Roll
	if f.Scores[0] == 10 {
		//append a Striker Roll
		rolls = append(rolls, Roll{Score: f.Scores[0], Spare: false, Strike: true})
		//normally we drop the 2nd but if it's the 10th frame we dont
		if index == 9 {
			rolls = append(rolls, Roll{Score: f.Scores[1], Spare: false, Strike: false, Bonus: true})
		}
	} else if f.Scores[0]+f.Scores[1] == 10 {
		//append a normal roll for 1st
		rolls = append(rolls, Roll{Score: f.Scores[0], Spare: false, Strike: false})
		//append a strike roll for 2nd
		rolls = append(rolls, Roll{Score: f.Scores[1], Spare: true, Strike: false})
	} else {
		rolls = append(rolls, Roll{Score: f.Scores[0], Spare: false, Strike: false})
		rolls = append(rolls, Roll{Score: f.Scores[1], Spare: false, Strike: false})
	}

	//There is a potential 3rd roll in the 10th Frame
	if len(f.Scores) == 3 && index == 9 {
		rolls = append(rolls, Roll{Score: f.Scores[2], Spare: false, Strike: false, Bonus: true})
	}
	return rolls
}
