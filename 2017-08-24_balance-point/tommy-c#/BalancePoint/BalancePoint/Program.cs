using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApplication4
{
    class Program
    {
        static void Main(string[] args)
        {   
            //dirty version (I'm not cleaning it :D), asuming no negative
            var testArray = new [] { 1, 1, 1000, 1 };

            double previousLeft=0;
            double sum = testArray.Sum();
            double left = 0;
            var right = sum;

            for (var i = 0; i < testArray.Length; i++)
            {
                left += testArray[i];
                right -= testArray[i];

                Debug.WriteLine("position in array is:" + i);
                Debug.WriteLine("left is: " + left);
                Debug.WriteLine("right is: " + right);

                //easy mode
                if (left.Equals(right))
                {
                    var point = i + 1;
                    Debug.WriteLine("hit balance point:" + point);
                    break;
                }

                //hard mode - non natural pivot point mode, wat (¯\_(ツ)_/¯).
                if (left > right)
                {
                    var calc = ((left + right)/2-previousLeft) / testArray[i];
                    var point = i + calc;
                    Debug.WriteLine("hit balance point:" + point);
                    break;
                }           
                previousLeft = left;              
            }
        }

            
        }
    }
