/**
 * 
 */
package com.sunline.sunfi.sunfi_cm;

import java.io.File;

import com.eos.foundation.common.utils.FileUtil;
import com.eos.system.annotation.Bizlet;
import com.eos.system.utility.StringUtil;
import com.primeton.ext.access.http.IUploadFile;
import com.sunline.sunfi.config.FIConfig;

/**
 * @author kaifasishi82
 * @date 2018-12-21 09:23:41
 *
 */
@Bizlet("文件上传工具类")
public class FileUploadUtil {

	@Bizlet(value = "移动上传文件到指定的分类目录")
	public static void moveUploadFileToCatalog(String fileCatalog,
			IUploadFile[] uploadFiles) {

		if (StringUtil.isNullOrBlank(fileCatalog)) {
			return;
		}

		//String uploadPath = sunline_Path + FIConfig.getRepositoryDestination();
		String uploadPath = FIConfig.getRepositoryDestination();

		if (!uploadPath.endsWith(File.separator)) {
			uploadPath = uploadPath + File.separator;
		}
		String catalogPath = uploadPath + fileCatalog;
		File catalogDir = new File(catalogPath);
		if (!catalogDir.exists()) {
			catalogDir.mkdir();
		}
		for (IUploadFile uploadFile : uploadFiles) {
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

	@Bizlet(value = "获取分类文件路径")
	public static String getCatalogFilePath(String fileCatalog, String filePath) {
		if (StringUtil.isNotNullAndBlank(fileCatalog)) {
			//String uploadPath = sunline_Path + FIConfig.getRepositoryDestination();
			String uploadPath = FIConfig.getRepositoryDestination();
			if (!uploadPath.endsWith(File.separator)) {
				uploadPath = uploadPath + File.separator;
			}
			String fileName = getFileName(filePath);
			return uploadPath + fileCatalog + File.separator + fileName;
		} else {
			return filePath;
		}
	}

	@Bizlet(value = "获取分类文件路径")
	public static String getFjFilePath(String fileCatalog, String filePath) {
		if (StringUtil.isNotNullAndBlank(fileCatalog)) {
			//String uploadPath = sunline_Path + FIConfig.getRepositoryDestination();
			String uploadPath = FIConfig.getRepositoryDestination();
			if (!uploadPath.endsWith(File.separator)) {
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
