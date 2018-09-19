package com.avic.management.models;

import java.util.ArrayList;
import java.util.List;


public class BidProjSubject {
    String projId;
    String subjectId;
    String subjectName;
    Double subjectNum;
    String subjectUnit;
    String intro;
    
    String maters;
    
    public String getMaters() {
        return maters;
    }
    public void setMaters(String maters) {
        this.maters = maters;
    }
    public String getProjId() {
        return projId;
    }
    public void setProjId(String projId) {
        this.projId = projId;
    }
    public String getSubjectId() {
        return subjectId;
    }
    public void setSubjectId(String subjectId) {
        this.subjectId = subjectId;
    }
    public String getSubjectName() {
        return subjectName;
    }
    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }
    public Double getSubjectNum() {
        return subjectNum;
    }
    public void setSubjectNum(Double subjectNum) {
        this.subjectNum = subjectNum;
    }
    public String getSubjectUnit() {
        return subjectUnit;
    }
    public void setSubjectUnit(String subjectUnit) {
        this.subjectUnit = subjectUnit;
    }
    public String getIntro() {
        return intro;
    }
    public void setIntro(String intro) {
        this.intro = intro;
    }
    
    
}
