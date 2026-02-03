package com.handiboard.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class DBConnection {
	private static DBConnection dbConn = new DBConnection();
	
	
	// 생성자 잠금
	private DBConnection() { 
		
	}
	
	// 위에서 생성한 인스턴스 얻기
	public static DBConnection getInstance() {
		return dbConn;
	}

	// 접속정보 주는 getConn()메소드 
	public Connection getConn() {
		Connection conn = null;
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			String url = "jdbc:mariadb://db.wisejia.com:3306/dswu07";
			String id = "dswu07";
			String passwd = "ck319gh";
			conn = DriverManager.getConnection(url, id, passwd);
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 클래스가 없습니다.");
			e.printStackTrace();
		} catch (SQLException e) {
			System.out.println("접속정보를 다시 확인해주세요.");
			e.printStackTrace();
		}
		return conn;
	}
}
 
