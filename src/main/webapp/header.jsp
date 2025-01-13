<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id = "maindao" class = "com.manage.wishJam.mainDAO"></jsp:useBean>
<jsp:useBean id = "ctdao" class ="com.manage.wishJam.M_CartegoryDAO"/>
<%@ page import ="com.manage.wishJam.M_CategoryDTO"%>
<%@ page import ="java.util.*" %>
<link rel="stylesheet" href="/wishJam/css/headfoot.css" />
<link rel="stylesheet" href="/wishJam/css/burger.css" />
<link rel="stylesheet" href="/wishJam/css/allFonts.css" />
<%
	String m_nick = (String)session.getAttribute("m_nick");
	Integer m_idxObj = (Integer) session.getAttribute("m_idx");
	int m_idx = (m_idxObj != null) ? m_idxObj : 0;
	String src = maindao.getImgsrc(m_idx) != null ? maindao.getImgsrc(m_idx) : "";
%>
<script>
function navView() {
    var burger = document.querySelector('#burger');
    var leftNav = document.querySelector('.leftNav');
    
    if (burger.checked) {
        leftNav.style.transform = 'translateX(10%)';
    } else {
        leftNav.style.transform = 'translateX(-240%)';
    }
}
function showExtend(i){
    var element = document.querySelector('#smallToBig' + i);
    if (element.style.display === 'none' || element.style.display === '') {
        element.style.display = 'block';
    } else {
        element.style.display = 'none';
    }
}

function showfuncBox(){
	var element = document.querySelector('.funcBox');
	if (element.style.display === 'none' || element.style.display === '') {
        element.style.display = 'block';
    } else {
        element.style.display = 'none';
    }
}
</script>
<header>
    <label class="burger" for="burger">
        <input type="checkbox" id="burger" onchange="navView();">
        <span></span>
        <span></span>
        <span></span>
    </label>
    <div class="top menu">
        <div class="leftNav">
        	<div class="info"><label>카테고리</label></div>
	        <%
				ArrayList<M_CategoryDTO> categoryarr = ctdao.getBigCategory();
				if (categoryarr != null) {
				for (int i = 0; i < categoryarr.size(); i++) {
					int big = categoryarr.get(i).getC_big();
				%>
		            <div class="leftNavBig" onclick="showExtend('<%=big%>');"><img class = "bigCategoryImg" src="<%=categoryarr.get(i).getC_img() %>" alt="categoryBig"/></div>
		            <div class="infoBig"><label><%= categoryarr.get(i).getC_name() %></label></div>

        			<div id = "smallToBig<%=big %>" class="leftNavExtend">
        				<div class="info"><label><%=categoryarr.get(i).getC_name() %></label></div>
        			<%
        			ArrayList<M_CategoryDTO> categoryarr2 = ctdao.getSmallCategory(big);
					if (categoryarr2 != null) {
						for (int j = 0; j < categoryarr2.size(); j++) {
		        	%>
						<div id = "leftNavSmall<%=j %>" class="leftNavSmall" onclick="window.location.href = '/wishJam/allgoods/allGoods.jsp?c_idx=<%=categoryarr2.get(j).getC_idx()%>'"><img class = "smallCategoryImg" src="<%=categoryarr2.get(j).getC_img() %>" alt="categorySmall"/></div>
						<div class="infoBig"><label><%=categoryarr2.get(j).getC_name() %></label></div>
	        			<%
						}
					}
					%></div><%
				}
			}
        %>
    	</div>
    </div>
    <a href="/wishJam/index.jsp">
    <img src="/wishJam/img/logo.png" alt="mainLogo" class="logo">
	</a>
    <div class="top center">
        <form action="/wishJam/allgoods/searchResult.jsp">
            <input type="text" id="top_Search" name = "search" class="search-bar"/> 
            <input type="submit" value="검색" class="search-btn"/>
        </form>
    </div>
    <% if(m_nick==null){ %>
    <div class="top right notlogin">
        <a href="/wishJam/login/login.jsp">로그인</a> | 
        <a href="/wishJam/login/member.jsp">회원 가입</a>
    </div>
    <% } else { %>
    <div class="top right login" id = "loginBox" onclick="showfuncBox();">
        <img src="<%=src %>" alt="profile" class="profile-icon"/>
        <label><%=m_nick %>님</label>
        <div class="funcBox">
            <ul>
                <div class = "dd"><li><a href="/wishJam/mypage/myPage.jsp">마이페이지</a></li></div>
                <div class = "dd"><li><a href="/wishJam/goodsDetail/makeSell.jsp">판매글 작성</a></li></div>
                <div class = "dd"><li><a href="/wishJam/cart/cart.jsp">장바구니</a></li></div>
                <div class = "dd"><li><a href="/wishJam/login/logout.jsp">로그아웃</a></li></div>
            </ul>
        </div>
    </div>
    <% } %>
</header>
</html>