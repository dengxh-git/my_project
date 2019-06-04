/*******************************************************************************
 * $Header$
 * $Revision$
 * $Date$
 *
 *==============================================================================
 *
 * Copyright (c) 2001-2006 Primeton Technologies, Ltd.
 * All rights reserved.
 * 
 * Created on 2010-10-9
 *******************************************************************************/


package com.sunline.sunfi.util;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import com.eos.foundation.data.DataObjectUtil;
import com.eos.system.annotation.Bizlet;
import com.eos.system.annotation.BizletParam;
import com.eos.system.annotation.ParamType;
import com.primeton.data.sdo.impl.TypeReference;
import com.primeton.data.sdo.impl.types.BooleanType;
import com.primeton.data.sdo.impl.types.DateTimeType;
import com.primeton.data.sdo.impl.types.DateType;
import com.primeton.data.sdo.impl.types.DecimalType;
import com.primeton.data.sdo.impl.types.DoubleType;
import com.primeton.data.sdo.impl.types.FloatType;
import com.primeton.data.sdo.impl.types.IntType;
import com.primeton.data.sdo.impl.types.IntegerType;
import com.primeton.data.sdo.impl.types.LongType;
import com.primeton.data.sdo.impl.types.StringType;

import commonj.sdo.DataObject;
import commonj.sdo.Property;
import commonj.sdo.Type;

public class Convert {
	
	/**
	 * ��DataObjectת��ΪHashMap
	 * @param objd
	 * @return
	 */
	@Bizlet("��DataObjectת��ΪHashMap")
	public static HashMap<String, Object> convertDataObject2HashMap(DataObject obj){
		HashMap<String, Object> map = new HashMap<String, Object>();
		if(obj != null){
			List properties = obj.getInstanceProperties();
			Property property;
			for(int i = 0 ; i < properties.size(); i++){
				property = (Property)properties.get(i);
				map.put(property.getName(), obj.get(i));
			}
		}
		return map;
	}
	
	/**
	 * ��DataObject[]ת��ΪHashMap[]
	 * @param objs
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Bizlet("��DataObject[]ת��ΪHashMap[]")
	public static HashMap<String, Object>[] convertDataObject2HashMap(DataObject[] objs){
		HashMap<String, Object>[] maps = null;
		if(objs != null){
			maps = new HashMap[objs.length];
			List properties;
			Property property;
			for(int m = 0 ; m < objs.length; m++){
				properties = objs[m].getInstanceProperties();
				HashMap<String, Object> map = new HashMap<String, Object>();
				for(int i = 0 ; i < properties.size(); i++){
					property = (Property)properties.get(i);
					map.put(property.getName(), objs[m].get(i));
				}
				maps[m] = map;
			}
		}
		return maps;
	}
	@Bizlet("��DataObject[]ת��ΪHashMap")
	public static HashMap<String, String> convertDataObject2ToHashMap(DataObject[] objs,HashMap<String, String> master){
		List properties;
		Property property;
		if(objs != null){
			for (int m = 0; m < objs.length; m++) {
				properties = objs[m].getInstanceProperties();
				for(int i=0; i < properties.size(); i++){
					property = (Property)properties.get(i);
					String nameStr = property.getName() + "_" + m;
					master.put(nameStr,(String)objs[m].get(property.getName()));
				}
			}
		}
		return master;
	}
	/**
	 * ��HashMapת��ΪDataObject,HashMap��key����Ϊʵ������path
	 * @param entityName ʵ������
	 * @param map
	 * @return
	 */
	@Bizlet("��HashMapת��ΪDataObject")
	public static DataObject convertHashMap2DataObject(String entityName,HashMap<String, Object> map){
		DataObject dataObj = DataObjectUtil.createDataObject(entityName);
		if(map != null){
			Iterator keyset = map.keySet().iterator();
			while (keyset.hasNext()) {
				String key = (String) keyset.next();
				Object obj = map.get(key);
				dataObj.set(key, obj);
			}
		}
		return dataObj;
	}
	
	/**
	 * ������B�ϲ�������A��
	 * @param arrayA
	 * @param arrayB
	 * @return
	 */
	@Bizlet("������B�ϲ�������A��")
	public static Object[] arrayAdd(Object [] arrayA,Object [] arrayB){
		Object[] tempArray = null;
		if(arrayB!=null && arrayB.length>0){
			if(arrayA!=null){
				tempArray = new Object[arrayA.length + arrayB.length];
				java.lang.System.arraycopy(arrayA, 0,tempArray,0,arrayA.length);
				//chenlzh�޸�  ��ʷ����:java.lang.System.arraycopy(arrayB,0,tempArray,tempArray.length-1,arrayB.length);
				java.lang.System.arraycopy(arrayB,0,tempArray,tempArray.length-arrayB.length,arrayB.length);
			}else{
				return arrayB;
			}
		}else{
			return arrayA;
		}
		return tempArray;
	}
	/**
	 * ������ݶ������������ֵ
	 * @param dataObject DataObject����
	 */
	@Bizlet(
		value="������ݶ������������ֵ",
		params = {
			@BizletParam(index = 0, type = ParamType.VARIABLE,paramAlias="dataObject"),
		}
	)
	public static void cleanProperties(DataObject dataObject){
		Iterator properties=dataObject.getType().getProperties().iterator();
		while(properties.hasNext()){
			Property property=(Property)properties.next();
			dataObject.unset(property);
		}
	}
	/**
	 * ����DataObject����path����HashMap����DataObject����
	 * 
	 * @param entityName
	 *            ʵ������
	 * @param map
	 * @return
	 */
	@Bizlet("��HashMapת��ΪDataObject")
	public static DataObject setDataObjectFromHashMap(String entityName,
			HashMap<String, Object> map) {
		DataObject dataObj = DataObjectUtil.createDataObject(entityName);
		List properties = dataObj.getInstanceProperties();
		Property property;
		for (int i = 0; i < properties.size(); i++) {
			property = (Property) properties.get(i);
			String propName = property.getName();
			Object propvlaue = (map.get(propName) == null ? null : map
					.get(propName));

			TypeReference typeReference=(TypeReference)dataObj.getType().getProperty(propName).getType();
            Type propertyType=typeReference.getActualType();

			if (propertyType != null && propertyType.isDataType() && propvlaue != null) {
				if(propertyType instanceof StringType){
					dataObj.set(property, ChangeUtil.toStr(propvlaue));
				}else if (propertyType instanceof IntType
						|| propertyType instanceof IntegerType) {
					dataObj.set(property, ChangeUtil.toInteger(propvlaue));
				} else if (propertyType instanceof BooleanType) {
					dataObj.set(property, ChangeUtil.toBoolean(Boolean
							.valueOf(propvlaue.toString())));
				} else if (propertyType instanceof FloatType ) {
					dataObj.set(property, ChangeUtil.toFloat(propvlaue));
				}else if (propertyType instanceof DoubleType ) {
					dataObj.set(property, ChangeUtil.toDouble(propvlaue));
				} else if (propertyType instanceof LongType) {
					dataObj.set(property, ChangeUtil.toLong(propvlaue));
				} else if (propertyType instanceof DecimalType ) {
					dataObj.set(property, ChangeUtil.toBigDecimal(propvlaue
							.toString()));
				} else if (propertyType instanceof DateType) {
					dataObj.set(property, ChangeUtil.changeToDBDate(propvlaue
							.toString()));
				} else if (propertyType instanceof DateTimeType) {
					dataObj.set(property, ChangeUtil.toTimestamp(propvlaue
							.toString()));
				} else {
					dataObj.set(property, propvlaue);
					System.out.println(propertyType);
				}
			}else{
				
			}
		}
		return dataObj;
	}
}
