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
 * Created on 2010-10-28
 *******************************************************************************/

package com.sunline.sunfi.util;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;
import commonj.sdo.Property;

/**
 * 
 * TODO fill class info here
 *
 * @author 安宣部 (mailto:anxb@sunline.cn)
 */

public class Total {
	
	/**
	 * 统计totalHashMap中要汇总的字段，并将结果返回
	 * @param dataobjs
	 * @param totalHashMap
	 * @return
	 */
	@Bizlet("统计totalHashMap中要汇总的字段，并将结果返回")
	public HashMap getTotals(DataObject[] dataobjs,HashMap totalHashMap){
		for(int i=0;i<dataobjs.length;i++){
			if(dataobjs[i]!=null){
				Iterator it = totalHashMap.keySet().iterator();
				while(it.hasNext()){
					String key = (String) it.next();
					BigDecimal totalvalue = new BigDecimal((String)totalHashMap.get(key));
					BigDecimal value = dataobjs[i].getBigDecimal(key);
					totalHashMap.put(key, totalvalue.add(value).toString());
				}
			}
		}
		return totalHashMap;
	}
}
