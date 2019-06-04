package com.sunline.sunfi.util;

import java.math.BigDecimal;

/**
*
* <p>Title: ������ֵ����</p>
* <p>Description: ������ֵ����</p>
* <p>Copyright: Copyright (c) 2004 Sunline</p>
* <p>Company: Sunline Technologies.</p>
* @author qiumh
* @version 1.0
*/
public class MathUtil
{
   /**
    * ȡ�������֣���������0
    * @param expr ת����ֵ
    * @return ���ڵ���0������
    */
   public static double PLUS(double expr)
   {
       return (0>expr)?0:expr;
   }

   /**
    * ��������ֵ(��������)
    * @param expr ת��ֵ
    * @param scale ����ֵ��С�����λ������0������
    * @return ת������ֵ
    */
   public static double ROUND(double expr, int scale)
   {
       return new BigDecimal(expr).setScale(scale, BigDecimal.ROUND_HALF_UP).
           doubleValue() ;
   }

   /**
    * �������ֵ���������
    * @param expr ת��ֵ
    * @return ��ֵ��������
    */
   public static int FIX(double expr)
   {
       return (int) expr ;
   }

   /**
    * ȡ�����������ֵ
    * @param d1 double
    * @param d2 double
    * @return double
    */
   public static double MAX(double d1,double d2)
   {
       return Math.max(d1,d2);
   }

   /**
    * ȡ�������е���Сֵ
    * @param d1 double
    * @param d2 double
    * @return double
    */
   public static double MIN(double d1,double d2)
   {
       return Math.min(d1,d2);
   }

   /**
    * ���ؾ���ֵ
    * @param d1 double
    * @return double
    */
   public static double ABS(double d1)
   {
       return Math.abs(d1);
   }

   /**
    * �������ֵ��������֣����ڸ���:��������С�ڻ���� number �ĵ�һ��������
    * @param d1 double
    * @return double
    */
   public static double INT(double d1)
   {
       return Math.floor(d1);
   }
}
