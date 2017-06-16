let scores_r = [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]];
let scores_r3 = [[3,3],[3,3],[3,3],[3,3],[3,3],[3,3],[3,3],[3,3],[3,3],[3,3]];
let scores_spares = [[4,6],[4,6],[4,6],[4,6],[4,6],[4,6],[4,6],[4,6],[4,6],[4,6,4]];
let scores_strices = [[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[0,0]];
let scores_strices_p1 = [[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0,0]];
let scores_strices_p2 = [[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,10,0]];
let scores_strices_p = [[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,10,10]];

function makeFlat(ddarray){
	let flat_array  = [];
	for(var i=0; i<ddarray.length; i++) {
		for(var y=0; y<ddarray[i].length; y++){
			if(ddarray[i][y] == 0 && ddarray[i].length == 2 && ddarray[i][y-1] == 10 ){

			} else {
				flat_array.push(ddarray[i][y]);
			};
		};
	};
	return flat_array;
}

function removeZeroForStrice(ddarray){
	let array_strice_efficient  = [];
	for(var i=0; i<ddarray.length; i++) {
		if(ddarray[i][1] == 0 
			&& ddarray[i].length == 2 
			&& ddarray[i][0] == 10 ){

			array_strice_efficient.push([10]);
		} else {
			array_strice_efficient.push(ddarray[i]);
		};
	};
	return array_strice_efficient;
}

function isStrike(array, pivot){
	return array[pivot] === 10;
}

function getStep(array, pivot) {
	if (isStrike(array, pivot)) {
		return 1;
	};
	return 2;
}

function getTurnSum(array, pivot, step) {
	var sum = 0;
	for(var i=pivot; i < step && i < array.length; i++ ) {
		sum += array[i];
	}
	return sum;
}

function sumEverithing(anArray){
	console.log(anArray);
	//flat_array =  makeFlat(anArray);
	let array_strice_efficient = removeZeroForStrice(anArray);	
	let flat_array = makeFlat(anArray);
	var total_sum = 0;
	let currect_step = 0;
	let turn_step = 0;
	while(currect_step < flat_array.length){
		// console.log(currect_step+1);

		let turn_sum = 0;
		let bonus_points = 0;
		turn_step = currect_step + getStep(flat_array, currect_step);
		turn_sum = getTurnSum(flat_array, currect_step, turn_step);
		if(turn_sum == 10 && currect_step < flat_array.length -3 ) {
			if(isStrike(flat_array, currect_step)) {
				bonus_points += 2;
			} else {
				bonus_points += 1;
			}
		}

		turn_sum += getTurnSum(flat_array, turn_step, turn_step+bonus_points);
		total_sum += turn_sum;
		currect_step = turn_step;
		// console.log(turn_sum);
		// console.log(total_sum);
		// console.log('----------------');
	}	

	return total_sum;
};


let sum_value = sumEverithing(scores_r);
console.log(sum_value);
console.log('----------------------');
sum_value = sumEverithing(scores_r3);
console.log(sum_value);
console.log('----------------------');
sum_value = sumEverithing(scores_spares);
console.log(sum_value);
console.log('----------------------');
sum_value = sumEverithing(scores_strices);
console.log(sum_value);


console.log('----------------------');
sum_value = sumEverithing(scores_strices_p1);
console.log(sum_value);

console.log('----------------------');
sum_value = sumEverithing(scores_strices_p2);
console.log(sum_value);

console.log('----------------------');
sum_value = sumEverithing(scores_strices_p);
console.log(sum_value);