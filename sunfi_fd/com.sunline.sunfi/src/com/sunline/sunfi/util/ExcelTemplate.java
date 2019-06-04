/*******************************************************************************
 * $Header$
 * $Revision$ v1.2
 * $Date$ 2010-08-28
 *
 *==============================================================================
 *
 * Copyright (c) 2001-2010 sunliune Technologies, Ltd.
 * All rights reserved.
 * 
 * Created on 2010-8-28
 *******************************************************************************/
package com.sunline.sunfi.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Vector;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.Region;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;

import com.eos.data.xpath.XPathLocator;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseUtil;
import com.primeton.data.sdo.impl.PropertyImpl;
import com.primeton.data.sdo.impl.TypeReference;
import com.primeton.data.sdo.impl.types.BooleanType;
import com.primeton.data.sdo.impl.types.DateTimeType;
import com.primeton.data.sdo.impl.types.DateType;
import com.primeton.data.sdo.impl.types.DecimalType;
import com.primeton.data.sdo.impl.types.FloatType;
import com.primeton.data.sdo.impl.types.IntType;
import com.primeton.data.sdo.impl.types.IntegerType;
import com.primeton.data.sdo.impl.types.LongType;
import commonj.sdo.DataObject;
import commonj.sdo.Type;

/**
 *
 * Excelģ��ʵ����<BR>
 * ʵ��ͨ���Զ���Excel����ģ��,���������䵽ģ����Ӧλ�ã��Զ����������ָ�����ļ�������Excelģ�����ù�ʽ�����÷������£�<BR>
 * <pre>
 *     ExcelTemplate template=new ExcelTemplate(templateFilePath,outputFilePath)
 *     //template.setIncludeFormula(true);���ð�����ʽ
 *     template.generate(ResultSet);//resultsetΪArrayList����,��������Map��װ
 *     //template.generate(titleMap,dataList)//��ʾ������ϸ����Ϣ
 * </pre>
 *
 *
 */

public class ExcelTemplate {

	/**
	 * ģ���ļ���
	 */
	private String templateFile;

	/**
	 * ����ļ���
	 */
	private String outputFile;

	/**
	 * Excelģ�嶨�������ֶ�������
	 */
	private String[] fieldNames;

	/**
	 * �������ʼ��,Ĭ��Ϊ-1,�����
	 */
	private int startRow=-1;

	private int tempStartRowNum=-1;

	/**
	 * Ĭ�������С
	 */
	private int fontSize=10;
	/**
	 * Ĭ������
	 */
	private String fontName="����";

	/**
	 * �Ƿ�������Ϣ�������߿�,Ĭ����������ñ߿�
	 */
	private boolean titleCellBold=false;

	/**
	 * �Ƿ����ÿհ����߿�Ĭ����������ñ߿�
	 */
	private boolean blankCellBold=false;
	/**
	 * �Ƿ��Զ��ֹ�����
	 */
	private boolean autoSheet=false;
	/**
	 * �Ƿ��Զ���ҳ
	 */
	private boolean autoPagination=false;
	/**
	 * ��ҳ����
	 */
	private int maxrow=-1;
	/**
	 * �Ƿ��й�ʽ
	 */
	private boolean hasFormula=false;

	/**
	 * �ؼ���
	 * &-��ʾģ����Ϣ�����ֶ�
	 * #-��ʾģ����ϸ�����ֶ�
	 * formula-��ʾģ�溯���ؼ���
	 * ~-��ʾCell��ǰ�У�������":"ʱ����ʾ��ǰ�м�1
	 */
	private final String TITLE_FLAG="&";
	private final String CONTENT_FLAG="#";
	private final String FORMULA_FLAG="formula";
	private final String UNLIMIT_FLAG="~";
	private final String FIELD_AUTO_ID="_id";

	/**
	 * ��ʽ�����������
	 */
	private final String[] OP_FLAG=new String[]{"+","-","*","/","%",":"};

	/**
	 * Ĭ�Ϲ��캯��
	 *
	 */
	public ExcelTemplate(){

	}
	/**
	 * ������
	 * @param templateFile ģ���ļ�
	 * @param outputFile ����ļ�
	 */
	public ExcelTemplate(String templateFile,String outputFile){
		this.templateFile=templateFile;
		this.outputFile=outputFile;
	}

	/**
	 * ����ģ���ļ��Ƿ����Excel��ʽ
	 * @param hasFormula
	 */
	public void setIncludeFormula(boolean hasFormula){
		this.hasFormula=hasFormula;
	}

	/**
	 * ���ñ������Ƿ���Ҫ�߿�
	 * @param b
	 */
	public void setTitleCellBold(boolean titleCellBold){
		this.titleCellBold=titleCellBold;
	}

	/**
	 * ���ÿհ����Ƿ���Ҫ��ʾ�߿�
	 * @param blankCellBold
	 */
	public void setBlankCellBold(boolean blankCellBold){
		this.blankCellBold=blankCellBold;
	}

	/**
	 * �����Ƿ�ֹ�����
	 * @param b
	 */
	public void setAutoSheet(boolean autoSheet){
		this.autoSheet=autoSheet;
		this.autoPagination=(autoSheet?false:autoPagination);
	}
	/**
	 * �Ƿ��Զ���ҳ
	 * @param autoPagination
	 */
	public void setAutoPagination(boolean autoPagination){
		this.autoPagination=autoPagination;
		this.autoSheet=(autoPagination?false:autoSheet);
	}
	/**
	 * ���÷�ҳ�����
	 * @param maxrow
	 */
	public void setMaxRow(int maxrow){
		this.maxrow=maxrow;
	}
	/**
	 * ���������С��Ĭ��10������
	 * @param size
	 */
	public void setFontSize(int size){
		this.fontSize=size;
	}

	public void setFontName(String fontName){
		this.fontName=fontName;
	}

	/**
	 * ��ʼ������ģ�棬��ȡģ��������ʼ��(start)�Լ���Ӧ�ֶ����λ��(fieldNames)
	 * @param sheet
	 */
	private void initialize(HSSFSheet sheet){
        boolean setStart=false;
        int rows  = sheet.getPhysicalNumberOfRows();

        for (int r = 0; r < rows; r++){
            HSSFRow row   = sheet.getRow(r);

            if (row != null) {
                int cells = row.getPhysicalNumberOfCells();
                for(short c = 0; c < cells; c++){
                	HSSFCell cell  = row.getCell(c);
                	if(cell!=null)
                	{
                		String value=null;
                		if(cell.getCellType()==HSSFCell.CELL_TYPE_NUMERIC){
                			value=""+cell.getNumericCellValue();
                		}else if(cell.getCellType()==HSSFCell.CELL_TYPE_BOOLEAN){
                			value=""+cell.getBooleanCellValue();
                		}else{
                			value=cell.getRichStringCellValue().getString();
                		}
                    	if(value!=null&&!"".equals(value))
                    	{
                    		value=value.trim();
                    		//��������
                    		if(value.startsWith(CONTENT_FLAG)){
                        		if(!setStart){
                        			this.startRow=r;//�������������ʼ��
                        			this.fieldNames=new String[cells];
                        			setStart=true;
                        		}
                        		this.fieldNames[c]=value.substring(1);//��ʼ�������ֶ�
                    		}

                    	}

                	}

                }
            }
        }

	}

	/**
	 * ���㹫ʽ,Ĭ�Ϸ�Χ��0�е���������β
	 * @param wb
	 * @param sheet
	 */
	private void calcFormula(HSSFWorkbook wb,HSSFSheet sheet){
		this.calcFormula(wb,sheet,0,sheet.getPhysicalNumberOfRows());
	}

	/**
	 * ���㹫ʽ����,��Χ�ӿ�ʼ��(start_row)��������(end_row)
	 * @param wb HSSFWorkbook
	 * @param sheet HSSFSHeet
	 * @param start_rang
	 * @param end_rang
	 */
	private void calcFormula(HSSFWorkbook wb,HSSFSheet sheet,int start_rang,int end_rang){
        //int rows  = sheet.getPhysicalNumberOfRows();
		HSSFCellStyle borderStyle=this.getBorderStyle(wb);
		HSSFCellStyle noneStyle=this.getNoneStyle(wb);		
        for (int r = start_rang; r < end_rang; r++){
            HSSFRow row   = sheet.getRow(r);
            if (row != null) {
                int cells = row.getPhysicalNumberOfCells();
                for(short c = 0; c < cells; c++){
                	HSSFCell cell  = row.getCell(c);
                	if(cell!=null){
                		if(cell.getCellType()==HSSFCell.CELL_TYPE_STRING){
                        	String value=cell.getRichStringCellValue().getString();
                        	if(value!=null){
                        		value=value.trim().toLowerCase();
                        		if(value.startsWith(FORMULA_FLAG))
                        		{
                        			int index=value.indexOf("=");
                        			String formula=value.substring(index+1);
                        			//�жϺ����Ƿ������#��ͷ,�������#��ͷ��ʾ������ʾ�߿�
                        			String flag=formula.substring(0,1);
                        			boolean showBold=false;
                        			if(flag.equals(CONTENT_FLAG)){
                        				formula=formula.substring(1);
                        				showBold=true;
                        			}
                       			   //�������':'������ͳ�ƹ�ʽ��������ǰ��,�����������ʽѭ�����ô���.
                        			if(formula.indexOf(":")!=-1){
                        				formula=formula.replaceAll(UNLIMIT_FLAG,r+"").toUpperCase();
                        			}else{
                        				formula=formula.replaceAll(UNLIMIT_FLAG,(r+1)+"").toUpperCase();
                        			}

                        			//�жϹ�ʽ��Ӧ��Cell�����Ƿ�Ϊblank,
                        			//�����ʽ��Ӧ��CELL����Ϊ�գ�������Ϊ""
                        			int rightIndex=formula.indexOf(")");
                        			int leftIndex=formula.indexOf("(");
                        			String content=formula.substring(leftIndex+1,rightIndex);
                        			int opIndex=this.getOpIndex(content);
                        			String startPos=content.substring(0,opIndex);
                        			String endPos=content.substring(opIndex+1);

                        			int start_col=this.getColumnIndex(startPos.charAt(0));
                    				int start_row=Integer.parseInt(startPos.substring(1));
                    				int end_col=this.getColumnIndex(endPos.charAt(0));
                    				int end_row=Integer.parseInt(endPos.substring(1));

                    				HSSFCell startC=sheet.getRow(start_row-1).getCell((short)start_col);
                    				HSSFCell endC=sheet.getRow(end_row-1).getCell((short)end_col);

                    				//�жϹ�ʽ��ʼCell�����cell�����Ƿ���Ч
                    				//��Ϊ��Ϊ��Ч��cellֵ�����ҵ�ǰ��ʽ������":"�������ù�ʽ������Ϊ""��
                    				//����":" ������Ϊ���㹫ʽ
                    				if(invalidCellValue(startC)&&invalidCellValue(endC)){
                    					if(formula.indexOf(":")==-1){
                    						cell.setCellValue( new HSSFRichTextString(""));
                    					}else{
    	                        			cell=row.createCell((short)c);
    	                        			cell.setCellType(HSSFCell.CELL_TYPE_FORMULA);
    	                        			cell.setCellFormula(formula);
                    					}
                    				}else{
	                        			//�ؽ�Cell
	                        			cell=row.createCell((short)c);
	                        			cell.setCellType(HSSFCell.CELL_TYPE_FORMULA);
	                        			cell.setCellFormula(formula);
                    				}

                        			if(showBold){
                        				cell.setCellStyle(borderStyle);
                        			}else{
                        				cell.setCellStyle(noneStyle);
                        			}


                        		}
                        	}
                		}
                	}

                }
            }
        }
	}

	/**
	 * ���ù�ʽ�ı���Ϊ�հ�������ͳ�ƿ�ʼ�м�1==startRowNumʱ
	 * @param cell
	 * @param startRowNum
	 */
	private void setFormulaBlankCell(HSSFCell cell,int startRowNum){
    	if (cell != null) {
			if (cell.getCellType() == HSSFCell.CELL_TYPE_STRING) {
				String value = cell.getRichStringCellValue().getString();
				if (value != null) {
					value = value.trim().toLowerCase();
					if (value.startsWith(FORMULA_FLAG)) {
						int index = value.indexOf("=");
						String formula = value.substring(index + 1);
						String flag = formula.substring(0, 1);
						if (flag.equals(CONTENT_FLAG))formula = formula.substring(1);
						if (formula.indexOf(":") != -1) {
							int rightIndex = formula.indexOf(")");
							int leftIndex = formula.indexOf("(");
							String content = formula.substring(leftIndex + 1,rightIndex).toUpperCase();
							int opIndex = this.getOpIndex(content);
							String startPos = content.substring(0, opIndex);
							String colValue = startPos.substring(1,opIndex);
							if(Integer.parseInt(colValue)-1==startRowNum)
								cell.setCellType(HSSFCell.CELL_TYPE_BLANK);
						}
					}
				}
			}
		}



	}

	/**
	 * �������ģ���������
	 *
	 * @param titleMap
	 * @param wb
	 * @param sheet
	 * @throws Exception
	 */
	private void generateTitleDatas(DataObject exportInfo,HSSFWorkbook wb,HSSFSheet sheet)throws Exception{
        int rows  = sheet.getPhysicalNumberOfRows();
        HSSFCellStyle borderStyle=this.getBorderStyle(wb);
        HSSFCellStyle noneStyle=this.getNoneStyle(wb);        
        for (int r = 0; r < rows; r++){
            HSSFRow row   = sheet.getRow(r);
            if (row != null) {

                int cells =row.getPhysicalNumberOfCells();
                for(short c = 0; c < cells; c++){
                	HSSFCell cell  = row.getCell(c);
                	if(cell!=null){
                		if(cell.getCellType()==HSSFCell.CELL_TYPE_STRING){
                        	String value=cell.getRichStringCellValue().getString();
                        	if(value!=null){
                        		value=value.trim();
                        		if(value.startsWith(TITLE_FLAG)){
                        			value=value.substring(1);
                        			//��ȡ��Ӧ��ֵ��֧��XPATHȡֵ
                        			Object obj=XPathLocator.newInstance().getValue(exportInfo, value);
                        			String content=obj+"";

                        			//String content=exportInfo.getString(value);
                        			if(content==null)content="";
                        			//�ؽ�Cell��������ֵ
                        			cell=row.createCell((short)c);                        			
                        			cell.setCellType(HSSFCell.CELL_TYPE_STRING);                        			
                        			cell.setCellValue( new HSSFRichTextString(content));

                        			if(!titleCellBold){
                        				cell.setCellStyle(noneStyle);
                        			}else{
                        				cell.setCellStyle(borderStyle);
                        			}
                        		}
                        	}
                		}
                	}

                }
            }
        }
	}


	/**
	 * ��ָ���Ķ�������resulset�����ָ����Excelλ��
	 * @param resultset List<DataObject>��������
	 * @param wb HSSFWorkbook
	 * @param sheet HSSFSheet
	 */
	private void generateContentDatas(List<DataObject> resultset,HSSFWorkbook wb,HSSFSheet sheet){
		HSSFCellStyle borderStyle=this.getBorderStyle(wb);
		HSSFCellStyle noneStyle=this.getNoneStyle(wb);

		//Ĭ���к�
		int autoRowId=1;

        for(Iterator it=resultset.iterator();it.hasNext();autoRowId++){
        	DataObject content=(DataObject)it.next();

        	HSSFRow sourceRow=sheet.getRow(startRow);
        	HSSFRow row=sheet.createRow(startRow++);

        	for(int i=0;i<sourceRow.getPhysicalNumberOfCells();i++){
        		//����Զ����ɵ��к�
        		if(fieldNames[i]!=null&&fieldNames[i].equals(FIELD_AUTO_ID)){
          			HSSFCell cell=row.createCell((short)i);        			
        			cell.setCellStyle(borderStyle);
        			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
    				cell.setCellValue(autoRowId);
    				continue;
        		}

        		if(fieldNames[i]!=null){
        			HSSFCell cell=row.createCell((short)i);        			
        			cell.setCellStyle(borderStyle);
        			if(content!=null){
        				//�ֶ���֧��xpathȡֵ
        				Object value=XPathLocator.newInstance().getValue(content, fieldNames[i]);

            			//Object value=content.get(fieldNames[i]);
            			if(value!=null){
    	        			if(value instanceof Double|| value instanceof BigDecimal){
    	        				cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
    	        				cell.setCellValue(Double.parseDouble(value.toString()));
    	        			}else{
    	        				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
    	        				cell.setCellValue(new HSSFRichTextString(value.toString()));
    	        			}
            			}else{
            				cell.setCellType(HSSFCell.CELL_TYPE_BLANK);
            			}

        			}else{

        				cell.setCellType(HSSFCell.CELL_TYPE_BLANK);
        				if(!blankCellBold){
        					cell.setCellStyle(noneStyle);
        				}else{
        					cell.setCellStyle(borderStyle);
        				}
        			}
        		}else{
    				HSSFCell sourceCell=sourceRow.getCell((short)i);
    				if(sourceCell!=null&&
    						sourceCell.getCellType()==HSSFCell.CELL_TYPE_STRING&&
    						sourceCell.getRichStringCellValue().getString()!=null&&
    						sourceCell.getRichStringCellValue().getString().toLowerCase().startsWith(FORMULA_FLAG)){

	    				HSSFCell cell=row.createCell((short)i);
	    				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
	    				cell.setCellValue(sourceCell.getRichStringCellValue());
    				}
    			}
        	}

        	if(it.hasNext()){
        		//����ƽ��һ��
        		//sheet.shiftRows(startRow-1,sheet.getLastRowNum(),1);
        		shiftDown(sheet,startRow-1, sheet.getLastRowNum(), 1);
        	}

        }
	}
	/**
	 * ���������䵽Excelģ��,resultset��������Map��װ��
	 * @param
	 * @param resultset ��������
	 * @throws Exception
	 */
	public void generate(List<DataObject> resultset)throws Exception{
		this.generate(resultset,null);

	}
	/**
	 * ���������䵽Excelģ��,resultset��������Map��װ��
	 * @param titleMap ������Ϣ
	 * @param resultset �����
	 * @throws Exception
	 */
	public void generate(List<DataObject> resultset,DataObject exportInfo)throws Exception{
        POIFSFileSystem fs =new POIFSFileSystem(new FileInputStream(templateFile));
        HSSFWorkbook wb = new HSSFWorkbook(fs);
        HSSFSheet sheet = wb.getSheetAt(0);
        initialize(sheet);
        if(startRow==-1)
        	return ;


        if(this.autoPagination){
        	this.generatePagination(wb,sheet,resultset,exportInfo);
        }
        else if(this.autoSheet){
        	generatePaginationSheet(wb,sheet,resultset,exportInfo);
        }
        else{
            //��������
            if(exportInfo!=null)
            	this.generateTitleDatas(exportInfo,wb,sheet);
            //������������
            this.generateContentDatas(resultset,wb,sheet);
            if(hasFormula){
            	this.calcFormula(wb,sheet);
            }
        }
        FileOutputStream fileOut = new FileOutputStream(outputFile);
        wb.write(fileOut);
        fileOut.close();
	}

	/**
	 * EXCEL��ҳ
	 * ������EXCELģ������һ�в���EXCEL��ҳ��!
	 * @param wb HSSFWorkbook
	 * @param sourceSheet HSSFSheet
	 * @param resultset ������ݼ�
	 * @param titleMap ��Ϣ������
	 * @throws Exception
	 */
	private void generatePagination(HSSFWorkbook wb,HSSFSheet sourceSheet,List<DataObject> resultset,DataObject exportInfo)throws Exception{
    	int startPosition=startRow;
    	tempStartRowNum=startRow;
    	int count=resultset.size() / maxrow;
    	int num=resultset.size() % maxrow;
    	int rows=sourceSheet.getPhysicalNumberOfRows();
    	System.out.println("rows="+rows);
    	if(num>0){
    		count=count+1;
    		num=maxrow-num;
    		//����ָ����maxrow����ӿ���
    		for(int i=0;i<num;i++){
    			resultset.add(null);
    		}
    	}
    	//ɾ�����һ�еķ�ҳ��
    	try{
    		sourceSheet.removeRowBreak(rows-1);
    	}catch(NullPointerException npe){
    		throw new Exception("ָ����EXCELģ���ļ�["+this.templateFile+"] δ�����ҳ��");
    	}
    	//����1ҳ������ҳ��
    	for(int i=1;i<count;i++){
    		//���÷�ҳ��
    		sourceSheet.setRowBreak(i*rows-1);
    		this.copyRows(sourceSheet,sourceSheet,0,rows,i*rows+1);

    	}
    	if(exportInfo!=null)
    		this.generateTitleDatas(exportInfo,wb,sourceSheet);

    	int current_page=0;
    	while(current_page<count){
    		List<DataObject> newList=resultset.subList(current_page*maxrow,maxrow*(current_page+1));
    		this.generateContentDatas(newList,wb,sourceSheet);
    		current_page++;
    		//������һ�е����������ʼλ��
    		startRow=current_page*rows+maxrow+startPosition;
    	}
        if(hasFormula)
        	this.calcFormula(wb,sourceSheet);

	}


	/**
	 * ���ɷ�ҳ�Ĺ�����ģ��
	 * @param wb HSSFWorkbook
	 * @param sourceSheet HSSFSheet
	 * @param resultset ������ݼ�
	 * @param titleMap ��Ϣ(����)������
	 */
	private void generatePaginationSheet(HSSFWorkbook wb,HSSFSheet sourceSheet,List<DataObject> resultset,DataObject exportInfo)throws Exception{
    	int startPosition=startRow;
    	int count=resultset.size() / maxrow;
    	int num=resultset.size() % maxrow;

    	if(num>0){
    		count=count+1;
    		num=maxrow-num;
    		//����ָ����maxrow����ӿ���
    		for(int i=0;i<num;i++){
    			resultset.add(null);
    		}

    	}
    	for(int i=1;i<count;i++){
    		HSSFSheet newsheet=wb.createSheet("Page "+i);
    		this.copyRows(sourceSheet,newsheet,0,sourceSheet.getLastRowNum(),0);
    	}

    	if(count>1){
    		for(int i=0;i<wb.getNumberOfSheets();i++){
    			startRow=startPosition;
    			List<DataObject> newList=resultset.subList(i*maxrow,maxrow*(i+1));
    			HSSFSheet sheet=wb.getSheetAt(i);
    	        //��������
    	        if(exportInfo!=null)
    	        	this.generateTitleDatas(exportInfo,wb,sheet);
                this.generateContentDatas(newList,wb,sheet);
                if(hasFormula)
                	this.calcFormula(wb,sheet);
    		}
    	}else{
			HSSFSheet sheet=wb.getSheetAt(0);
	        if(exportInfo!=null)
	        	this.generateTitleDatas(exportInfo,wb,sheet);

            this.generateContentDatas(resultset,wb,sheet);
            if(hasFormula)
            	this.calcFormula(wb,sheet);

    	}
	}

	private HSSFCellStyle getBorderStyle(HSSFWorkbook wb){
        HSSFCellStyle style = wb.createCellStyle();
        HSSFFont font=wb.createFont();
        font.setFontHeightInPoints((short)fontSize);
        font.setFontName(fontName);
        style.setFont(font);
        style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        style.setBorderRight(HSSFCellStyle.BORDER_THIN);
        style.setBorderTop(HSSFCellStyle.BORDER_THIN);
        return style;
	}
	private HSSFCellStyle getNoneStyle(HSSFWorkbook wb){
        HSSFCellStyle style = wb.createCellStyle();
        HSSFFont font=wb.createFont();
        font.setFontHeightInPoints((short)fontSize);
        font.setFontName(fontName);
        style.setFont(font);
        style.setBorderBottom(HSSFCellStyle.BORDER_NONE);
        style.setBorderLeft(HSSFCellStyle.BORDER_NONE);
        style.setBorderRight(HSSFCellStyle.BORDER_NONE);
        style.setBorderTop(HSSFCellStyle.BORDER_NONE);
        return style;
	}


	/**
     * ����ƽ�Ʊ�񣬲����Ƹ�ʽ������
     * @param thisrow����ǰ�к�
     * @param lastrow������к�
     * @param shiftcount��ƽ����
     */
    private void shiftDown(HSSFSheet sheet,int thisrow, int lastrow, int shiftcount) {
        sheet.shiftRows(thisrow, lastrow, shiftcount);

        for (int z = 0; z < shiftcount; z++) {
            HSSFRow row = sheet.getRow(thisrow);
            HSSFRow oldrow = sheet.getRow(thisrow + shiftcount);
            //�����е��и߸���
            oldrow.setHeight(row.getHeight());
            //��������Ԫ��ĸ�ʽ����
            for (short i = 0; i <= oldrow.getPhysicalNumberOfCells(); i++) {

                HSSFCell cell = row.createCell(i);
                HSSFCell oldcell = oldrow.getCell(i);

                if (oldcell != null) {                    
                    switch(oldcell.getCellType()){
                    case HSSFCell.CELL_TYPE_STRING:
                    	cell.setCellType(HSSFCell.CELL_TYPE_STRING);
                    	cell.setCellValue(oldcell.getRichStringCellValue());
                    	break;
                    case HSSFCell.CELL_TYPE_NUMERIC:
                    	cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
                    	cell.setCellValue(oldcell.getNumericCellValue());
                    	break;
                    default:
                    	cell.setCellType(HSSFCell.CELL_TYPE_STRING);
                    	cell.setCellValue(oldcell.getRichStringCellValue());

                    }
                    cell.setCellStyle(oldcell.getCellStyle());
                 }
            }

            //�����п�Խ�ĸ���
            Vector regs = findRegion(sheet,oldrow);
            if (regs.size() != 0) {
                for (int i = 0; i < regs.size(); i++) {
                    Region reg = (Region) regs.get(i);
                    reg.setRowFrom(row.getRowNum());
                    reg.setRowTo(row.getRowNum());
                    sheet.addMergedRegion(reg);
                }
            }
            thisrow++;
        }
    }

     /**
     * �������еĺϲ���Ԫ��
     * @param oldrow
     * @return
     */
    private Vector findRegion(HSSFSheet sheet ,HSSFRow oldrow) {
        Vector<Region> regs = new Vector<Region>();
        int num = sheet.getNumMergedRegions();
        int curRowid = oldrow.getRowNum();
        for (int i = 0; i < num; i++) {
            Region reg = sheet.getMergedRegionAt(i);
            if (reg.getRowFrom() == reg.getRowTo() && reg.getRowFrom() == curRowid) {
                regs.add(reg);
            }
        }
        return regs;
    }


    /**
     * ����EXCEL�е�ָ���Ĺ�������
     * ��������Ƿ�ҳ��ʾ����Ҫ����һ���жϣ��������а�����ʽforumla=sum(G7:G~)����ʱ�򣬱����޸���ʵ��G7Ϊ��Ӧ�����С�
     * @param sourceSheet  ԭ������
     * @param targetSheet Ŀ�깤����
     * @param pStartRow ������ʼ��
     * @param pEndRow ������ֹ��
     * @param pPosition ����λ��
     */
    private void copyRows(HSSFSheet sourceSheet, HSSFSheet targetSheet,int pStartRow, int pEndRow, int pPosition) {

		HSSFRow sourceRow = null;
		HSSFRow targetRow = null;
		HSSFCell sourceCell = null;
		HSSFCell targetCell = null;
		Region region = null;
		int cType;
		int i;
		short j;
		int targetRowFrom;
		int targetRowTo;

		if ((pStartRow == -1) || (pEndRow == -1)) {
			return;
		}
		// �����ϲ��ĵ�Ԫ��
		for (i = 0; i < sourceSheet.getNumMergedRegions(); i++) {
			region = sourceSheet.getMergedRegionAt(i);
			if ((region.getRowFrom() >= pStartRow)&& (region.getRowTo() <= pEndRow)) {
				targetRowFrom = region.getRowFrom() - pStartRow + pPosition;
				targetRowTo = region.getRowTo() - pStartRow + pPosition;
				region.setRowFrom(targetRowFrom);
				region.setRowTo(targetRowTo);
				targetSheet.addMergedRegion(region);
			}
		}
		// �����п�
		for (i = pStartRow; i <= pEndRow; i++) {
			sourceRow = sourceSheet.getRow(i);
			if (sourceRow != null) {
				for (j = sourceRow.getFirstCellNum(); j < sourceRow.getLastCellNum(); j++) {
					targetSheet.setColumnWidth(j, sourceSheet.getColumnWidth(j));
				}
				break;
			}
		}

		// �����в��������
		for (; i <= pEndRow; i++) {
			sourceRow = sourceSheet.getRow(i);
			if (sourceRow == null) {
				continue;
			}
			targetRow = targetSheet.createRow(i - pStartRow + pPosition);
			targetRow.setHeight(sourceRow.getHeight());
			for (j = sourceRow.getFirstCellNum(); j < sourceRow.getLastCellNum(); j++) {
				sourceCell = sourceRow.getCell(j);
				if (sourceCell == null) {
					continue;
				}

				targetCell = targetRow.createCell(j);				
				targetCell.setCellStyle(sourceCell.getCellStyle());
				cType = sourceCell.getCellType();
				targetCell.setCellType(cType);
				switch (cType) {
				case HSSFCell.CELL_TYPE_BOOLEAN:
					targetCell.setCellValue(sourceCell.getBooleanCellValue());
					break;
				case HSSFCell.CELL_TYPE_ERROR:
					targetCell.setCellErrorValue(sourceCell.getErrorCellValue());
					break;
				case HSSFCell.CELL_TYPE_FORMULA:
					targetCell.setCellFormula(parseFormula(sourceCell.getCellFormula()));
					break;
				case HSSFCell.CELL_TYPE_NUMERIC:
					targetCell.setCellValue(sourceCell.getNumericCellValue());
					break;
				case HSSFCell.CELL_TYPE_STRING:
					targetCell.setCellValue(sourceCell.getRichStringCellValue());
					break;
				}
				if(this.autoPagination){
					this.setFormulaBlankCell(sourceCell,tempStartRowNum);
				}
			}
		}
	}
    private String parseFormula(String pPOIFormula) {
		final String cstReplaceString = "ATTR(semiVolatile)"; //$NON-NLS-1$
		StringBuffer result = null;
		int index;
		result = new StringBuffer();
		index = pPOIFormula.indexOf(cstReplaceString);
		if (index >= 0) {
			result.append(pPOIFormula.substring(0, index));
			result.append(pPOIFormula.substring(index+ cstReplaceString.length()));
		} else {
			result.append(pPOIFormula);
		}
		return result.toString();
	}



    /**
	 * ���е����������ABCD��ĸ���������Ҫ�ڲ��빫ʽʱ�õ�
	 * @param colIndex ��������
	 * @return ABCD��ĸ��
	 */
    /*
    private String getColLetter(int colIndex){
     String ch = "";
        if (colIndex  < 26)
            ch = "" + (char)((colIndex) + 65);
        else
           ch = "" + (char)((colIndex) / 26 + 65 - 1) + (char)((colIndex) % 26 + 65);
        return ch;
    }
    */
    private int getColumnIndex(char c){
    	int i=c;
    	return i-65;
    }
    private int getOpIndex(String s){
    	for(int i=0;i<OP_FLAG.length;i++){
    		int index=s.indexOf(OP_FLAG[i]);
    		if(index!=-1){
    			return index;
    		}
    	}
    	return -1;
    }

    /**
     * �ж��Ƿ���ЧCell
     * @param cell
     * @return
     */
    private boolean invalidCellValue(HSSFCell cell){
    	if(cell.getCellType()==HSSFCell.CELL_TYPE_BLANK){
    		return true;
    	}
    	else if(cell.getCellType()==HSSFCell.CELL_TYPE_STRING){
    		if(cell.getRichStringCellValue().getString()==null||cell.getRichStringCellValue().getString().equals("")){
    			return true;
    		}
    	}
    	else if(cell.getCellType()==HSSFCell.CELL_TYPE_ERROR){
    		return true;
    	}

    	return false;
    }

    /**
     * ��Ŀ��Excel�ļ������ݵ��뵽���ݱ�
     * @param targetFile Excel�ļ�·��
     * @param entityName SDO����ʵ��ȫ��
     * @return ����1 ����ɹ�
     *
     * @throws Exception
     */
    public int importData(String targetFile,String entityName,int submitCount)throws Exception{
        POIFSFileSystem fs =new POIFSFileSystem(new FileInputStream(targetFile));
        HSSFWorkbook wb = new HSSFWorkbook(fs);

        for(int sheetCount=0;sheetCount<wb.getNumberOfSheets();sheetCount++){
        	HSSFSheet sheet = wb.getSheetAt(sheetCount);
        	int rows  = sheet.getPhysicalNumberOfRows();
            initialize(sheet);
            if(startRow==-1)
            	continue;

            List<DataObject> dataObjects=new ArrayList<DataObject>();

            //��һ��Ϊ#�ֶ���
            //�ڶ���Ϊ�ֶα��⣬������ݶ�ȡ��startRow+2
            for(int rowCount=startRow+2;rowCount<rows;rowCount++){

            	HSSFRow sourceRow=sheet.getRow(rowCount);

            	DataObject importEntity=DataObjectUtil.createDataObject(entityName);

            	//�ж�ĳһ���Ƿ�������룬�����е�������cell��ΪBLANKʱ���������ݿ�
            	boolean allowInsert=false;

            	//���¹��쵼���ʵ����󣬲�����Excel��Ԫ����������ʵ������ֵ
            	for(int cellCount=0;cellCount<fieldNames.length;cellCount++){

            		String propertyName=fieldNames[cellCount];
            		HSSFCell cell=sourceRow.getCell((short)cellCount);

            		if(cell==null||cell.getCellType()==HSSFCell.CELL_TYPE_BLANK)
            			continue;

            		allowInsert=true;

            		String value=null;

            		if(cell.getCellType()==HSSFCell.CELL_TYPE_NUMERIC){
            			 if (HSSFDateUtil.isCellDateFormatted(cell)){
            	                SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            	                value= dateFormat.format((cell.getDateCellValue()));
            	             
            	             }else{  
            	                value=String.valueOf((long) cell.getNumericCellValue());  
            	             }
            		}else if(cell.getCellType()==HSSFCell.CELL_TYPE_BOOLEAN){
            			value=cell.getBooleanCellValue()+"";
            		}else{
            			value=cell.getRichStringCellValue().getString();
            		}

            		TypeReference typeReference=(TypeReference)importEntity.getType().getProperty(propertyName).getType();
            		Type propertyType=typeReference.getActualType();

            		if(propertyType instanceof IntType||propertyType instanceof IntegerType){
            			//��ֹ���ܳ��ֵ�Excel����ȡ�Զ���.��
              			if(value.indexOf(".")!=-1)
            				value=value.substring(0,value.indexOf("."));

            			importEntity.set(fieldNames[cellCount],ChangeUtil.toInteger(value));
            		}
            		else if(propertyType instanceof BooleanType){
            			importEntity.set(fieldNames[cellCount],ChangeUtil.toBoolean(Boolean.valueOf(value)));
            		}
            		else if(propertyType instanceof FloatType){
            			importEntity.set(fieldNames[cellCount],ChangeUtil.toFloat(value));
            		}
            		else if(propertyType instanceof LongType){
            			if(value.indexOf(".")!=-1)
            				value=value.substring(0,value.indexOf("."));
            			importEntity.set(fieldNames[cellCount],ChangeUtil.toLong(value));
            		}
            		else if(propertyType instanceof DecimalType){
            			importEntity.set(fieldNames[cellCount],ChangeUtil.toBigDecimal(value));
            		}
            		else if(propertyType instanceof DateType){
            			importEntity.set(fieldNames[cellCount],ChangeUtil.changeToDBDate(value));
            		}
            		else if(propertyType instanceof DateTimeType){
            			importEntity.set(fieldNames[cellCount],ChangeUtil.toTimestamp(value));
            		}
            		else{
            			importEntity.set(fieldNames[cellCount], value);
            		}

            	}


            	if(dataObjects.size()<submitCount){
            		if(allowInsert)
            			dataObjects.add(importEntity);
            	}else{
            		if(dataObjects.size()>0){
	            		DatabaseUtil.insertEntityBatch("sunfi", dataObjects.toArray(new DataObject[dataObjects.size()]));
	            		dataObjects.clear();
            		}
            	}

            	if(rowCount==rows-1){
            		if(dataObjects.size()>0)
            			DatabaseUtil.insertEntityBatch("sunfi", dataObjects.toArray(new DataObject[dataObjects.size()]));

            	}


            }

        }

        return 1;
    }
    
    
    
    /**
     * ��Ŀ��Excel�ļ������ݵ��뵽���ݱ�
     * @param targetFile Excel�ļ�·��
     * @param entityName SDO����ʵ��ȫ��
     * @return ���� dataObjects ����ʵ�弯 
     *
     * @throws Exception
     */
    public Object[] importData(String targetFile,String entityName)throws Exception{
        POIFSFileSystem fs =new POIFSFileSystem(new FileInputStream(targetFile));
        HSSFWorkbook wb = new HSSFWorkbook(fs);
        ArrayList<DataObject> dataObjects=new ArrayList<DataObject>();
        
        for(int sheetCount=0;sheetCount<wb.getNumberOfSheets();sheetCount++){
        	HSSFSheet sheet = wb.getSheetAt(sheetCount);
        	int rows  = sheet.getPhysicalNumberOfRows();
            initialize(sheet);
            if(startRow==-1)
            	continue;

            //��һ��Ϊ#�ֶ���
            //�ڶ���Ϊ�ֶα��⣬������ݶ�ȡ��startRow+2
            for(int rowCount=startRow+2;rowCount<rows;rowCount++){

            	HSSFRow sourceRow=sheet.getRow(rowCount);

            	DataObject importEntity=DataObjectUtil.createDataObject(entityName);

            	//�ж�ĳһ���Ƿ�������룬�����е�������cell��ΪBLANKʱ���������ݿ�
            	boolean allowInsert=false;

            	//���¹��쵼���ʵ����󣬲�����Excel��Ԫ����������ʵ������ֵ
            	for(int cellCount=0;cellCount<fieldNames.length;cellCount++){
            		String propertyName=fieldNames[cellCount];
            		HSSFCell cell=sourceRow.getCell((short)cellCount);

            		if(cell==null||cell.getCellType()==HSSFCell.CELL_TYPE_BLANK)
            			continue;

            		allowInsert=true;

            		String value=null;

            		if(cell.getCellType()==HSSFCell.CELL_TYPE_NUMERIC){
            			 if (HSSFDateUtil.isCellDateFormatted(cell)){
            	                SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            	                value= dateFormat.format((cell.getDateCellValue()));
            	             
            	             }else{  
            	                value=String.valueOf((long) cell.getNumericCellValue());  
            	             }
            		}else if(cell.getCellType()==HSSFCell.CELL_TYPE_BOOLEAN){
            			value=cell.getBooleanCellValue()+"";
            		}else{
            			value=cell.getRichStringCellValue().getString();
            		}

            		TypeReference typeReference=(TypeReference)importEntity.getType().getProperty(propertyName).getType();
            		Type propertyType=typeReference.getActualType();

            		if(propertyType instanceof IntType||propertyType instanceof IntegerType){
            			//��ֹ���ܳ��ֵ�Excel����ȡ�Զ���.��
              			if(value.indexOf(".")!=-1)
            				value=value.substring(0,value.indexOf("."));

            			importEntity.set(fieldNames[cellCount],ChangeUtil.toInteger(value));
            		}
            		else if(propertyType instanceof BooleanType){
            			importEntity.set(fieldNames[cellCount],ChangeUtil.toBoolean(Boolean.valueOf(value)));
            		}
            		else if(propertyType instanceof FloatType){
            			importEntity.set(fieldNames[cellCount],ChangeUtil.toFloat(value));
            		}
            		else if(propertyType instanceof LongType){
            			if(value.indexOf(".")!=-1)
            				value=value.substring(0,value.indexOf("."));
            			importEntity.set(fieldNames[cellCount],ChangeUtil.toLong(value));
            		}
            		else if(propertyType instanceof DecimalType){
            			importEntity.set(fieldNames[cellCount],ChangeUtil.toBigDecimal(value));
            		}
            		else if(propertyType instanceof DateType){
            			importEntity.set(fieldNames[cellCount],ChangeUtil.changeToDBDate(value));
            		}
            		else if(propertyType instanceof DateTimeType){
            			importEntity.set(fieldNames[cellCount],ChangeUtil.toTimestamp(value));
            		}
            		else{
            			importEntity.set(fieldNames[cellCount], value);
            		}
            	}
            			dataObjects.add(importEntity);
            }
        }
        return  dataObjects.toArray();
    }
    
    /**
     * ��Ŀ��Excel�ļ������ݵ��뵽���ݱ�
     * @param targetFile Excel�ļ�·��
     * @param entityName SDO����ʵ��ȫ��
     * @param hashMap Ĭ��ֵ
     * @return ����1 ����ɹ�
     *
     * @throws Exception
     */
    public int importData(String targetFile,String entityName,HashMap<String,String> hashMap,int submitCount)throws Exception{
        POIFSFileSystem fs =new POIFSFileSystem(new FileInputStream(targetFile));
        HSSFWorkbook wb = new HSSFWorkbook(fs);

        for(int sheetCount=0;sheetCount<1;sheetCount++){
        	HSSFSheet sheet = wb.getSheetAt(sheetCount);
        	int rows  = sheet.getPhysicalNumberOfRows();
            initialize(sheet);
            if(startRow==-1)
            	continue;

            List<DataObject> dataObjects=new ArrayList<DataObject>();
            
            //��һ��Ϊ#�ֶ���
            //�ڶ���Ϊ�ֶα��⣬������ݶ�ȡ��startRow+2
            for(int rowCount=startRow+2;rowCount<rows;rowCount++){

            	HSSFRow sourceRow=sheet.getRow(rowCount);

            	DataObject importEntity=DataObjectUtil.createDataObject(entityName);

            	//�ж�ĳһ���Ƿ�������룬�����е�������cell��ΪBLANKʱ���������ݿ�
            	boolean allowInsert=false;

            	//���¹��쵼���ʵ����󣬲�����Excel��Ԫ����������ʵ������ֵ
            	for(int cellCount=0;cellCount<fieldNames.length;cellCount++){

            		String propertyName=fieldNames[cellCount];
            		HSSFCell cell=sourceRow.getCell((short)cellCount);
            		if(cellCount==0 && (cell==null||cell.getCellType()==HSSFCell.CELL_TYPE_BLANK))
	            		break;	
            		if(cell==null||cell.getCellType()==HSSFCell.CELL_TYPE_BLANK)
	            		continue;

            		allowInsert=true;

            		String value=null;
            		
            		if(cell.getCellType()==HSSFCell.CELL_TYPE_NUMERIC){
            			 if (HSSFDateUtil.isCellDateFormatted(cell)){
            	                SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            	                value= dateFormat.format((cell.getDateCellValue()));
            	             
            	             }else{  
            	                //value=String.valueOf((long) cell.getNumericCellValue());  
            	                //value = String.valueOf((float) cell.getNumericCellValue());
            	            	java.text.DecimalFormat   formatter   =   new   java.text.DecimalFormat( "################.##"); 
             	                value   =   formatter.format(cell.getNumericCellValue()); 

            	             }
            		}else if(cell.getCellType()==HSSFCell.CELL_TYPE_BOOLEAN){
            			value=cell.getBooleanCellValue()+"";
            		}else{
            			value=cell.getRichStringCellValue().getString();
            		}
            		if(cellCount==0){
            			if ((value == null || value.trim().equals(""))){
            				break;
            		}
            		}
            		

            		TypeReference typeReference=(TypeReference)importEntity.getType().getProperty(propertyName).getType();
            		Type propertyType=typeReference.getActualType();
            		if(propertyType instanceof IntType||propertyType instanceof IntegerType){
            			//��ֹ���ܳ��ֵ�Excel����ȡ�Զ���.��
              			if(value.indexOf(".")!=-1)
            				value=value.substring(0,value.indexOf("."));
                		importEntity.set(fieldNames[cellCount],ChangeUtil.toInteger(value));
            		}
            		else if(propertyType instanceof BooleanType){
                		importEntity.set(fieldNames[cellCount],ChangeUtil.toBoolean(Boolean.valueOf(value)));
            		}
            		else if(propertyType instanceof FloatType){
                		importEntity.set(fieldNames[cellCount],ChangeUtil.toFloat(value));
            		}
            		else if(propertyType instanceof LongType){
            			if(value.indexOf(".")!=-1)
            				value=value.substring(0,value.indexOf("."));
                		importEntity.set(fieldNames[cellCount],ChangeUtil.toLong(value));
            		}
            		else if(propertyType instanceof DecimalType){
                		importEntity.set(fieldNames[cellCount],ChangeUtil.toBigDecimal(value));
            		}
            		else if(propertyType instanceof DateType){
                		importEntity.set(fieldNames[cellCount],ChangeUtil.changeToDBDate(value));
            		}
            		else if(propertyType instanceof DateTimeType){
                		importEntity.set(fieldNames[cellCount],ChangeUtil.toTimestamp(value));
            		}
            		else{
                		importEntity.set(fieldNames[cellCount], value);
            		}

            	}
            	
            	//���¹��쵼���ʵ����󣬲�����hashMap�������ʵ������ֵ
            	if(hashMap != null){
        			Iterator keyset = hashMap.keySet().iterator();
        			while (keyset.hasNext()) {
        				String key = (String) keyset.next();
        				String value = (String) hashMap.get(key);
        				TypeReference typeReference=(TypeReference)importEntity.getType().getProperty(key).getType();
                		Type propertyType=typeReference.getActualType();
                		if(propertyType instanceof IntType||propertyType instanceof IntegerType){
                			//��ֹ���ܳ��ֵ�Excel����ȡ�Զ���.��
                  			if(value.indexOf(".")!=-1)
                				value=value.substring(0,value.indexOf("."));
                    		importEntity.set(key,ChangeUtil.toInteger(value));
                		}
                		else if(propertyType instanceof BooleanType){
                    		importEntity.set(key,ChangeUtil.toBoolean(Boolean.valueOf(value)));
                		}
                		else if(propertyType instanceof FloatType){
                    		importEntity.set(key,ChangeUtil.toFloat(value));
                		}
                		else if(propertyType instanceof LongType){
                			if(value.indexOf(".")!=-1)
                				value=value.substring(0,value.indexOf("."));
                    		importEntity.set(key,ChangeUtil.toLong(value));
                		}
                		else if(propertyType instanceof DecimalType){
                    		importEntity.set(key,ChangeUtil.toBigDecimal(value));
                		}
                		else if(propertyType instanceof DateType){
                    		importEntity.set(key,ChangeUtil.changeToDBDate(value));
                		}
                		else if(propertyType instanceof DateTimeType){
                    		importEntity.set(key,ChangeUtil.toTimestamp(value));
                		}
                		else{
                    		importEntity.set(key, value);
                		}
        			}
        		}
            	
            	if(dataObjects.size()<submitCount){
            		if(allowInsert)
            			dataObjects.add(importEntity);
            	}else{
            		if(dataObjects.size()>0){
            			dataObjects.add(importEntity);
	            		DatabaseUtil.insertEntityBatch("default", dataObjects.toArray(new DataObject[dataObjects.size()]));
	            		dataObjects.clear();
            		}
            	}

            	if(rowCount==rows-1){
            		if(dataObjects.size()>0)
            			DatabaseUtil.insertEntityBatch("default", dataObjects.toArray(new DataObject[dataObjects.size()]));

            	}


            }

        }

        return 1;
    }

    /**
     * ���ģ���ļ��Ƿ����
     * @param filename ģ���ļ���
     * @return �ļ����ڷ���true,����false
     * @throws IOException
     */
    protected boolean isExistTemplate(String templateFile)throws IOException{
    	File file=new File(templateFile);
    	return file.exists();

    }


    /**
     * Ԥ��ʼ��ģ���ļ�<BR>
     * ���û�ָ����ģ���ļ�������ʱ�����Զ�����ָ����ģ���ļ�������һ������ΪҪ�������ֶ���
     * @param templateFile ģ���ļ���
     * @param dataObject ����ʵ�����
     * @throws Exception
     */
    public void prepareInitializeTemplate(String templateFile,DataObject dataObject) throws Exception{
    	 HSSFWorkbook wb = new HSSFWorkbook();
    	 FileOutputStream fileOut = new FileOutputStream(templateFile);
    	 HSSFSheet sheet = wb.createSheet("new sheet");
    	 //����ģ��ĵ�һ��Ϊ����ֶζ�����
    	 HSSFRow row = sheet.createRow((short)0);

    	 Object[] properties=dataObject.getType().getDeclaredProperties().toArray();
    	 for(int i=0;i<properties.length;i++){
    		 PropertyImpl property=(PropertyImpl)properties[i];
	    	 HSSFCell cell = row.createCell((short)i);
	    	 HSSFRichTextString text=new HSSFRichTextString("#"+property.getName());
	    	 cell.setCellValue(text);
    	 }
    	 wb.write(fileOut);
    	 fileOut.close();

    }
    
    /**
	 * ��txt���ݵ��뵽ָ����ʵ����
	 */
    public Object[] importTxTtoData(String targetFile,String entityName)throws Exception{
		FileReader f = new FileReader(targetFile);
		BufferedReader bufferedreader = new BufferedReader(
				(new InputStreamReader(new FileInputStream(new File(targetFile)),
						"utf-8")));//���뷽ʽΪutf-8��txt����ʱ���뷽ʽҲҪѡ��Ϊutf-8
		String instring;
		String data = null;
		ArrayList<DataObject> dataObjects=new ArrayList<DataObject>();
		
		while ((instring = bufferedreader.readLine()) != null) {
			
			data = instring;
			DataObject importEntity=DataObjectUtil.createDataObject(entityName);
            //�ж�ĳһ���Ƿ�������룬�����е�������cell��ΪBLANKʱ���������ݿ�
			boolean allowInsert=false;
			if (0 != instring.length()) {
				allowInsert=true;
        		
        		importEntity.set("aybkno", data);
        		if(allowInsert){
        			dataObjects.add(importEntity);
        		}
			}
		}
		f.close();
		return  dataObjects.toArray();
	}

}
