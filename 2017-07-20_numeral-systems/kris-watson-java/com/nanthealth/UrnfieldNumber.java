package com.nanthealth;

import java.util.TreeMap;

class UrnfieldNumber
{

    private final static TreeMap<Integer, String> map = new TreeMap<>();

    static {
        map.put(5, "\\");
        map.put(1, "/");
    }

    public static String toArabic(int number) {
        int l =  map.floorKey(number);
        if ( number == l ) {
            return map.get(number);
        }
        return toArabic(number-l) + map.get(l);
    }

}
