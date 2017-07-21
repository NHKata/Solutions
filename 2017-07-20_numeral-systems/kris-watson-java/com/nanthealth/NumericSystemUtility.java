package com.nanthealth;

public class NumericSystemUtility
{
    public static String getNumericalSystemValue(int i, String language) {
        String value = Integer.toString(i);
        switch(language) {
            case "Urnfield":
                value = UrnfieldNumber.toArabic(i);
                break;
            case "Roman":
                value = RomanNumber.toRoman(i);
                break;
            default:
                break;
        }
        return value;
    }
}
