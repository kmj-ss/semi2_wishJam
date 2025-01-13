<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="pdao" class="com.pay.wishJam.PayDAO"></jsp:useBean>
<%
	String sidx = "1";
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/wishJam/css/allFonts.css" />
<meta charset="UTF-8">
<title>위시잼 - 현장결제</title>
<style>
	body {
		    background-color: #fdf5e6;
			display: flex;
		    justify-content: center;
		    align-items: center;
		    min-height: 90vh;
		    margin: 0;
		}	
	
	fieldset {
            border: 2px solid #faf9f6;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            box-sizing: border-box;
            margin: auto;
        }
   
   legend {
            font-size: 1.2em;
            font-weight: bold;
            padding: 0 10px;
            color: #ff4500;
            font-family: 'Cafe24Ohsquareair';
        }	
             
	.button-container {
            text-align: right;
            padding-top: 20px;
            padding-right: 20px;
            padding-bottom: 13px;
        }
        
	input[type="submit"] {
            background: #ff6f40;
            border: none;
            color: #fff;
            padding: 10px 20px;
            font-size: 1em;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
            font-family: 'Pretendard-Regular';
        }
        
    input[type="submit"]:hover {
            background-color: #e03a00;
        }
    
    .select_all{
    	padding: 30px 30px 40px 30px;
    	background-color: #faf9f6;
    	border-radius: 10px;
    }
    
    .select_place {
    	display: flex;
    	font-size: 1.2em;
    	justify-content: space-between; 
    }
    
    .select_time {
    	display: flex;
    	font-size: 1.2em;
    	padding-top: 15px;
    }
</style>
</head>
<body>
	<%
		String[] offlist = pdao.offline(sidx);
	%>
	<fieldset>
		<legend>현장 정보</legend>
	<div>
	<div class="select_all">
	<div class="select_place">
		<div style="font-family: 'Cafe24Ohsquareair';">장소</div>
		<div style="font-family: 'Pretendard-Regular';"><%=offlist[0] %></div>
	</div>
	<div class="select_time">
		<div style="padding-right: 60px; font-family: 'Cafe24Ohsquareair';">시간</div>
		<select style="width: 100px; height: 35px; font-family: 'Pretendard-Regular'; border: 2px solid #ccc;">
			<%!	
				String formatTime (String timeStr) {
		            if (timeStr.length() == 4) { 
		                return timeStr.substring(0, 2) + ":" + timeStr.substring(2);
		            } else if (timeStr.length() == 3) { 
		                return timeStr.substring(0, 1) + ":" + timeStr.substring(1);
		            } else if (timeStr.length() == 2) { 
		                return "0:" + timeStr;
		            } else if (timeStr.length() == 1) { 
		                return "00:" + timeStr;
		            }
		            return timeStr; 
		        }
			%>
			<%			
				int hour1 = 0;
				int hour2 = 0;
				int i = 200;
				
				if(offlist[1].equals("오전")){
					hour1 = Integer.parseInt(offlist[2]);	
				} else if(offlist[1].equals("오후")) {
					hour1 = Integer.parseInt(offlist[2])+1200;
				}
				
				if(offlist[3].equals("오전")){
					hour2 = Integer.parseInt(offlist[4]);
				} else if(offlist[3].equals("오후")) {
					hour2 = Integer.parseInt(offlist[4])+1200;
				}
				
				while(hour1 <= hour2){
			%>
				<option value="<%=hour1%>"><%=formatTime(Integer.toString(hour1)) %></option>
			<%
					 if(hour1 >= 0 && hour1 <= 2400 && hour1 <= hour2){
						 hour1 += i;
					 } else {
						out.print("유효하지 않은 시간 범위입니다.");
					 }
				}
			%>
		</select>
	</div>
	</div>
	<div class="button-container">
	   <input type="submit" value="거래신청">
	</div>
	</div>
	</fieldset>
</body>
</html>