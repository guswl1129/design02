package com.handiboard.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.handiboard.dto.BoardDTO;
import com.handiboard.dto.OrderDTO;
import com.handiboard.util.DBConnection;

public class MyOrderDAO {
	public List<OrderDTO> loadOrder(String id) {
		List<OrderDTO> list = new ArrayList<OrderDTO>();
		String sql = "SELECT i.item_name, i.item_price, i.img_path, o.order_date, o.order_no " +
                "FROM item i " +
                "JOIN Orders o ON i.item_no = o.item_no " +
                "WHERE o.buyer_id = ?";
		try(Connection conn = DBConnection.getInstance().getConn();
				PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1,id);
			try (ResultSet rs = pstmt.executeQuery()) {
	            while (rs.next()) {
	            	OrderDTO dto = new OrderDTO();
	                dto.setItem_name(rs.getString("item_name"));
	                dto.setItem_price(rs.getInt("item_price"));
	                dto.setImg_path(rs.getString("img_path"));
	                dto.setOrder_date(rs.getString("order_date"));
	                dto.setOrder_no(rs.getInt("order_no"));
	                list.add(dto);
	            }
	        }
			
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		
		return list;
	}
}
