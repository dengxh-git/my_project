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
 * @author ������ (mailto:anxb@sunline.cn)
 */

public class Money {
	/**
	 * �����ת���ɴ�д
	 * @param value
	 * @return
	 */
	public static String changeToBig(String value) {
        if (null == value || "".equals(value.trim())) {
            return "��";
        }

        String strCheck, strArr, strFen, strDW, strNum, strBig, strNow;
        double d = 0;
        try {
            d = Double.parseDouble(value);
        } catch (Exception e) {
            return "����" + value + "�Ƿ���";
        }

        strCheck = value + ".";
        int dot = strCheck.indexOf(".");
        if (dot > 12) {
            return "����" + value + "�����޷�����";
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
                    strDW = "��";
                    break;
                case 2:
                    strDW = "��";
                    break;
                case 3:
                    strDW = "Ԫ";
                    break;
                case 4:
                    strDW = "ʰ";
                    break;
                case 5:
                    strDW = "��";
                    break;
                case 6:
                    strDW = "Ǫ";
                    break;
                case 7:
                    strDW = "��";
                    break;
                case 8:
                    strDW = "ʰ";
                    break;
                case 9:
                    strDW = "��";
                    break;
                case 10:
                    strDW = "Ǫ";
                    break;
                case 11:
                    strDW = "��";
                    break;
                case 12:
                    strDW = "ʰ";
                    break;
                case 13:
                    strDW = "��";
                    break;
                case 14:
                    strDW = "Ǫ";
                    break;
                }
                switch (strFen.charAt(lenIntFen - 1)) { //ѡ������
                case '1':
                    strNum = "Ҽ";
                    break;
                case '2':
                    strNum = "��";
                    break;
                case '3':
                    strNum = "��";
                    break;
                case '4':
                    strNum = "��";
                    break;
                case '5':
                    strNum = "��";
                    break;
                case '6':
                    strNum = "½";
                    break;
                case '7':
                    strNum = "��";
                    break;
                case '8':
                    strNum = "��";
                    break;
                case '9':
                    strNum = "��";
                    break;
                case '0':
                    strNum = "��";
                    break;
                }
                //�����������
                strNow = strBig;
                //��Ϊ��ʱ�����
                if ((i == 1) && (strFen.charAt(lenIntFen - 1) == '0')) {
                    strBig = "��";
                }
                //��Ϊ��ʱ�����
                else if ((i == 2) && (strFen.charAt(lenIntFen - 1) == '0')) { //�Ƿ�ͬʱΪ��ʱ�����
                    if (!strBig.equals("��")) {
                        strBig = "��" + strBig;
                    }
                }
                //ԪΪ������
                else if ((i == 3) && (strFen.charAt(lenIntFen - 1) == '0')) {
                    strBig = "Ԫ" + strBig;
                }
                //ʰ��Ǫ��һλΪ������ǰһλ��Ԫ���ϣ���Ϊ������ʱ����
                else if ((i < 7) && (i > 3) &&
                         (strFen.charAt(lenIntFen - 1) == '0') &&
                         (strNow.charAt(0) != '��') && (strNow.charAt(0) != 'Ԫ')) {
                    strBig = "��" + strBig;
                }
                //ʰ��Ǫ��һλΪ������ǰһλ��Ԫ���ϣ�ҲΪ������ʱ���
                else if ((i < 7) && (i > 3) &&
                         (strFen.charAt(lenIntFen - 1) == '0') &&
                         (strNow.charAt(0) == '��')) {}
                //ʰ��Ǫ��һλΪ������ǰһλ��Ԫ��Ϊ������ʱ���
                else if ((i < 7) && (i > 3) &&
                         (strFen.charAt(lenIntFen - 1) == '0') &&
                         (strNow.charAt(0) == 'Ԫ')) {}
                //����Ϊ��ʱ���벹������
                else if ((i == 7) && (strFen.charAt(lenIntFen - 1) == '0')) {
                    strBig = "��" + strBig;
                }
                //ʰ��Ǫ����һλΪ������ǰһλ�������ϣ���Ϊ������ʱ����
                else if ((i < 11) && (i > 7) &&
                         (strFen.charAt(lenIntFen - 1) == '0') &&
                         (strNow.charAt(0) != '��') && (strNow.charAt(0) != '��')) {
                    strBig = "��" + strBig;
                }
                //ʰ��Ǫ����һλΪ������ǰһλ�������ϣ�ҲΪ������ʱ���
                else if ((i < 11) && (i > 7) &&
                         (strFen.charAt(lenIntFen - 1) == '0') &&
                         (strNow.charAt(0) == '��')) {}
                //ʰ��Ǫ����һλΪ������ǰһλΪ��λ��Ϊ������ʱ���
                else if ((i < 11) && (i > 7) &&
                         (strFen.charAt(lenIntFen - 1) == '0') &&
                         (strNow.charAt(0) == '��')) {}
                //��λΪ���Ҵ���Ǫλ��ʮ������ʱ������Ǫ�䲹��
                else if ((i < 11) && (i > 8) &&
                         (strFen.charAt(lenIntFen - 1) == '0') &&
                         (strNow.charAt(0) == '��') && (strNow.charAt(2) == 'Ǫ')) {
                    strBig = strNum + strDW + "����" +
                             strBig.substring(1, strBig.length());
                }
                //����������λ
                else if (i == 11) {
                    //��λΪ������ȫΪ�����Ǫλʱ��ȥ����Ϊ��
                    if ((strFen.charAt(lenIntFen - 1) == '0') &&
                        (strNow.charAt(0) == '��') && (strNow.charAt(2) == 'Ǫ')) {
                        strBig = "��" + "��" + strBig.substring(1, strBig.length());
                    }
                    //��λΪ������ȫΪ�㲻����Ǫλʱ��ȥ����
                    else if ((strFen.charAt(lenIntFen - 1) == '0') &&
                             (strNow.charAt(0) == '��') &&
                             (strNow.charAt(2) != 'Ǫ')) {
                        strBig = "��" + strBig.substring(1, strBig.length());
                    }
                    //��λ��Ϊ������ȫΪ�����Ǫλʱ��ȥ����Ϊ��
                    else if ((strNow.charAt(0) == '��') &&
                             (strNow.charAt(2) == 'Ǫ')) {
                        strBig = strNum + strDW + "��" +
                                 strBig.substring(1, strBig.length());
                    }
                    //��λ��Ϊ������ȫΪ�㲻����Ǫλʱ��ȥ����
                    else if ((strNow.charAt(0) == '��') &&
                             (strNow.charAt(2) != 'Ǫ')) {
                        strBig = strNum + strDW +
                                 strBig.substring(1, strBig.length());
                    }
                    //�����������
                    else {
                        strBig = strNum + strDW + strBig;
                    }
                }
                //ʰ�ڣ�Ǫ����һλΪ������ǰһλ�������ϣ���Ϊ������ʱ����
                else if ((i < 15) && (i > 11) &&
                         (strFen.charAt(lenIntFen - 1) == '0') &&
                         (strNow.charAt(0) != '��') && (strNow.charAt(0) != '��')) {
                    strBig = "��" + strBig;
                }
                //ʰ�ڣ�Ǫ����һλΪ������ǰһλ�������ϣ�ҲΪ������ʱ���
                else if ((i < 15) && (i > 11) &&
                         (strFen.charAt(lenIntFen - 1) == '0') &&
                         (strNow.charAt(0) == '��')) {}
                //ʰ�ڣ�Ǫ����һλΪ������ǰһλΪ��λ��Ϊ������ʱ���
                else if ((i < 15) && (i > 11) &&
                         (strFen.charAt(lenIntFen - 1) == '0') &&
                         (strNow.charAt(0) == '��')) {}
                //��λΪ���Ҳ�����Ǫ��λ��ʮ������ʱȥ���ϴ�д�����
                else if ((i < 15) && (i > 11) &&
                         (strFen.charAt(lenIntFen - 1) != '0') &&
                         (strNow.charAt(0) == '��') && (strNow.charAt(1) == '��') &&
                         (strNow.charAt(3) != 'Ǫ')) {
                    strBig = strNum + strDW + strBig.substring(1, strBig.length());
                }
                //��λΪ���Ҵ���Ǫ��λ��ʮ������ʱ������Ǫ��䲹��
                else if ((i < 15) && (i > 11) &&
                         (strFen.charAt(lenIntFen - 1) != '0') &&
                         (strNow.charAt(0) == '��') && (strNow.charAt(1) == '��') &&
                         (strNow.charAt(3) == 'Ǫ')) {
                    strBig = strNum + strDW + "����" +
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
	 * @���� numToBig
	 * @���� ������ɴ�д
	 * @���� @param str
	 * @���� @return
	 * @����ֵ String
	 * @���� wangdf
	 * @ʱ�� 2014-7-9 ����10:16:36
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
                switch (str_tem.charAt(i++)) { //ѡ������
                case '1':
                    strNum = "Ҽ";
                    break;
                case '2':
                    strNum = "��";
                    break;
                case '3':
                    strNum = "��";
                    break;
                case '4':
                    strNum = "��";
                    break;
                case '5':
                    strNum = "��";
                    break;
                case '6':
                    strNum = "½";
                    break;
                case '7':
                    strNum = "��";
                    break;
                case '8':
                    strNum = "��";
                    break;
                case '9':
                    strNum = "��";
                    break;
                case '0':
                    strNum = "��";
                    break;
                }
                switch (lenIntFen) {
                case 2:
                    strDW = "ʰ";
                    break;
                case 3:
                    strDW = "��";
                    break;
                case 4:
                    strDW = "Ǫ";
                    break;
                case 5:
                    strDW = "��";
                    break;
                case 6:
                    strDW = "ʰ";
                    break;
                case 7:
                    strDW = "��";
                    break;
                case 8:
                    strDW = "Ǫ";
                    break;
                case 9:
                    strDW = "��";
                    break;
                case 10:
                    strDW = "ʰ";
                    break;
                case 11:
                    strDW = "��";
                    break;
                case 12:
                    strDW = "Ǫ";
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
