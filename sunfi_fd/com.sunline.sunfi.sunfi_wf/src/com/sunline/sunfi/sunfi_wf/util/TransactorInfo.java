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
 * Created on 2010-12-2
 *******************************************************************************/

package com.sunline.sunfi.sunfi_wf.util;

import java.io.IOException;
import java.io.StringReader;
import java.io.StringWriter;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import com.eos.system.annotation.Bizlet;
import com.sun.xml.bind.v2.schemagen.xmlschema.List;

import org.w3c.dom.*;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

/**
 * TODO fill class info here
 * 
 * @author liuchangjin
 * @date 2010-12-02 20:57:34
 */
/*
 * Modify history $Log$
 */
@Bizlet("流程办理人信息")
public class TransactorInfo {

	/**
	 * @param nodeName
	 * @param nodeValue
	 * @author liuchangjin
	 */
	@Bizlet("")
	public String setNodeValue(String transactorInfo, String nodeName,
			String nodeValue) {

		Document doc = xmlToDocument(transactorInfo);
		
		Element node = doc.createElement(nodeName);
		Text text = doc.createTextNode(nodeValue);
		node.appendChild(text);

		NodeList nodeList = doc.getElementsByTagName(nodeName);

		if (nodeList.getLength() > 0) {
			nodeList.item(0).setTextContent(nodeValue);
		} else {
			doc.getDocumentElement().appendChild(node);
		}

		try {
			transactorInfo = toFormatedXML(doc);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return getDocumentBody(transactorInfo);
	}
	
	/**
	 * 将xml转化为Document
	 * @param xml
	 * @return
	 */
	private Document xmlToDocument(String xml){
		StringReader xmlStr = new StringReader(xml);
		InputSource is = new InputSource(xmlStr);
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder;
		Document doc = null;
		try {
			builder = factory.newDocumentBuilder();
			try {
				doc = builder.parse(is);
			} catch (SAXException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (ParserConfigurationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return doc;
	}
	
	/**
	 * 将Document转化为xml
	 * @param object
	 * @return
	 * @throws Exception
	 */
	private static String toFormatedXML(Document object) throws Exception {
		Document doc = (Document) object;
		TransformerFactory transFactory = TransformerFactory.newInstance();
		Transformer transFormer = transFactory.newTransformer();
		transFormer.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
		DOMSource domSource = new DOMSource(doc);

		StringWriter sw = new StringWriter();
		StreamResult xmlResult = new StreamResult(sw);

		transFormer.transform(domSource, xmlResult);

		return sw.toString();

	}
	
	/**
	 * 获取xml的体信息
	 * @param xml
	 * @return
	 */
	private String getDocumentBody(String xml){
		return xml.substring(xml.indexOf("<", 2));
	}
	
	

}
