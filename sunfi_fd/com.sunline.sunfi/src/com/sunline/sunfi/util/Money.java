/*******************************************************************************
 * $Header$
 * $Revision$
 * $Date$
 *
 *==============================================================================
 *
 * Copyright (c) 2001-2006 sunline Technologies, Ltd.
 * All rights reserved.
 * 
 * Created on 2010-11-8
 *******************************************************************************/


package com.sunline.sunfi.util;

/**
 * 
 * TODO fill class info here
 *
 * @author 安宣部 (mailto:anxb@sunline.cn)
 */

public class Money {
	/**
	 * 将金额转换成大写
	 * @param value
	 * @return
	 */
	public static String changeToBig(String value) {
        if (null == value || "".equals(value.trim())) {
            return "零";
        }

        String strCheck, strArr, strFen, strDW, strNum, strBig, strNow;
        double d = 0;
        try {
            d = Double.parseDouble(value);
        } catch (Exception e) {
            return "数据" + value + "非法！";
        }

        strCheck = value + ".";
        int dot = strCheck.indexOf(".");
        if (dot > 12) {
            return "数据" + value + "过大，无法处理！";
        }

        try {
            int i = 0;
            strBig = "";
            strDW = "";
            strNum = "";
            long intFen = (long) (d * 100);
            strFen = String.valueOf(intFen);
            int lenIntFen = strFen.length();
            while (lenIntFen != 0) {
                i++;
                switch (i) {
                case 1:
                    strDW = "分";
                    break;
                case 2:
                    strDW = "角";
                    break;
                case 3:
                    strDW = "元";
                    break;
                case 4:
                    strDW = "拾";
                    break;
                case 5:
                    strDW = "佰";
                    break;
                case 6:
                    strDW = "仟";
                    break;
                case 7:
                    strDW = "万";
                    break;
                case 8:
                    strDW = "拾";
                    break;
                case 9:
                    strDW = "佰";
                    break;
                case 10:
                    strDW = "仟";
                    break;
                case 11:
                    strDW = "亿";
                    break;
                case 12:
                    strDW = "拾";
                    break;
                case 13:
                    strDW = "佰";
                    break;
                case 14:
                    strDW = "仟";
                    break;
                }
                switch (strFen.charAt(lenIntFen - 1)) { //选择数字
                case '1':
                    strNum = "壹";
                    break;
                case '2':
                    strNum = "贰";
                    break;
                case '3':
                    strNum = "叁";
                    break;
                case '4':
                    strNum = "肆";
                    break;
                case '5':
                    strNum = "伍";
                    break;
                case '6':
                    strNum = "陆";
                    break;
                case '7':
                    strNum = "柒";
                    break;
                case '8':
                    strNum = "捌";
                    break;
                case '9':
                    strNum = "玖";
                    break;
                case '0':
                    strNum = "零";
                    break;
                }
                //处理特殊情况
                strNow = strBig;
                //分为零时的情况
                if ((i == 1) && (strFen.charAt(lenIntFen - 1) == '0')) {
                    strBig = "整";
                }
                //角为零时的情况
                else if ((i == 2) && (strFen.charAt(lenIntFen - 1) == '0')) { //角分同时为零时的情况
                    if (!strBig.equals("整")) {
                        strBig = "零" + strBig;
                    }
                }
                //元为零的情况
                else if ((i == 3) && (strFen.charAt(lenIntFen - 1) == '0')) {
                    strBig = "元" + strBig;
                }
                //拾－仟中一位为零且其前一位（元以上）不为零的情况时补零
                else if ((i < 7) && (i > 3) &&
                         (strFen.charAt(lenIntFen - 1) == '0') &&
                         (strNow.charAt(0) != '零') && (strNow.charAt(0) != '元')) {
                    strBig = "零" + strBig;
                }
                //拾－仟中一位为零且其前一位（元以上）也为零的情况时跨过
                else if ((i < 7) && (i > 3) &&
                         (strFen.charAt(lenIntFen - 1) == '0') &&
                         (strNow.charAt(0) == '零')) {}
                //拾－仟中一位为零且其前一位是元且为零的情况时跨过
                else if ((i < 7) && (i > 3) &&
                         (strFen.charAt(lenIntFen - 1) == '0') &&
                         (strNow.charAt(0) == '元')) {}
                //当万为零时必须补上万字
                else if ((i == 7) && (strFen.charAt(lenIntFen - 1) == '0')) {
                    strBig = "万" + strBig;
                }
                //拾万－仟万中一位为零且其前一位（万以上）不为零的情况时补零
                else if ((i < 11) && (i > 7) &&
                         (strFen.charAt(lenIntFen - 1) == '0') &&
                         (strNow.charAt(0) != '零') && (strNow.charAt(0) != '万')) {
                    strBig = "零" + strBig;
                }
                //拾万－仟万中一位为零且其前一位（万以上）也为零的情况时跨过
                else if ((i < 11) && (i > 7) &&
                         (strFen.charAt(lenIntFen - 1) == '0') &&
                         (strNow.charAt(0) == '万')) {}
                //拾万－仟万中一位为零且其前一位为万位且为零的情况时跨过
                else if ((i < 11) && (i > 7) &&
                         (strFen.charAt(lenIntFen - 1) == '0') &&
                         (strNow.charAt(0) == '零')) {}
                //万位为零且存在仟位和十万以上时，在万仟间补零
                else if ((i < 11) && (i > 8) &&
                         (strFen.charAt(lenIntFen - 1) == '0') &&
                         (strNow.charAt(0) == '万') && (strNow.charAt(2) == '仟')) {
                    strBig = strNum + strDW + "万零" +
                             strBig.substring(1, strBig.length());
                }
                //单独处理亿位
                else if (i == 11) {
                    //亿位为零且万全为零存在仟位时，去掉万补为零
                    if ((strFen.charAt(lenIntFen - 1) == '0') &&
                        (strNow.charAt(0) == '万') && (strNow.charAt(2) == '仟')) {
                        strBig = "亿" + "零" + strBig.substring(1, strBig.length());
                    }
                    //亿位为零且万全为零不存在仟位时，去掉万
                    else if ((strFen.charAt(lenIntFen - 1) == '0') &&
                             (strNow.charAt(0) == '万') &&
                             (strNow.charAt(2) != '仟')) {
                        strBig = "亿" + strBig.substring(1, strBig.length());
                    }
                    //亿位不为零且万全为零存在仟位时，去掉万补为零
                    else if ((strNow.charAt(0) == '万') &&
                             (strNow.charAt(2) == '仟')) {
                        strBig = strNum + strDW + "零" +
                                 strBig.substring(1, strBig.length());
                    }
                    //亿位不为零且万全为零不存在仟位时，去掉万
                    else if ((strNow.charAt(0) == '万') &&
                             (strNow.charAt(2) != '仟')) {
                        strBig = strNum + strDW +
                                 strBig.substring(1, strBig.length());
                    }
                    //其他正常情况
                    else {
                        strBig = strNum + strDW + strBig;
                    }
                }
                //拾亿－仟亿中一位为零且其前一位（亿以上）不为零的情况时补零
                else if ((i < 15) && (i > 11) &&
                         (strFen.charAt(lenIntFen - 1) == '0') &&
                         (strNow.charAt(0) != '零') && (strNow.charAt(0) != '亿')) {
                    strBig = "零" + strBig;
                }
                //拾亿－仟亿中一位为零且其前一位（亿以上）也为零的情况时跨过
                else if ((i < 15) && (i > 11) &&
                         (strFen.charAt(lenIntFen - 1) == '0') &&
                         (strNow.charAt(0) == '亿')) {}
                //拾亿－仟亿中一位为零且其前一位为亿位且为零的情况时跨过
                else if ((i < 15) && (i > 11) &&
                         (strFen.charAt(lenIntFen - 1) == '0') &&
                         (strNow.charAt(0) == '零')) {}
                //亿位为零且不存在仟万位和十亿以上时去掉上次写入的零
                else if ((i < 15) && (i > 11) &&
                         (strFen.charAt(lenIntFen - 1) != '0') &&
                         (strNow.charAt(0) == '零') && (strNow.charAt(1) == '亿') &&
                         (strNow.charAt(3) != '仟')) {
                    strBig = strNum + strDW + strBig.substring(1, strBig.length());
                }
                //亿位为零且存在仟万位和十亿以上时，在亿仟万间补零
                else if ((i < 15) && (i > 11) &&
                         (strFen.charAt(lenIntFen - 1) != '0') &&
                         (strNow.charAt(0) == '零') && (strNow.charAt(1) == '亿') &&
                         (strNow.charAt(3) == '仟')) {
                    strBig = strNum + strDW + "亿零" +
                             strBig.substring(2, strBig.length());
                } else {
                    strBig = strNum + strDW + strBig;
                }
                strFen = strFen.substring(0, lenIntFen - 1);
                lenIntFen--;
            }
            return strBig;
        } catch (Exception e) {
            return "";
        }
    }
	/**
	 * 
	 * @名称 numToBig
	 * @描述 整数变成大写
	 * @参数 @param str
	 * @参数 @return
	 * @返回值 String
	 * @作者 wangdf
	 * @时间 2014-7-9 上午10:16:36
	 */
	public static String numToBig(String str) {
		if(str==null||str.trim().equals("")){
			return "";
		}
		str = str.replace(" ", "");
		String str_tem = "";
		for(int i=1;i<=str.length();i++){
			String tem = str.substring(i-1,i);
			if(tem.matches("\\d")){
				str_tem = str_tem + tem;
			}
		}
		str_tem = Integer.valueOf(str_tem)+"";
		try {
            int i = 0;
            String strBig = "";
            String strDW = "";
            String strNum = "";
            int lenIntFen = str_tem.length();
            while (lenIntFen != 0) {
                switch (str_tem.charAt(i++)) { //选择数字
                case '1':
                    strNum = "壹";
                    break;
                case '2':
                    strNum = "贰";
                    break;
                case '3':
                    strNum = "叁";
                    break;
                case '4':
                    strNum = "肆";
                    break;
                case '5':
                    strNum = "伍";
                    break;
                case '6':
                    strNum = "陆";
                    break;
                case '7':
                    strNum = "柒";
                    break;
                case '8':
                    strNum = "捌";
                    break;
                case '9':
                    strNum = "玖";
                    break;
                case '0':
                    strNum = "零";
                    break;
                }
                switch (lenIntFen) {
                case 2:
                    strDW = "拾";
                    break;
                case 3:
                    strDW = "佰";
                    break;
                case 4:
                    strDW = "仟";
                    break;
                case 5:
                    strDW = "万";
                    break;
                case 6:
                    strDW = "拾";
                    break;
                case 7:
                    strDW = "佰";
                    break;
                case 8:
                    strDW = "仟";
                    break;
                case 9:
                    strDW = "亿";
                    break;
                case 10:
                    strDW = "拾";
                    break;
                case 11:
                    strDW = "佰";
                    break;
                case 12:
                    strDW = "仟";
                    break;
                default:
                	strDW = "";
                	break;
                }
                strBig = strBig + strNum + strDW;
                lenIntFen--;
            }
            return strBig;
        } catch (Exception e) {
            return "";
        }
	}
}
