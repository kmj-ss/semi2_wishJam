package com.manage.wishJam;

import java.sql.*;
import java.util.*;
import com.member.wishJam.MemberDTO;
public class MemberExDAO {
	Connection con;
	PreparedStatement ps;
	ResultSet rs;
	public MemberExDAO() {
		// TODO Auto-generated constructor stub
	}
	public int getTotalcnt() {
		try {
			con = com.db.wishJam.DbConn.getConn();
			String sql = "select count(*) from member";
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			rs.next();
			int cnt = rs.getInt(1);			
			return cnt==0?1:cnt;
		}catch(Exception e) {
			e.printStackTrace();
			return 1;
		}finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (con != null)
					con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
//	public ArrayList<MemberExDTO> allMem(){
//		try {
//			con = com.db.wishJam.DbConn.getConn();
//			String sql = "select * from member";
//			ps = con.prepareStatement(sql);
//			rs = ps.executeQuery();
//			ArrayList<MemberExDTO> arr = new ArrayList<MemberExDTO>();
//			if(rs.next()) {
//				do {
//					MemberExDTO n = new MemberExDTO(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5),rs.getString(6),rs.getString(7),rs.getString(8),rs.getString(9),rs.getString(10));
//					arr.add(n);
//				}while(rs.next());
//			}
//			return arr;
//			
//		}catch(Exception e){
//			e.printStackTrace();
//			return null;
//		}finally {
//			try {
//				if (rs != null)
//					rs.close();
//				if (ps != null)
//					ps.close();
//				if (con != null)
//					con.close();
//			}catch(Exception e) {
//				e.printStackTrace();
//			}
//		}
//	}
	
	public ArrayList<MemberDTO> allMember(int cp, int ls) {
		try {
			con = com.db.wishJam.DbConn.getConn();
			int start = (cp - 1) * ls + 1;
			int end = cp * ls;
			String sql = "select * from "
					+ "(select rownum as rnm,a.* from  "
					+ "(select * from member order by m_idx asc) a)b "
					+ "where rnm >=? and rnm <= ?";
			
			ps = con.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, end);
			rs = ps.executeQuery();
			
			ArrayList<MemberDTO> arr = new ArrayList<MemberDTO>();
			while(rs.next()) {
				MemberDTO dto = new MemberDTO(rs.getInt(2),rs.getString(3),rs.getInt(4),rs.getString(5),rs.getString(6),rs.getString(7),rs.getString(8),rs.getString(9),rs.getString(10),rs.getString(11),rs.getString(12),rs.getInt(13));
				arr.add(dto);
			}
			return arr;
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (con != null)
					con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	public String getGname(int g_idx) {
		try {
			con = com.db.wishJam.DbConn.getConn();
			String sql = "select g_name from grade where g_idx = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, g_idx);
			rs = ps.executeQuery();
			rs.next();
			String gname = rs.getString(1);			
			return gname==null?"등급없음":gname;
		}catch(Exception e) {
			e.printStackTrace();
			return "등급없음";
		}finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (con != null)
					con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}
