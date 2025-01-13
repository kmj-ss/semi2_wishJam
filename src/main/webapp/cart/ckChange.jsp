<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper, com.fasterxml.jackson.core.type.TypeReference" %>
<%@ page import="java.util.*"%>
<%@ page import="java.util.stream.*"%>
<jsp:useBean id="cdao" class="com.cart.wishJam.CartDAO"></jsp:useBean>
<%
	request.setCharacterEncoding("UTF-8");
	String json = request.getReader().lines().collect(Collectors.joining());
	ObjectMapper mapper = new ObjectMapper();
	
	Map<String, List<Integer>> data = mapper.readValue(json, new TypeReference<Map<String, List<Integer>>>() {});
    List<Integer> idsList = data.get("ctidx");
    List<Integer> ckinviList = data.get("ctckbox");
	
    List<Map<String, Object>> result = new ArrayList<>();
 	
	if (idsList != null && ckinviList != null) {
        for (int i = 0; i < idsList.size(); i++) {
            int ct_idx = idsList.get(i);
            int ct_ckchange = ckinviList.get(i);

            cdao.costchange(ct_idx, ct_ckchange);
            
            Map<String, Object> entry = new HashMap<>();
            entry.put("ct_idx", ct_idx);
            entry.put("ct_ckchange", ct_ckchange);
            result.add(entry);
        }
	}
	
    ObjectMapper responseMapper = new ObjectMapper();
    response.setContentType("application/json; charset=UTF-8");
    response.getWriter().write(responseMapper.writeValueAsString(result));
%>