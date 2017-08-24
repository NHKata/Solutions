using System;

namespace FindingBalance
{
    /* 
        Run program from command prompt for e.g.
            dotnet run 1 2 3 4 4 3 2 1
            dotnet run 1 2 1
            dotnet run 1 1 1000 1 

        Alternatively you can run in visual studio code just add values to test array e.g.
            int[] testArray = new int []{1,2,3,4,4,3,2,1};
            int[] testArray = new int []{1,2,1};
            int[] testArray = new int []{1,1,1000,1};
     */
    class Program
    {
        static void Main(string[] args)
        {

            int[] testArray = new int []{};

            if(testArray.Length!=0){
                  
                FetchBalanceIndex(testArray);
            }
            else if(args.Length==0){

                
                Console.WriteLine("No Arguments Were Found___________________");
                Console.WriteLine("e.g  - dotnet run 1 2 3 4 5 6 ");
                Console.WriteLine("       dotnet run 3 1 3 4 1 6 ");
            }
            else{
                int[] list = new int[args.Length];

                for (int x = 0; x < args.Length; x++){
                    list[x] = Int16.Parse(args[x]);
                }
                  
                FetchBalanceIndex(list);
            }
            
        }

        public static void FetchBalanceIndex( int[] nums){

            /* create a pivot id holder */    
            PivotBalance bestBalance  = new PivotBalance(), pivotBalance;

            /* for each value in array */
            for (int x = 0; x < nums.Length; x++){

                pivotBalance = new PivotBalance(nums);
            
                pivotBalance.GetPivotBalanceEasyMode((x));

                if(bestBalance.getPivot() == 0){
                    bestBalance = pivotBalance;
                }else{
                    if(pivotBalance.getDifferenceTotal() < bestBalance.getDifferenceTotal()){
                        bestBalance = pivotBalance;
                    }
                }
            }

            if(bestBalance.getDifferenceTotal() !=0){
                bestBalance.GetPivotBalanceHardMode();
            }

            /* return the result */
            bestBalance.WriteToScreen();
        }

    }
}
