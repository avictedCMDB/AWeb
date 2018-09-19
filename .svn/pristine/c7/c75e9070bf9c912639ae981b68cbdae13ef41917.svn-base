package com.avic.market.utils;

public class DataUtil {
    public static int[] generateCategoryRange(int cat) {
        int catStart = 0 , catEnd = 0;
        
        if (cat > 0) {
            // 一级分类
            if (cat < 100) {
                catStart = cat * 10000;
                catEnd = catStart + 9999;
            // 二级分类
            } else if (cat < 10000) {
                catStart = cat * 100;
                catEnd = catStart + 99;
            // 三级分类
            } else {
                catStart = cat;
                catEnd = cat;
            }
        }
        
        return new int[] {catStart, catEnd};
    }
}
