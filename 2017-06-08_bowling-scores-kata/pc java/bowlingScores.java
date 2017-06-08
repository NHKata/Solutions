public class bowlingScores {
    public static void main(String[] args) {

        //int scores[][]={{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0}};  //-> 0
        //int scores[][]={{3,3},{3,3},{3,3},{3,3},{3,3},{3,3},{3,3},{3,3},{3,3},{3,3}};  //-> 60
        //int scores[][]={{4,6},{4,6},{4,6},{4,6},{4,6},{4,6},{4,6},{4,6},{4,6},{4,6,4}};  //-> 140
        int scores[][]={{10,0},{10,0},{10,0},{10,0},{10,0},{10,0},{10,0},{10,0},{10,0},{0,0}};  //-> 240
        //int scores[][]={{10,0},{10,0},{10,0},{10,0},{10,0},{10,0},{10,0},{10,0},{10,0},{10,10,10}};   //-> 300
        //int scores[][]={{10,0},{10,0},{10,0},{10,0},{10,0},{10,0},{10,0},{10,0},{10,0},{10,5,0}};  //-> 280
        //int scores[][]={{10,0},{10,0},{10,0},{10,0},{10,0},{10,0},{10,0},{10,0},{10,0},{10,5,5}};  //-> 285
        
        int firstRoll = 0;
        int secondRoll = 1;
        int totalScore = 0;
        int lastSet = 9;
        int setScore = 0;

        for(int currentSet=0; currentSet <9; currentSet++)
        {
            setScore = scores[currentSet][firstRoll] + scores[currentSet][secondRoll];
            totalScore += setScore;

            // if the previous set was a strike then add the subsequent 2 rolls to the total score
            if ((setScore == 10) && (scores[currentSet][firstRoll] == 10))
            {
               totalScore += scores[currentSet+1][firstRoll];

                // if the subsequent set was a strike then add the first roll of the subsequent set (except if that is the last set (<8))
               if (scores[currentSet+1][firstRoll] == 10 && currentSet < 8)
               {
                   totalScore += scores[currentSet+2][firstRoll];
               }
               else
               {
                   totalScore += scores[currentSet+1][secondRoll];
               }
            }
            // if the previous set was a spare then add the subsequent 1 roll to the total score
            else if (setScore == 10)
            {
                totalScore += scores[currentSet+1][firstRoll];
            }
            System.out.println(totalScore);
        }

        // add the final set to the total score regardless of number of rolls
        for(int roll=0; roll < scores[lastSet].length; roll++)
        {
            totalScore += scores[lastSet][roll];
        }


        System.out.println("Total Score: " + totalScore);
    }
}
