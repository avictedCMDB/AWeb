package com.avic.supplier.models;

import java.util.Date;

public class SupplierContract {
    private String projId;
    private String supCode;
    private String fileId;
    private String fileName;
    private String filePath;
    private Date uploadTime;
    private int fileVersion;
    public String getProjId() {
        return projId;
    }
    public void setProjId(String projId) {
        this.projId = projId;
    }
    public String getSupCode() {
        return supCode;
    }
    public void setSupCode(String supCode) {
        this.supCode = supCode;
    }
    public String getFileId() {
        return fileId;
    }
    public void setFileId(String fileId) {
        this.fileId = fileId;
    }
    public String getFileName() {
        return fileName;
    }
    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
    public String getFilePath() {
        return filePath;
    }
    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }
    public Date getUploadTime() {
        return uploadTime;
    }
    public void setUploadTime(Date uploadTime) {
        this.uploadTime = uploadTime;
    }
    public int getFileVersion() {
        return fileVersion;
    }
    public void setFileVersion(int fileVersion) {
        this.fileVersion = fileVersion;
    }
    
    
}
