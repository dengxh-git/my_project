package com.sunline.sunfi.util;

import java.math.BigDecimal;

/**
*
* <p>Title: 常用数值计算</p>
* <p>Description: 常用数值计算</p>
* <p>Copyright: Copyright (c) 2004 Sunline</p>
* <p>Company: Sunline Technologies.</p>
* @author qiumh
* @version 1.0
*/
public class MathUtil
{
   /**
    * 取正数部分，负数返回0
    * @param expr 转换数值
    * @return 大于等于0的数字
    */
   public static double PLUS(double expr)
   {
       return (0>expr)?0:expr;
   }

   /**
    * 按精度求值(四舍五入)
    * @param expr 转换值
    * @param scale 精度值（小数点后几位，大于0正数）
    * @return 转换后数值
    */
   public static double ROUND(double expr, int scale)
   {
       return new BigDecimal(expr).setScale(scale, BigDecimal.ROUND_HALF_UP).
           doubleValue() ;
   }

   /**
    * 返回数字的整数部分
    * @param expr 转换值
    * @return 数值整数部分
    */
   public static int FIX(double expr)
   {
       return (int) expr ;
   }

   /**
    * 取两个数的最大值
    * @param d1 double
    * @param d2 double
    * @return double
    */
   public static double MAX(double d1,double d2)
   {
       return Math.max(d1,d2);
   }

   /**
    * 取两个数中的最小值
    * @param d1 double
    * @param d2 double
    * @return double
    */
   public static double MIN(double d1,double d2)
   {
       return Math.min(d1,d2);
   }

   /**
    * 返回绝对值
    * @param d1 double
    * @return double
    */
   public static double ABS(double d1)
   {
       return Math.abs(d1);
   }

   /**
    * 返回数字的整数部分，对于负数:函数返回小于或等于 number 的第一个负整数
    * @param d1 double
    * @return double
    */
   public static double INT(double d1)
   {
       return Math.floor(d1);
   }
}
