package com.avic.supplier.utils;

import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;

public class NewExcel {

	/**
	 * ����execl
	 * 
	 * @param excelPath
	 *            ������excel������·��
	 * @param columnName
	 *            excel�����ֶ���
	 * @param values
	 *            excelֵ
	 * @return
	 */
	public static boolean createExcel(HttpServletResponse resp,List<String> columnName,List<List<String>> values) {
		boolean isCreateSuccess = false;
		HSSFWorkbook workbook = null;
		try {
			// XSSFWork used for .xslx (>= 2007), HSSWorkbook for 03 .xsl
			workbook = new HSSFWorkbook();// HSSFWorkbook();//WorkbookFactory.create(inputStream);
		} catch (Exception e) {
			System.out.println("It cause Error on CREATING excel workbook: ");
			e.printStackTrace();
		}
		if (workbook != null) {
			Sheet sheet = workbook.createSheet("sheet");
			Row row0 = sheet.createRow(0);
			for (int i = 0; i < columnName.size(); i++) {
				Cell cell_1 = row0.createCell(i, Cell.CELL_TYPE_STRING);
				CellStyle style = getStyle(workbook);
				cell_1.setCellStyle(style);
				cell_1.setCellValue(columnName.get(i));
				sheet.autoSizeColumn(i);
			}
			for (int rowNum = 0; rowNum < values.size(); rowNum++) {
				Row row = sheet.createRow(rowNum+1);
				for (int i = 0; i < values.get(rowNum).size(); i++) {
					Cell cell = row.createCell(i, Cell.CELL_TYPE_STRING);
					cell.setCellValue(values.get(rowNum).get(i));
				}
			}
			try {
				OutputStream out = resp.getOutputStream();
				workbook.write(out);
				out.flush();
				out.close();
				isCreateSuccess = true;
			} catch (Exception e) {
				System.out
						.println("It cause Error on WRITTING excel workbook: ");
				e.printStackTrace();
			}
		}
		return isCreateSuccess;
	}

	private static CellStyle getStyle(Workbook workbook) {
		CellStyle style = workbook.createCellStyle();
		style.setAlignment(CellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		// ���õ�Ԫ������
		Font headerFont = workbook.createFont(); // ����
		headerFont.setFontHeightInPoints((short) 14);
//		headerFont.setColor(HSSFColor.RED.index);
		headerFont.setFontName("����");
		style.setFont(headerFont);
		style.setWrapText(true);

		// ���õ�Ԫ��߿���ɫ
//		style.setBorderBottom((short) 1);
//		style.setBorderLeft((short) 1);
//		style.setBorderRight((short) 1);
//		style.setBorderTop((short) 1);
//		style.setWrapText(true);
		return style;
	}
	public static void main(String[] args) {
		List<String> aa = new ArrayList<String>();
		List<List<String>> bb = new ArrayList<List<String>>();
		List<String> cc = new ArrayList<String>();
		List<String> dd = new ArrayList<String>();
		aa.add("����01");
		aa.add("����02");
		cc.add("1");
		cc.add("2");
		dd.add("3");
		dd.add("4");
		bb.add(cc);
		bb.add(dd);
//		NewExcel.createExcel("C:\\eclipse_AGB\\aaa.xlsx", aa, bb);
	}
}