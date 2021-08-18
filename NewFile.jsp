<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
    
    <%@ page import= "java.sql.*"%>
    <%@ page import="java.util.*" %>
    <%@ page import="com.google.gson.Gson"%>
    <%@ page import="com.google.gson.JsonObject"%>

<% 
Gson gsonObj = new Gson();
Map<Object,Object> map = null;
List<Map<Object,Object>> list = new ArrayList<Map<Object,Object>>();



    String url="jdbc:mysql://localhost:3306/sales";
    String username="root";
    String password="mili";
    String sql="SELECT *FROM cakessold";
    Class.forName("com.mysql.jdbc.Driver");
   Connection con=DriverManager.getConnection(url,username,password);
   Statement st=con.createStatement();  
   ResultSet rs=st.executeQuery(sql);
   while (rs.next())
   {
	   String days=rs.getString(2);	  
	   Float sales=rs.getFloat(3);
	   map = new HashMap<Object,Object>(); map.put("label", days); map.put("y", sales); list.add(map);
   }
   

   String dataPoints = gsonObj.toJson(list);

%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
window.onload = function() { 
 
var chart = new CanvasJS.Chart("chartContainer", {
	theme: "light2",
	title: {
		text: "Sales Performance"
	},
	subtitles: [{
		text: "days"
	}],
	axisY:{
		title: "Sales in Volumn",
		suffix: "%"
	},
	data: [{
		type: "spline",
		toolTipContent: "<b>{label}</b>: {y}%",
		dataPoints: <%out.print(dataPoints);%>
	}]
});
chart.render();
 
}
</script>
</head>
<body>
<div id="chartContainer" style="height: 250px; width: 300px;"></div>
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
</body>
</html>                