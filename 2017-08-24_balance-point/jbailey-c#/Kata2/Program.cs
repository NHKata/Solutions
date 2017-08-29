using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Kata2
{
    class Program
    {
        static void Main(string[] args)
        {
            int[] array1 = new[] { 1, 2, 3, 4, 4, 3, 2, 1 };
            calculateMidPointindex(array1);

            int[] array2 = new[] { 1, 1, 2 };
            calculateMidPointindex(array2);

            int[] array3 = new[] { 1, 2, 3 };
            calculateMidPointindex(array3);

            int[] array4 = new[] { 1, 2, 1 };
            calculateMidPointindex(array4);

            int[] array5 = new[] { 3, 3, 4, 3, 3 };
            calculateMidPointindex(array5);
        }

        static void calculateMidPointindex(int[] array)
        {
            int sumArray = array.Sum();
            float midPointVal = sumArray / 2;

            int currentTotal = 0;
            int midPointIndex = -1;

            for (int i = 0; i < array.Length; i++)
            {
                Console.WriteLine(i);
                Console.WriteLine($"LHS - {currentTotal}");
                Console.WriteLine($"RHS - {sumArray - currentTotal}\n");

                currentTotal += array[i];

                if (currentTotal == midPointVal)
                {
                    midPointIndex = i + 1;
                    break;
                } else if (currentTotal > midPointVal)
                {
                    //handleEdgeCase(array, i, midPointVal, sumArray);
                }
            }
            printIndex(midPointIndex);
        }

        static void handleEdgeCase(int[] array, int index, float midPointVal, int sumArray)
        {
            float currentTotal = 0;
            float virtualTotal = -1;

            float midPointIndex = 0;

            for (int i = 0; i < array.Length-1; i++)
            {
                currentTotal += array[i];
                virtualTotal = currentTotal + (array[i + 1] / 2f);

                if (midPointVal == virtualTotal)
                {
                    midPointIndex += (i + 1.5f);
                    break;
                }
            }

            int currentValue = array[index];
            int previousTotal = sumArray - currentValue;
            int previousValue = array[index - 1];
            
            float difference = Math.Abs(currentValue - previousValue);
            float differenceBetweenMidPointValAndPrev = midPointVal - previousTotal;

            float decimalVal = differenceBetweenMidPointValAndPrev / difference;
            float finalIndex = decimalVal + index;
            printIndex(decimalVal);
        }

        static void printIndex(float midPointIndex)
        {
            if (midPointIndex == -1)
            {
                Console.WriteLine("{ error, unbalanced}\n");
            }
            else
            {
                Console.WriteLine($"Mid point index is at {midPointIndex}\n");
            }
        }
    }
}
