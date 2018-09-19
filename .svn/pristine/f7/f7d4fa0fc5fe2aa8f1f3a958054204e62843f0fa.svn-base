package com.avic.common.utils;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public class CommonFileUtils {
 	private static final String REALNAME = "realName";  
    private static final String UPLOADDIR = "Lodop/"; 
    /** 
     * 将上传的文件进行重命名 
     *  
     * @param name 
     * @return 
     */  
    private static String rename(String name) {  
  
        Long now = Long.parseLong(new SimpleDateFormat("yyyyMMddHHmmss")  
                .format(new Date()));  
        Long random = (long) (Math.random() * now);  
        String fileName = now + "" + random;  
  
        if (name.indexOf(".") != -1) {  
            fileName += name.substring(name.lastIndexOf("."));  
        }  
  
        return fileName;  
    }  
    /** 
     * 上传文件 
     *  
     * @param request 
     * @param params 
     * @param values 
     * @return 
     * @throws Exception 
     */  
    public static List<Map<String, Object>> upload(HttpServletRequest request,  
            String[] params, Map<String, Object[]> values) throws Exception {  
  
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();  
  
        MultipartHttpServletRequest mRequest = (MultipartHttpServletRequest) request;  
        Map<String, MultipartFile> fileMap = mRequest.getFileMap();  
  
        String uploadDir = request.getSession().getServletContext()  
                .getRealPath("/");  
        File file = new File(uploadDir);  
  
        if (!file.exists()) {  
            file.mkdir();  
        }  
  
        String fileName = null;  
        int i = 0;  
        for (Iterator<Map.Entry<String, MultipartFile>> it = fileMap.entrySet()  
                .iterator(); it.hasNext(); i++) {  
  
            Map.Entry<String, MultipartFile> entry = it.next();  
            MultipartFile mFile = entry.getValue();  
  
            fileName = mFile.getOriginalFilename();  
  
            String storeName = rename(fileName);  
  
            /*String noZipName = uploadDir + storeName;  
            String zipName = zipName(noZipName);  
  
            // 上传成为压缩文件  
            ZipOutputStream outputStream = new ZipOutputStream(  
                    new BufferedOutputStream(new FileOutputStream(zipName)));  
            outputStream.putNextEntry(new ZipEntry(fileName));  
            outputStream.setEncoding("GBK");  
  
            FileCopyUtils.copy(mFile.getInputStream(), outputStream);  */
  
            /*Map<String, Object> map = new HashMap<String, Object>();  
            // 固定参数值对  
            map.put(FileOperateUtil.REALNAME, zipName(fileName));  
            map.put(FileOperateUtil.STORENAME, zipName(storeName));  
            map.put(FileOperateUtil.SIZE, new File(zipName).length());  
            map.put(FileOperateUtil.SUFFIX, "zip");  
            map.put(FileOperateUtil.CONTENTTYPE, "application/octet-stream");  
            map.put(FileOperateUtil.CREATETIME, new Date());  
  
            // 自定义参数值对  
            for (String param : params) {  
                map.put(param, values.get(param)[i]);  
            }  
  
            result.add(map);  */
        }  
        return result;  
    }  
  
    /** 
     * 下载 
     *  
     * @param request 
     * @param response 
     * @param storeName 
     * @param contentType 
     * @param realName 
     * @throws Exception 
     */  
    public static void download(HttpServletRequest request,  
            HttpServletResponse response, String storeName, String contentType,  
            String realName){ 
    	BufferedInputStream bis = null;  
	    BufferedOutputStream bos = null;  
        response.setContentType("text/html;charset=UTF-8");  
        try {
			request.setCharacterEncoding("UTF-8");
		 
	       
	  
	        String ctxPath = request.getSession().getServletContext()  
	                .getRealPath("/")  
	                + UPLOADDIR ;  
	        String downLoadPath = ctxPath + storeName;  
	  
	        long fileLength = new File(downLoadPath).length();  
	  
	        response.setContentType(contentType);  
	        response.setHeader("Content-disposition", "attachment; filename="  
	                + new String(realName.getBytes("utf-8"), "ISO8859-1"));  
	        response.setHeader("Content-Length", String.valueOf(fileLength));  
	  
	        bis = new BufferedInputStream(new FileInputStream(downLoadPath));  
	        bos = new BufferedOutputStream(response.getOutputStream());  
	        byte[] buff = new byte[2048];  
	        int bytesRead;  
	        while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {  
	            bos.write(buff, 0, bytesRead);  
	        }  
        } catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			 try {
				bis.close();
				bos.close();
			} catch (IOException e) {
				e.printStackTrace();
			}  
		}
         
    }
	
    /*
     * 根据key获取web-info下的properties信息
     */
    public static String getMsg(String filePath,String key) throws IOException{
		String str = "";
		Properties props = new Properties();
        InputStream in = null;
        try {
            in = new FileInputStream(filePath);
            props.load(in);
            str = props.getProperty(key);
            return str;
        } catch(IOException e){
            e.printStackTrace();
            return null;
        } finally{
            if (null != in){
        		in.close();
            }
        }
	}
}  
