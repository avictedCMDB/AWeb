package com.avic.common.imageUpload;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang3.math.NumberUtils;

import com.avic.common.constants.SessionKeys;
import com.avic.common.constants.UserRole;
import com.avic.common.utils.ConfigHolder;
import com.avic.common.utils.Permission;
import com.avic.passport.models.User;

/**
 * Servlet implementation class for Servlet: UploadServlet
 * 
 */
public class UploadServlet extends javax.servlet.http.HttpServlet implements
		javax.servlet.Servlet {
	static final long serialVersionUID = 1L;

	public static final String UPLOAD_STATUS = "UPLOAD_STATUS";

	private String UPLOAD_DIR;//�ļ��ϴ�·��

	public String getUPLOAD_DIR() {
		return UPLOAD_DIR;
	}

	public void setUPLOAD_DIR(String upload_dir) {
		UPLOAD_DIR = upload_dir;
	}

	public UploadServlet() {
		super();
	}

	/**
	 * ���ļ�·����ȡ���ļ���
	 * 
	 * @param filePath
	 * @return
	 */
	private String takeOutFileName(String filePath) {
		int pos = filePath.lastIndexOf(File.separator);
		if (pos > 0) {
			return filePath.substring(pos + 1);
		} else {
			return filePath;
		}
	}

	/**
	 * ��request��ȡ��FileUploadStatus Bean
	 * 
	 * @param request
	 * @return
	 */
	public static FileUploadStatus takeOutFileUploadStatusBean(
			HttpSession session) {
		Object obj = session.getAttribute(UPLOAD_STATUS);
		if (obj != null) {
			return (FileUploadStatus) obj;
		} else {
			return null;
		}
	}

	/**
	 * ��FileUploadStatus Bean���浽session
	 * 
	 * @param request
	 * @param uploadStatusBean
	 */
	public static void storeFileUploadStatusBean(HttpSession session,
			FileUploadStatus uploadStatusBean) {
		session.setAttribute(UPLOAD_STATUS, uploadStatusBean);
	}

	/**
	 * ɾ���Ѿ��ϴ����ļ�
	 * 
	 * @param request
	 */
	private void deleteUploadedFile(HttpServletRequest request) {
		FileUploadStatus fUploadStatus = takeOutFileUploadStatusBean(request
				.getSession());
		File uploadedFile = new File(request.getRealPath(fUploadStatus.getDelImgName()));
		uploadedFile.delete();
		fUploadStatus.setStatus("ɾ�����ϴ����ļ�");
		storeFileUploadStatusBean(request.getSession(), fUploadStatus);
	}

	/**
	 * �ϴ������г�������
	 * 
	 * @param request
	 * @param errMsg
	 * @throws IOException
	 * @throws ServletException
	 */
	private void uploadExceptionHandle(HttpServletRequest request, String errMsg)
			throws ServletException, IOException {
		// ����ɾ���Ѿ��ϴ����ļ�
		deleteUploadedFile(request);
		FileUploadStatus fUploadStatus = takeOutFileUploadStatusBean(request
				.getSession());
		fUploadStatus.setStatus(errMsg);
		storeFileUploadStatusBean(request.getSession(), fUploadStatus);
	}

	/**
	 * ��ʼ���ļ��ϴ�״̬Bean
	 * 
	 * @param request
	 * @return
	 */
	private FileUploadStatus initFileUploadStatusBean(HttpServletRequest request) {
		FileUploadStatus fUploadStatus = new FileUploadStatus();
		fUploadStatus.setStatus("�ϴ���...");
		fUploadStatus.setUploadTotalSize(request.getContentLength());
		fUploadStatus.setProcessStartTime(System.currentTimeMillis());
		String mark = request.getParameter("mark");
		fUploadStatus.setMark(mark);
		if("buy".equals(mark) || "chk".equals(mark)){
			this.setUPLOAD_DIR(ConfigHolder.getInstance().getConfig("market_url"));
		}else if("sup".equals(mark)){
			this.setUPLOAD_DIR(ConfigHolder.getInstance().getConfig("supplier_url"));
		}else{//�Ǳ���Ʒά��
			this.setUPLOAD_DIR(ConfigHolder.getInstance().getConfig("off_standard"));
		}
		fUploadStatus.setBaseDir(request.getContextPath() + this.getUPLOAD_DIR());
		fUploadStatus.setImgCount(request.getParameter("imgCount"));
		fUploadStatus.setDelImgName(request.getParameter("delImgName"));
		String cancelStr = request.getParameter("cancel");
		if(cancelStr!=null && !"".equals(cancelStr)){
			fUploadStatus.setCancel(Boolean.valueOf(cancelStr));
			fUploadStatus.setDelImgName(request.getParameter("delImgName"));
		}
		return fUploadStatus;
	}

	/**
	 * �����ļ��ϴ�
	 * 
	 * @param request
	 * @param response
	 * @throws IOException
	 * @throws ServletException
	 */
	private void processFileUpload(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		DiskFileItemFactory factory = new DiskFileItemFactory();
		// �����ڴ淧ֵ��������д����ʱ�ļ�
		// factory.setSizeThreshold(10240000*5);
		// ������ʱ�ļ��洢λ��
		// factory.setRepository(new File(request.getRealPath("/upload/temp")));
		ServletFileUpload upload = new ServletFileUpload(factory);
		//���õ����ļ�������ϴ�size
//		upload.setFileSizeMax(1024000*4);
		// ��������request�����size
		// upload.setSizeMax(10240000*5);
		// ע�������
		upload.setProgressListener(new UploadListener(request.getSession()));
		// �����ʼ�����FileUploadStatus Bean
		storeFileUploadStatusBean(request.getSession(),
				initFileUploadStatusBean(request));

		try {
			List items = upload.parseRequest(request);
			// �����ļ��ϴ�
			for (int i = 0; i < items.size(); i++) {
				FileItem item = (FileItem) items.get(i);

				// ȡ���ϴ�
				if (takeOutFileUploadStatusBean(request.getSession())
						.getCancel()) {
					deleteUploadedFile(request);
					break;
				}
				// �����ļ�
				else if (!item.isFormField() && item.getName().length() > 0) {
					String realFileName = takeOutFileName(item.getName());
					String fileName_suffix = takeOutFileName(item.getName());
					//��ȡ�ļ���׺
					if(fileName_suffix.lastIndexOf(".")>0){
						fileName_suffix=fileName_suffix.substring(fileName_suffix.lastIndexOf("."), fileName_suffix.length()).toLowerCase();
					}
					SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");//�������ڸ�ʽ
					String fileName = realFileName.substring(0,realFileName.lastIndexOf(".")) + df.format(new Date()) + fileName_suffix;
					
					String mark = request.getParameter("mark");
					String userId = "default";
					User user = null;
					try {
						if("buy".equals(mark) || "ask".equals(mark)){
							//������
				            user = Permission.check(request.getSession(), UserRole.BUY, UserRole.CLIENT);
				            userId = user.getUserId();
				            System.out.println("===============buy-userId="+userId);
						}else if("chk".equals(mark)){
							//�����
							user = Permission.check(request.getSession(), UserRole.CHECK, UserRole.CLIENT);
				            userId = user.getUserId();
				            System.out.println("===============chk-userId="+userId);
						}else if("sup".equals(mark)){
							//������
							String supId = request.getSession().getAttribute(SessionKeys.SUP_ID).toString();
							userId = supId;
							System.out.println("===============sup-userId="+userId);
						}
					} catch (Exception e) {
			        	System.out.println("�ļ��ϴ�ʱ����ȡ�û���ʧ�ܡ�");
			        }
					
					String directory = request.getSession().getServletContext().getRealPath(this.getUPLOAD_DIR()) + File.separator + userId + File.separator;//�ϴ�ʵ��·��
					String show_dir = this.getUPLOAD_DIR() + "/" + userId + "/";//ҳ�����ͼƬ·��
					File uploadedFile = new File(directory,fileName);
			        if(uploadedFile.exists()) {
			          // �ļ��Ѿ����ڣ�����ļ��������Ϣ
			            System.out.println("��"+directory+"���ļ�·���Ѿ����ڣ������ٴδ�����");
			        } else {
			          //  �ļ�·�������ڣ��ȴ����ļ����ڵ�Ŀ¼
			        	uploadedFile.getParentFile().mkdirs();
			        }
					
					item.write(uploadedFile);
					// �����ϴ��ļ��б�
					FileUploadStatus fUploadStatus = takeOutFileUploadStatusBean(request
							.getSession());
					fUploadStatus.setBaseDir(show_dir);
					fUploadStatus.getUploadFileUrlList().add(fileName);
					storeFileUploadStatusBean(request.getSession(),
							fUploadStatus);
					Thread.sleep(500);
				}
			}

		} catch (FileUploadException e) {
			e.printStackTrace();
			// uploadExceptionHandle(request,"�ϴ��ļ�ʱ��������:"+e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			// uploadExceptionHandle(request,"�����ϴ��ļ�ʱ��������:"+e.getMessage());
		}
	}

	/**
	 * ��Ӧ�ϴ�״̬��ѯ
	 * 
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	private void responseFileUploadStatusPoll(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		FileUploadStatus fUploadStatus = (FileUploadStatus) request
				.getSession().getAttribute(UPLOAD_STATUS);
		// �����ϴ���ɵİٷֱ�
		long percentComplete = (long) Math.floor(((double) fUploadStatus
				.getReadTotalSize() / (double) fUploadStatus
				.getUploadTotalSize()) * 100.0);
		System.out.println("com:" + percentComplete);
		response.setContentType("text/xml");
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		if (((long) fUploadStatus.getReadTotalSize() == (long) fUploadStatus
				.getUploadTotalSize())
				|| (fUploadStatus.getCancel() == true)) {
			List uploadFileList = fUploadStatus.getUploadFileUrlList();
			int imgSort = NumberUtils.toInt(fUploadStatus.getImgCount())+1;
			String imgPathHiddenHtml = "<input id='hiddenPath_"+imgSort+"' name='hidden_path' type='hidden' value='"+fUploadStatus.getBaseDir()
					+uploadFileList.get(uploadFileList.size()-1)+"'>";
			response.getWriter().write(imgPathHiddenHtml);//��ͼƬ·��������
		} else {
			response
					.getWriter()
					.write(
							fUploadStatus.getStatus().toString()
									+ "<div class=\"prog-border\"><div class=\"prog-bar\" style=\"width: "
									+ percentComplete + "%;\"></div></div>");
		}
	}

	/**
	 * ����ȡ���ļ��ϴ�
	 * 
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	private void processCancelFileUpload(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		FileUploadStatus fUploadStatus = (FileUploadStatus) request
				.getSession().getAttribute(UPLOAD_STATUS);
		fUploadStatus.setCancel(true);
		request.getSession().setAttribute(UPLOAD_STATUS, fUploadStatus);
		responseFileUploadStatusPoll(request, response);
	}

	/**
	 * ���ϴ��ļ��б��в������ļ�����ص�id
	 * 
	 * @param request
	 * @param fileName
	 *            �ļ���
	 * @return �ҵ�����id,���򷵻�-1
	 */
	private int findFileIdInFileUploadedList(HttpServletRequest request,
			String fileName) {
		FileUploadStatus fileUploadStatus = takeOutFileUploadStatusBean(request
				.getSession());
		for (int i = 0; i < fileUploadStatus.getUploadFileUrlList().size(); i++) {
			if (fileName.equals((String) fileUploadStatus
					.getUploadFileUrlList().get(i))) {
				return i;
			}
		}
		return -1;
	}
	
	/**
	 * ɾ��ͼƬ
	 */
	private void deleteFile(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String delImgName = java.net.URLDecoder.decode(request.getParameter("delImgName") , "UTF-8");;
		File deleteFile = new File(request.getRealPath(delImgName));
        deleteFile(deleteFile);
	}
	
	private void deleteFile(File f) {
        // ������ļ�,ֱ��ɾ��
        if (f.isFile()) {
            f.delete();
            return;
        }
    }

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		String cancelStr = request.getParameter("cancel");
		//ɾ��ͼƬ
		if(("true".equals(cancelStr))){
			deleteFile(request,response);
		}
		
		if (isMultipart) {
			processFileUpload(request, response);
		} else {
			request.setCharacterEncoding("UTF-8");

			if (request.getParameter("uploadStatus") != null) {
				//��Ӧ�ϴ�״̬��ѯ
				responseFileUploadStatusPoll(request, response);
			}
			if (request.getParameter("cancelUpload") != null) {
				processCancelFileUpload(request, response);
			}
		}
	}
	
}