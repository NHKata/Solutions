using System;

namespace FindingBalance
{
    class PivotBalance
    {
        private int addedTotal, remainingTotal, differenceTotal;
        private double pivot;
        private int [] numbers;

        public PivotBalance(){
           this.addedTotal = 0;
           this.remainingTotal = 0;
           this.differenceTotal = 0;
           this. pivot = 0;
        }
        
        public PivotBalance(int[] list){
           this.addedTotal = 0;
           this.remainingTotal = 0;
           this.differenceTotal = 0;
           this. pivot = 0;
           this.numbers = list;
        }

        /* Easy Mode: No Natural Balance Point? Quit! */
        public void GetPivotBalanceEasyMode(int index)
        {
            this.pivot = index;            

            int[] total = new int [4];

            for (int x = 0; x < index; x++){
                this.addedTotal  +=  this.numbers[x];
            }
            
            for (int x = index; x <  this.numbers.Length; x++){
                this.remainingTotal  +=  this.numbers[x];
            }

            this.differenceTotal = ((this.addedTotal - this.remainingTotal)< 0)? ((this.addedTotal - this.remainingTotal) * (-1)) : (this.addedTotal - this.remainingTotal);

        }

        /* Hard Mode: Super Bonus Edge Cases */
        public void GetPivotBalanceHardMode(){

            if(this.differenceTotal > 0){
                
                int valueAtPivot = this.getCurrentPivotValue();
                this.remainingTotal -= valueAtPivot;
                
                double remain = System.Convert.ToDouble(this.remainingTotal);
                double difference = System.Convert.ToDouble(this.differenceTotal);
                double addPivot = (((remain - difference) / 2) < 0 )? (((remain - difference) / 2) * (-1)) : ((remain - difference) / 2);              

                if((this.remainingTotal) == this.addedTotal){                            
                    this.pivot +=  addPivot;               
                }
                else{
                    this.pivot +=  System.Convert.ToDouble("0." + addPivot);
                }    
            }
        }

        public int getCurrentPivotValue(){
            return this.numbers[Convert.ToInt32(Math.Floor(this.pivot))];
        }

        public double getPivot(){
            return this.pivot;
        }
        public int getDifferenceTotal(){
            return this.differenceTotal;
        }
        public void WriteToScreen(){
            Console.WriteLine("-----------------------------------");
            Console.WriteLine("Left : " + this.addedTotal);
            Console.WriteLine("Right : " + this.remainingTotal);
            Console.WriteLine("Difference : " + this.differenceTotal);
            Console.WriteLine("-----------------------------------");
            Console.WriteLine("Pivot at index: : " + (this.pivot));
        }

    }
}
