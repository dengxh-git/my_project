/**
 * 
 */
package com.sunline.sunfi.sunfi_cm;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @author kaifasishi82
 * @date 2018-12-05 15:03:14
 *
 */
@Bizlet("")
public class ComBrch {

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Bizlet("获取法人")
	public List<Map> getComBrchRoot(DataObject[] combrch, String nodeType) {
		List<Map> nodeList = new ArrayList<Map>();
		Map rootMap = new HashMap();
		if (nodeType == null) {
			rootMap.put("id", "root_root");
			rootMap.put("realId", "root");
			rootMap.put("text", "机构责任中心树");
			rootMap.put("type", "root");
			rootMap.put("iconCls", "");
			rootMap.put("isLeaf", false);
			rootMap.put("expanded", true);
			nodeList.add(rootMap);
		}
		//构造应用List
		for (DataObject dataObject : combrch) {
			Map map = new HashMap();
			map.put("id", "brch_" + dataObject.get("brchcd"));
			map.put("realId", dataObject.get("brchcd"));
			map.put("text", dataObject.get("brchna"));
			map.put("type", "brch");
			map.put("pid", "root_root");
			map.put("iconCls", "");
			map.put("isLeaf", false);
			map.put("expanded", false);
			nodeList.add(map);
		}
		return nodeList;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Bizlet("获取责任中心")
	public List<Map> getComDutyRoot(DataObject[] comduty) {
		List<Map> nodeList = new ArrayList<Map>();
		//构造应用List
		for (DataObject dataObject : comduty) {
			Map map = new HashMap();
			map.put("id", "duty_" + dataObject.get("dutycd"));
			map.put("realId", dataObject.get("dutycd"));
			map.put("text", dataObject.get("dutyna"));
			map.put("type", "duty");
			map.put("pid", "duty_root");
			map.put("iconCls", "");
			map.put("isLeaf", true);
			map.put("expanded", false);
			nodeList.add(map);
		}
		return nodeList;
	}

}
