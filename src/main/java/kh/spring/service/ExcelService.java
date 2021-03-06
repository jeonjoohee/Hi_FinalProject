package kh.spring.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kh.spring.dao.MailDAO;
import kh.spring.dao.MealDAO;
import kh.spring.dto.MealDTO;
import kh.spring.dto.MemberDTO;
import kh.spring.dto.St_MailDTO;

@Service
public class ExcelService {

	@Autowired
	private MealDAO dao;

	@Autowired
	private MailDAO st_dao;

	// 저장된 파일 삭제
	public void deleteExcel(String realPath, String fileName) {
		System.out.println(realPath + "/" + fileName);
		File deleteFile = new File(realPath + "/" + fileName);
		if(deleteFile.exists()) {
			deleteFile.delete(); // 파일이 존재한다면 삭제
			System.out.println("파일삭제완료");
		}else {
			System.out.println("해당파일이 존재하지 않습니다.");
		}
	}

	// db저장되어있는 식단 엑셀 다운로드
	public void excelDownload(String month, MemberDTO mdto, HttpServletResponse response) throws IOException {		
		XSSFWorkbook wb = new XSSFWorkbook();
		Sheet sheet = wb.createSheet(month + "월 식단표");
		Row row = null;
		Cell cell = null;
		int rowNum = 0;

		// 공통 스타일
		CellStyle commonStyle = wb.createCellStyle(); // title 셀 스타일 설정
		commonStyle.setAlignment(HorizontalAlignment.CENTER); // 가운데 정렬
		commonStyle.setVerticalAlignment(VerticalAlignment.CENTER);

		// title
		Font font = wb.createFont();
		font.setBold(true); // 굵은 글씨
		font.setFontHeightInPoints((short)14);

		CellStyle titleStyle = wb.createCellStyle(); // title 셀 스타일 설정
		titleStyle.setAlignment(HorizontalAlignment.CENTER); // 가운데 정렬
		titleStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		titleStyle.setFont(font);

		sheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 6)); // 셀병함

		row = sheet.createRow(rowNum++);
		cell = row.createCell(0);
		cell.setCellStyle(titleStyle); // title 셀 스타일 적용
		cell.setCellValue(month + "월 " + mdto.getSchool() + " 식단표");

		// 빈행 추가
		sheet.createRow(rowNum++); 
		row = sheet.createRow(rowNum++); 

		// Header
		row = sheet.createRow(rowNum++);
		cell = row.createCell(0);
		cell.setCellStyle(commonStyle);
		cell.setCellValue("날짜");
		cell = row.createCell(1);
		cell.setCellStyle(commonStyle);
		cell.setCellValue("메뉴1");		
		cell = row.createCell(2);
		cell.setCellStyle(commonStyle);
		cell.setCellValue("메뉴2");		
		cell = row.createCell(3);
		cell.setCellStyle(commonStyle);
		cell.setCellValue("메뉴3");		
		cell = row.createCell(4);
		cell.setCellStyle(commonStyle);
		cell.setCellValue("메뉴4");		
		cell = row.createCell(5);
		cell.setCellStyle(commonStyle);
		cell.setCellValue("메뉴5");		
		cell = row.createCell(6);
		cell.setCellStyle(commonStyle);
		cell.setCellValue("메뉴6");

		// Body
		CellStyle dateStyle = wb.createCellStyle(); // 날짜 셀 스타일 설정
		dateStyle.setDataFormat(wb.getCreationHelper().createDataFormat().getFormat("yy/mm/dd (aaa)")); // 수요일 하고싶으면 aaaa 
		dateStyle.setAlignment(HorizontalAlignment.CENTER); // 가운데 정렬
		dateStyle.setVerticalAlignment(VerticalAlignment.CENTER);

		Map<String, String> param = new HashMap<>();
		param.put("month", month);
		param.put("writer", mdto.getEmail());
		param.put("school", mdto.getSchool());

		List<MealDTO> list = dao.excelDownloadList(param);

		for (MealDTO dto : list) {
			row = sheet.createRow(rowNum++);

			cell = row.createCell(0);
			cell.setCellStyle(dateStyle);
			cell.setCellValue(dto.getMeal_date());

			cell = row.createCell(1);
			cell.setCellStyle(commonStyle);
			cell.setCellValue(dto.getMenu1());
			cell = row.createCell(2);
			cell.setCellStyle(commonStyle);
			cell.setCellValue(dto.getMenu2());
			cell = row.createCell(3);
			cell.setCellStyle(commonStyle);
			cell.setCellValue(dto.getMenu3());
			cell = row.createCell(4);
			cell.setCellStyle(commonStyle);
			cell.setCellValue(dto.getMenu4());
			cell = row.createCell(5);
			cell.setCellStyle(commonStyle);
			cell.setCellValue(dto.getMenu5());
			cell = row.createCell(6);
			cell.setCellStyle(commonStyle);
			cell.setCellValue(dto.getMenu6());
		}

		sheet.setColumnWidth(0, 4000);
		for (int i=1;i<7;i++) {
			sheet.autoSizeColumn(i);
			sheet.setColumnWidth(i, (sheet.getColumnWidth(i)) + (short)1024); 
			//이건 자동으로 조절 하면 너무 딱딱해 보여서 자동조정한 사이즈에 (short)512를 추가해 주니 한결 보기 나아졌다.
		}

		// 컨텐츠 타입과 파일명 지정
		response.reset();
		response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(month + "월 " +mdto.getSchool() + " 식단표", "UTF-8") + ".xlsx");
		response.setContentType("ms-vnd/excel");

		// Excel File Output
		wb.write(response.getOutputStream());
		wb.close();
	}


	// 엑셀 업로드양식 다운
	public void excelform(HttpServletResponse response) throws IOException {		
		Workbook wb = new XSSFWorkbook();
		Sheet sheet = wb.createSheet("sheet1");
		Row row = null;
		Cell cell = null;
		int rowNum = 0;

		// 공통 스타일
		CellStyle style = wb.createCellStyle(); // title 셀 스타일 설정
		style.setAlignment(HorizontalAlignment.CENTER); // 가운데 정렬
		style.setVerticalAlignment(VerticalAlignment.CENTER);

		// title
		row = sheet.createRow(rowNum++);
		cell = row.createCell(0);
		cell.setCellValue("월은 06,11 형식, 날짜는 2021-07-21 (월) 형식으로 작성 부탁드립니다. 메뉴는 최소 2개부터 최대 6개까지만 등록가능합니다.");

		// 빈행 추가
		sheet.createRow(rowNum++); 
		//row = sheet.createRow(rowNum++); 

		// Header
		row = sheet.createRow(rowNum++);
		cell = row.createCell(0);
		cell.setCellStyle(style);
		cell.setCellValue("월");
		cell = row.createCell(1);
		cell.setCellStyle(style);
		cell.setCellValue("날짜");
		cell = row.createCell(2);
		cell.setCellStyle(style);
		cell.setCellValue("메뉴1");		
		cell = row.createCell(3);
		cell.setCellStyle(style);
		cell.setCellValue("메뉴2");		
		cell = row.createCell(4);
		cell.setCellStyle(style);
		cell.setCellValue("메뉴3");		
		cell = row.createCell(5);
		cell.setCellStyle(style);
		cell.setCellValue("메뉴4");		
		cell = row.createCell(6);
		cell.setCellStyle(style);
		cell.setCellValue("메뉴5");		
		cell = row.createCell(7);
		cell.setCellStyle(style);
		cell.setCellValue("메뉴6");

		// 컨텐츠 타입과 파일명 지정
		response.reset();
		response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode("식단 업로드 양식", "UTF-8") + ".xlsx");
		response.setContentType("ms-vnd/excel");

		// Excel File Output
		wb.write(response.getOutputStream());
		wb.close();
	}

	// 엑셀에 저장되어 있는 식단 db에 업로드
	public String excelupload(MemberDTO dto, MultipartFile file, String realPath) throws Exception {
		System.out.println("service");
		File filesPath = new File(realPath);
		if(!filesPath.exists()) {
			filesPath.mkdir();
		}
		String oriName = file.getOriginalFilename();
		String sysName = UUID.randomUUID().toString().replace("-", "") + "_" + oriName;
		file.transferTo(new File(filesPath.getAbsolutePath()+"/"+sysName));

		List<MealDTO> list = readExcel(dto, filesPath.getAbsolutePath()+"/"+sysName);
		String[] month = new String[1];

		for(MealDTO m : list) {
			month[0] = m.getMonth();
			System.out.println(m.getMonth() + " : " + m.getMeal_date() + " : " + m.getSchool() + " : " 
					+ m.getWriter() + " : " + m.getMenu1() + " : " + m.getMenu2() + " : " + m.getMenu3()
					+ " : " + m.getMenu4() + " : " + m.getMenu5() + " : " + m.getMenu6() + " : " + m.getOriName()
					+ " : " + m.getSysName() + "끝"); 
		}

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);

		dao.excelupload(map);
		deleteExcel(realPath,sysName);
		return month[0];
	}

	// 엑셀 읽는 코드
	private List<MealDTO> readExcel(MemberDTO m, String filePath) throws Exception {
		System.out.println("readExcel");
		List<MealDTO> list = new ArrayList<>();

		FileInputStream fis = new FileInputStream(filePath);

		Workbook workbook = null; // 초기화

		workbook = new XSSFWorkbook(fis);

		XSSFRow curRow;

		XSSFSheet sheet = (XSSFSheet) workbook.getSheetAt(0);
		int totalRowNum = sheet.getPhysicalNumberOfRows();
		//			int numberOfSheets = workbook.getNumberOfSheets(); // 시트의 갯수 추출

		//			 for (int i = 0; i < numberOfSheets; i++) {
		//				 // 현재 sheet 반환
		//				 curSheet = (XSSFSheet) workbook.getSheetAt(i);

		//4번째 행(row)부터 0~7셀(cell)을 1개의 dto에 담아야 한다. 
		Loop1 : for(int i=3;i<totalRowNum+1;i++) { // 0부터 시작, 4번째 행(row) 추출
			MealDTO dto = new MealDTO();
			curRow = sheet.getRow(i); 

			if(curRow.getCell(4) == null || curRow.getCell(4).equals("")) {
				break Loop1;
			}else {
				dto.setMonth(curRow.getCell(0).getStringCellValue());

				// String -> sql.date로 변경해서 dto.getMeal_date에 담기
				String mealDate;
				if(curRow.getCell(1).getCellType() == CellType.STRING) {
					mealDate = curRow.getCell(1).getStringCellValue();
				}else if(curRow.getCell(1).getCellType() == CellType.NUMERIC) {
					mealDate = String.valueOf(curRow.getCell(1).getStringCellValue());
				}else {
					mealDate = curRow.getCell(1).getStringCellValue();
				}

				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				Date date = new Date(sdf.parse(mealDate).getTime());
				dto.setMeal_date(date);

				dto.setSchool(m.getSchool());
				dto.setWriter(m.getEmail());

				// menu1,2는 무조건 등록
				dto.setMenu1(curRow.getCell(2).getStringCellValue());
				dto.setMenu2(curRow.getCell(3).getStringCellValue());

				if(curRow.getCell(4) == null || curRow.getCell(4).equals("")) {
					dto.setMenu3("");
				}else {dto.setMenu3(curRow.getCell(4).getStringCellValue());}

				if(curRow.getCell(5) == null || curRow.getCell(5).equals("")) {
					dto.setMenu4("");
				}else {dto.setMenu4(curRow.getCell(5).getStringCellValue());}

				if(curRow.getCell(6) == null || curRow.getCell(6).equals("")) {
					dto.setMenu5("");
				}else {dto.setMenu5(curRow.getCell(6).getStringCellValue());}

				if(curRow.getCell(7) == null || curRow.getCell(7).equals("")) {
					dto.setMenu6("");
				}else {dto.setMenu6(curRow.getCell(7).getStringCellValue());}

				dto.setOriName("");
				dto.setSysName("");

				list.add(dto);
			}
		}
		fis.close();

		return list;
	}

	// 청아 셀 양식 넘버릭 오류 고치는 함수
	public static String getStringValue(Cell cell) {
		String rtnValue = "";
		try {
			rtnValue = cell.getStringCellValue();
		} catch(IllegalStateException e) { // 스프링을 cell에 넣었을때 오류가 난다면 
			rtnValue = Integer.toString((int)cell.getNumericCellValue()); // 셀 타입을 강제로 string으로 변환.           
		}
		return rtnValue;
	}


	//승희 메일 엑셀업로드 양식
	// 엑셀 업로드양식 다운
	public void excelformMail(HttpServletResponse response) throws IOException {		
		Workbook wb = new XSSFWorkbook();//엑셀파일 생성 .xlsx
		Sheet sheet = wb.createSheet("sheet1");//하나의 시트 ("sheet1") 시트이름
		Row row = null;//변수선언 가로 로우 
		Cell cell = null;//콜스 느낌 한줄에 칸들
		int rowNum = 0;//로우번호 아래로 123번째줄

		// 공통 스타일
		CellStyle style = wb.createCellStyle(); // title 셀 스타일 설정
		style.setAlignment(HorizontalAlignment.CENTER); // 가운데 정렬
		style.setVerticalAlignment(VerticalAlignment.CENTER);//상하가운데정렬

		// title-맨윗줄 1열
		row = sheet.createRow(rowNum++);//로우 한칸 내려오면서 한줄 만든 느낌
		cell = row.createCell(0);//한칸 만들어줌
		//만든거에 선택 헤서 내용 삽입
		cell.setCellValue("학생 이름과 이메일을 작성해 주세요. 이메일은 형식에 맞게 작성부탁드립니다.");
		//cell.setCellValue("월은 06,11 형식, 날짜는 2021-07-21 (월) 형식으로 작성 부탁드립니다. 메뉴는 최소 2개부터 최대 6개까지만 등록가능합니다.");

		// 빈행 추가-2열 추가 빈공간
		sheet.createRow(rowNum++); 
		//row = sheet.createRow(rowNum++); 

		//본내용 
		// Header
		row = sheet.createRow(rowNum++);
		cell = row.createCell(0);
		cell.setCellStyle(style);
		cell.setCellValue("학생 이름");
		cell = row.createCell(1);
		cell.setCellStyle(style);
		cell.setCellValue("이메일");

		// 컨텐츠 타입과 파일명 지정
		response.reset();
		response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode("학생 이메일 업로드 양식", "UTF-8") + ".xlsx");
		response.setContentType("ms-vnd/excel");

		// Excel File Output
		wb.write(response.getOutputStream());
		wb.close();
	}

	// 승희 엑셀에 저장되어 있는 학생주소록 db에 저장
	public void exceluploadMail(MemberDTO dto, MultipartFile file, String realPath) throws Exception {
		System.out.println("service");
		File filesPath = new File(realPath);
		if(!filesPath.exists()) {
			filesPath.mkdir();
		}
		String oriName = file.getOriginalFilename();
		String sysName = UUID.randomUUID().toString().replace("-", "") + "_" + oriName;
		file.transferTo(new File(filesPath.getAbsolutePath()+"/"+sysName));

		List<St_MailDTO> list = readExcelMail(dto, filesPath.getAbsolutePath()+"/"+sysName);

		for(St_MailDTO m : list) {
			System.out.println(m.getSchool() + " : " + m.getStu_name() + " : " + m.getStu_email() + " : " + m.getNu_email());
		}

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);

//		st_dao.excelupload(map);
	}

	// 승희 엑셀 읽는 코드(학생 주소록)
	private List<St_MailDTO> readExcelMail(MemberDTO m, String filePath) throws Exception {
		System.out.println("readExcel");
		List<St_MailDTO> list = new ArrayList<>();

		FileInputStream fis = new FileInputStream(filePath);

		Workbook workbook = null; // 초기화

		workbook = new XSSFWorkbook(fis);

		XSSFRow curRow;

		XSSFSheet sheet = (XSSFSheet) workbook.getSheetAt(0);//시트번호
		int totalRowNum = sheet.getPhysicalNumberOfRows();//로우 개수 

		//4번째 행(row)부터 0~7셀(cell)을 1개의 dto에 담아야 한다. 
		Loop1 : for(int i=3;i<totalRowNum+1;i++) { // 0부터 시작, 4번째 행(row) 추출
			St_MailDTO dto = new St_MailDTO();
			curRow = sheet.getRow(i); 

			if(curRow.getCell(0) == null || curRow.getCell(0).equals("")) {
				break Loop1;
			}else {
				dto.setSchool(m.getSchool());
				dto.setStu_name(curRow.getCell(0).getStringCellValue());
				dto.setStu_email(curRow.getCell(1).getStringCellValue());
				dto.setNu_email(m.getEmail());
				
				st_dao.addStudent(dto); // oracle은 insert all에서 seq.nextval이 안먹어서 한줄씩 넣어준다.
				list.add(dto);
			}
		}
		fis.close();

		return list;
	}

	// 승희 메일보낼때 엑셀 원하는 곳에 저장하기
	public void excelDownloadMail(String month, MemberDTO dto, String realPath, HttpServletResponse response) throws IOException {		
		XSSFWorkbook wb = new XSSFWorkbook();
		Sheet sheet = wb.createSheet(month + "월 식단표");
		Row row = null;
		Cell cell = null;
		int rowNum = 0;

		// 공통 스타일
		CellStyle commonStyle = wb.createCellStyle(); // title 셀 스타일 설정
		commonStyle.setAlignment(HorizontalAlignment.CENTER); // 가운데 정렬
		commonStyle.setVerticalAlignment(VerticalAlignment.CENTER);

		// title
		Font font = wb.createFont();
		font.setBold(true); // 굵은 글씨
		font.setFontHeightInPoints((short)14);

		CellStyle titleStyle = wb.createCellStyle(); // title 셀 스타일 설정
		titleStyle.setAlignment(HorizontalAlignment.CENTER); // 가운데 정렬
		titleStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		titleStyle.setFont(font);

		sheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 6)); // 셀병함

		row = sheet.createRow(rowNum++);
		cell = row.createCell(0);
		cell.setCellStyle(titleStyle); // title 셀 스타일 적용
		cell.setCellValue(month + "월 " + dto.getSchool() + " 식단표");

		// 빈행 추가
		sheet.createRow(rowNum++); 
		row = sheet.createRow(rowNum++); 

		// Header
		row = sheet.createRow(rowNum++);
		cell = row.createCell(0);
		cell.setCellStyle(commonStyle);
		cell.setCellValue("날짜");
		cell = row.createCell(1);
		cell.setCellStyle(commonStyle);
		cell.setCellValue("메뉴1");		
		cell = row.createCell(2);
		cell.setCellStyle(commonStyle);
		cell.setCellValue("메뉴2");		
		cell = row.createCell(3);
		cell.setCellStyle(commonStyle);
		cell.setCellValue("메뉴3");		
		cell = row.createCell(4);
		cell.setCellStyle(commonStyle);
		cell.setCellValue("메뉴4");		
		cell = row.createCell(5);
		cell.setCellStyle(commonStyle);
		cell.setCellValue("메뉴5");		
		cell = row.createCell(6);
		cell.setCellStyle(commonStyle);
		cell.setCellValue("메뉴6");

		// Body
		CellStyle dateStyle = wb.createCellStyle(); // 날짜 셀 스타일 설정
		dateStyle.setDataFormat(wb.getCreationHelper().createDataFormat().getFormat("yy/mm/dd (aaa)")); // 수요일 하고싶으면 aaaa 
		dateStyle.setAlignment(HorizontalAlignment.CENTER); // 가운데 정렬
		dateStyle.setVerticalAlignment(VerticalAlignment.CENTER);

		Map<String, String> param = new HashMap<>();
		param.put("month", month);
		param.put("writer", dto.getEmail());
		param.put("school", dto.getSchool());

		List<MealDTO> list = dao.excelDownloadList(param);

		for (MealDTO m : list) {
			row = sheet.createRow(rowNum++);

			cell = row.createCell(0);
			cell.setCellStyle(dateStyle);
			cell.setCellValue(m.getMeal_date());

			cell = row.createCell(1);
			cell.setCellStyle(commonStyle);
			cell.setCellValue(m.getMenu1());
			cell = row.createCell(2);
			cell.setCellStyle(commonStyle);
			cell.setCellValue(m.getMenu2());
			cell = row.createCell(3);
			cell.setCellStyle(commonStyle);
			cell.setCellValue(m.getMenu3());
			cell = row.createCell(4);
			cell.setCellStyle(commonStyle);
			cell.setCellValue(m.getMenu4());
			cell = row.createCell(5);
			cell.setCellStyle(commonStyle);
			cell.setCellValue(m.getMenu5());
			cell = row.createCell(6);
			cell.setCellStyle(commonStyle);
			cell.setCellValue(m.getMenu6());
		}

		sheet.setColumnWidth(0, 4000);
		for (int i=1;i<7;i++) {
			sheet.autoSizeColumn(i);
			sheet.setColumnWidth(i, (sheet.getColumnWidth(i)) + (short)1024); 
			//이건 자동으로 조절 하면 너무 딱딱해 보여서 자동조정한 사이즈에 (short)512를 추가해 주니 한결 보기 나아졌다.
		}

		// 컨텐츠 타입과 파일명 지정
		response.reset();
		response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(month + "월 " + dto.getSchool() + " 식단표", "UTF-8") + ".xlsx");
		response.setContentType("ms-vnd/excel");

		File filesPath = new File(realPath);
		if(!filesPath.exists()) {
			filesPath.mkdir();
		}

		File file = new File(realPath+"/", month+"월+"+dto.getSchool()+"+식단표.xlsx");

		FileOutputStream fileOutput = new FileOutputStream(file);

		// Excel File Output
		wb.write(fileOutput);
		wb.close();
	}	
}
