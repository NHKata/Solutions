public class bowlingScores {
    public static void main(String[] args) {

        //int scores[][]={{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0}};
        //int scores[][]={{3,3},{3,3},{3,3},{3,3},{3,3},{3,3},{3,3},{3,3},{3,3},{3,3}};
        int scores[][]={{4,6},{4,6},{4,6},{4,6},{4,6},{4,6},{4,6},{4,6},{4,6},{4,6,4}};
        //int scores[][]={{10,0},{10,0},{10,0},{10,0},{10,0},{10,0},{10,0},{10,0},{10,0},{10,10,10}};
        
        int firstRoll = 0;
        int secondRoll = 1;
        int thirdRoll = 2;
        int totalScore = 0;
        int lastSet = 9;
        int setScore = 0;

        for(int currentSet=0; currentSet <9; currentSet++)
        {
            setScore = scores[currentSet][firstRoll] + scores[currentSet][secondRoll];
            totalScore += setScore;

            if ((setScore == 10) && (scores[currentSet][firstRoll] == 10))
            {
               totalScore += scores[currentSet+1][firstRoll];
               totalScore += scores[currentSet+1][secondRoll];

            }
            else if (setScore == 10)
            {
                totalScore += scores[currentSet+1][firstRoll];
            }
            System.out.println(totalScore);
        }

        totalScore += scores[lastSet][firstRoll];
        totalScore += scores[lastSet][secondRoll];

        if (setScore == 10)
        {
            totalScore += scores[lastSet][thirdRoll];
        }

        System.out.println("Total Score: " + totalScore);
    }
}