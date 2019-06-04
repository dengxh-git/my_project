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
 * Created on 2010-11-25
 *******************************************************************************/

package com.sunline.sunfi.sunfi_wf.util;

import java.io.File;
import com.eos.foundation.common.utils.FileUtil;
import com.eos.system.annotation.Bizlet;
import com.eos.system.utility.StringUtil;
import com.primeton.ext.access.http.IUploadFile;
import com.sunline.sunfi.config.FIConfig;

/**
 * 
 * �ļ��ϴ�������
 * 
 * @author ������ (mailto:anxb@sunline.cn)
 */

@Bizlet(value = "�ļ��ϴ�������")
public class FileUploadUtil {
	private static String sunline_Path = com.sunline.sunfi.util.FileUtil.getHomePath();

	@Bizlet(value = "�ƶ��ϴ��ļ���ָ���ķ���Ŀ¼")
	public static void moveUploadFileToCatalog(String fileCatalog,
			IUploadFile[] uploadFiles) {

		if (StringUtil.isNullOrBlank(fileCatalog)) {
			return;
		}

		String uploadPath = sunline_Path + FIConfig.getRepositoryDestination();
		
		if(!uploadPath.endsWith(File.separator)){
			uploadPath = uploadPath + File.separator;
		}
		String catalogPath = uploadPath + fileCatalog;
		File catalogDir = new File(catalogPath);
		if (!catalogDir.exists()) {
			catalogDir.mkdir();
		}
		for (IUploadFile uploadFile:uploadFiles) {
			File moveFile = new File(uploadFile.getFilePath());
			if (moveFile.exists()) {
				File targetFile = new File(catalogPath + File.separator
						+ getFileName(uploadFile.getFilePath()));
				if (targetFile.exists()) {
					targetFile.delete();
				}
				FileUtil.moveFileToDir(uploadFile.getFilePath(), catalogPath);
				FileUtil.deleteFile(uploadFile.getFilePath());
			}
		}
	}

	@Bizlet(value = "��ȡ�����ļ�·��")
	public static String getCatalogFilePath(String fileCatalog, String filePath) {
		if (StringUtil.isNotNullAndBlank(fileCatalog)) {
			String uploadPath = sunline_Path + FIConfig.getRepositoryDestination();
			if(!uploadPath.endsWith(File.separator)){
				uploadPath = uploadPath + File.separator;
			}
			String fileName = getFileName(filePath);
			return uploadPath + fileCatalog + File.separator + fileName;
		} else {
			return filePath;
		}
	}

	private static String getFileName(String filePath) {
		int lastIndex = filePath.lastIndexOf(File.separator);
		return filePath.substring(lastIndex + 1);
	}

}
