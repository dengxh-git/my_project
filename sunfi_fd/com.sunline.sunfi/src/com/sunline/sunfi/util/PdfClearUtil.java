package com.sunline.sunfi.util;

import java.io.File;

import com.eos.runtime.core.ApplicationContext;

public class PdfClearUtil {
	
	public void PdfClear(){
		ApplicationContext context = ApplicationContext.getInstance();
		String pdfPath = context.getWarRealPath() + File.separator + "reporthtml";
		File dir =new File(pdfPath);
		File[] files = dir.listFiles();
		if (files != null) {
			for (int i = 0; i < files.length; i++) {
				File file = files[i];
				if (file.isFile()) {
					file.delete();
				}
			}
		}		
	}
}
