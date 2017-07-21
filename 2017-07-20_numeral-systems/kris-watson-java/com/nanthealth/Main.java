package com.nanthealth;

import java.util.Arrays;
import java.util.List;
import java.util.StringJoiner;

public class Main
{
    private static boolean isValid = true;
    private static final List<String> LANGUAGES = Arrays.asList("Arabic", "Roman", "Urnfield");
    private static final String USAGE = "usage: java -jar NumericalSystemConverter <conversion to do>\n"
                                        + "e.g. java -jar NumericalSystemConverter Arabic -> Urnfield  for 1..10";

    private static String inputLanguage, outputLanguage;
    private static final int[] ranges = new int[2];

    public static void main (String[] args) {
        if(null == args || args.length < 5) {
            System.out.println(USAGE);
        } else {
            inputLanguage = validateAndReturnLanguage(args[0]);
            outputLanguage = validateAndReturnLanguage(args[2]);
            String[] rangeValues = args[4].split("\\.\\.");
            try {
                ranges[0] = Integer.parseInt(rangeValues[0]);
                ranges[1] = Integer.parseInt(rangeValues[1]);
            } catch (Exception e) {
                printInvalidArguments();
            }

            if(!isValid) {
                printInvalidArguments();
            } else {
                doConversion();
            }
        }
    }

    private static String validateAndReturnLanguage(String language)
    {
        isValid = LANGUAGES.contains(language) && isValid;
        return language;
    }

    private static void printInvalidArguments() {
        System.out.println("Invalid arguments supplied");
        System.out.println(USAGE);
    }

    private static void doConversion() {
        StringJoiner inputJoiner = new StringJoiner(",");
        StringJoiner outputJoiner = new StringJoiner(",");
        for(int i = ranges[0]; i <= ranges[1]; i++) {
            inputJoiner.add(NumericSystemUtility.getNumericalSystemValue(i, inputLanguage));
            outputJoiner.add(NumericSystemUtility.getNumericalSystemValue(i, outputLanguage));
        }
        System.out.println(inputJoiner);
        System.out.print(" -> ");
        System.out.println(outputJoiner);
    }
}
