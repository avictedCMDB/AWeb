package com.avic.supplier.utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ReadExcel {

	// 读取单元格的数据,把一行行的数据保存到map中，用map来过滤重复身份证的数据
	public static List<List<String>> readExcelFile(InputStream is,String excelVersion) throws Exception {
		if ("".equals(excelVersion)) {
			throw new Exception();
		}
		List<List<String>> results = null;
		if ("2003".equals(excelVersion)) {
			results = read2003Excel(is);
		}else {
			results = read2007Excel(is);
		}
		
		return results;
	}
	
	private static List<List<String>> read2003Excel(InputStream is) throws IOException{
		List<List<String>> results = new ArrayList<List<String>>();
		HSSFWorkbook wb = new HSSFWorkbook(is);
		HSSFSheet sheet = wb.getSheetAt(0);
		HSSFRow row = sheet.getRow(0);
		int rowNum = sheet.getLastRowNum();
		int colNum = row.getPhysicalNumberOfCells();
        // 正文内容应该从第二行开始,第一行为表头的标题
        for (int i = 1; i <= rowNum; i++) {
        	List<String> item = new ArrayList<String>(); 
            row = sheet.getRow(i);
            int j = 0;
            while (j < colNum) {
            	item.add(get03StringCellValue(row.getCell(j)));
                j++;
            }
            results.add(item);
        }
		return results;
	}
	private static List<List<String>> read2007Excel(InputStream is) throws IOException{
		List<List<String>> results = new ArrayList<List<String>>();
		XSSFWorkbook wb = new XSSFWorkbook(is);
		XSSFSheet sheet = wb.getSheetAt(0);
		XSSFRow row = sheet.getRow(0);
		int rowNum = sheet.getLastRowNum();
		int colNum = row.getPhysicalNumberOfCells();
        // 正文内容应该从第二行开始,第一行为表头的标题
        for (int i = 1; i <= rowNum; i++) {
        	List<String> item = new ArrayList<String>(); 
            row = sheet.getRow(i);
            int j = 0;
            while (j < colNum) {
            	item.add(get07StringCellValue(row.getCell(j)));
                j++;
            }
            results.add(item);
        }
		return results;
	}
	  /**
     * 获取单元格数据内容为字符串类型的数据
     * 
     * @param cell Excel单元格
     * @return String 单元格数据内容
     */
    private static String get07StringCellValue(XSSFCell cell) {
        String strCell = "";
        if (cell == null) {
            return "";
        }
        switch (cell.getCellType()) {
        case HSSFCell.CELL_TYPE_STRING:
            strCell = cell.getStringCellValue();
            break;
        case HSSFCell.CELL_TYPE_NUMERIC:
            strCell = String.valueOf(cell.getNumericCellValue());
            break;
        case HSSFCell.CELL_TYPE_BOOLEAN:
            strCell = String.valueOf(cell.getBooleanCellValue());
            break;
        case HSSFCell.CELL_TYPE_BLANK:
            strCell = "";
            break;
        default:
            strCell = "";
            break;
        }
        if (strCell.equals("") || strCell == null) {
            return "";
        }
        return strCell;
    }
	  /**
     * 获取单元格数据内容为字符串类型的数据
     * 
     * @param cell Excel单元格
     * @return String 单元格数据内容
     */
    private static String get03StringCellValue(HSSFCell cell) {
        String strCell = "";
        if (cell == null) {
            return "";
        }
        switch (cell.getCellType()) {
        case HSSFCell.CELL_TYPE_STRING:
            strCell = cell.getStringCellValue();
            break;
        case HSSFCell.CELL_TYPE_NUMERIC:
            strCell = String.valueOf(cell.getNumericCellValue());
            break;
        case HSSFCell.CELL_TYPE_BOOLEAN:
            strCell = String.valueOf(cell.getBooleanCellValue());
            break;
        case HSSFCell.CELL_TYPE_BLANK:
            strCell = "";
            break;
        default:
            strCell = "";
            break;
        }
        if (strCell.equals("") || strCell == null) {
            return "";
        }
        return strCell;
    }
}