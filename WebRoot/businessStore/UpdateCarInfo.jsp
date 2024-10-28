<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.cuc.dao.IBrandDAO"%>
<%@page import="com.cuc.dao.imp.BrandDAO"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	Map<String, Object> car = (Map<String, Object>) request
			.getAttribute("carInfo");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>门店车辆信息修改</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<style>
body {
	background: #ffffff;
	color: #444;
	font-size: 12px;
}

a {
	color: #07c;
	text-decoration: none;
	border: 0;
	background-color: transparent;
}

body,div,q,iframe,form,h5 {
	margin: 0;
	padding: 0;
}

img,fieldset {
	border: none 0;
}

body,td,textarea {
	word-break: break-all;
	word-wrap: break-word;
	line-height: 1.6;
}

body,input,textarea,select,button {
	margin: 0;
	font-size: 14px;
	font-family: Tahoma, SimSun, sans-serif;
}

div,p,table,th,td {
	font-size: 1em;
	font-family: inherit;
	line-height: inherit;
}

h5 {
	font-size: 12px;
}

ol li,ul li {
	margin-bottom: 0.5em;
}

pre,code {
	font-family: "Courier New", Courier, monospace;
	word-wrap: break-word;
	line-height: 1.4;
	font-size: 12px;
}

pre {
	background: #f6f6f6;
	border: #eee solid 1px;
	margin: 1em 0.5em;
	padding: 0.5em 1em;
}

#content {
	padding-left: 50px;
	padding-right: 50px;
}

#content h2 {
	font-size: 20px;
	color: #069;
	padding-top: 8px;
	margin-bottom: 8px;
}

#content h3 {
	margin: 8px 0;
	font-size: 14px;
	COLOR: #693;
}

#content h4 {
	margin: 8px 0;
	font-size: 16px;
	COLOR: #690;
}

#content div.item {
	margin-top: 10px;
	margin-bottom: 10px;
	border: #eee solid 4px;
	padding: 10px;
}

hr {
	clear: both;
	margin: 7px 0; +
	margin: 0;
	border: 0 none;
	font-size: 1px;
	line-height: 1px;
	color: #069;
	background-color: #069;
	height: 1px;
}

.infobar {
	background: #fff9e3;
	border: 1px solid #fadc80;
	color: #743e04;
}

.buttonStyle {
	width: 64px;
	height: 22px;
	line-height: 22px;
	color: #369;
	text-align: center;
	background: url(images/buticon.gif) no-repeat left top;
	border: 0;
	font-size: 12px;
}

.buttonStyle:hover {
	background: url(images/buticon.gif) no-repeat left -23px;
}
</style>
		<link rel="stylesheet"
			href="<%=basePath%>businessStore/css/common.css">
		<link rel="stylesheet" href="<%=basePath%>businessStore/css/main.css">
		<script src="<%=basePath%>/member/laydate/laydate.js"></script>
		<script type="text/javascript"
			src="<%=basePath%>businessStore/js/jquery.min.js"></script>

		<script type="text/javascript">
	function getTypeByBrand(brand) {
		var url ="<%=basePath%>servlet/BrandServlet?method=getTypeByBrand";
		$.post(url, {
			"brand" :brand
		}, function(data) {
			var aa = JSON.parse(data)
			
			var str="<select>"; 
      		var data = data.split(",");
      		for(var i=0;i<data.length;i++) 
		    {   
		    	var type = data[i].split('\"');      
		    	str=str+"<option name=\""+type[1]+"\">"+type[1]+"</option>";     
		    } 
      		str=str+"</select>"; 
      		document.getElementById("carType").innerHTML=str; 
		});
	}
	
	
	function alarm(){
	alert("只允许上传jpg,gif,bmp类型的文件");
	}
	function checkExt(){
		var allowArray = new Array("jpg","gif","bmp");
		var simg = document.getElementById("simg").value;
		if(simg==""){
			return true;		
		}else{
		
			var fileExt = simg.substr(simg.lastIndexOf(".")+1);
			var flag = false;
			for(var i = 0;i<allowArray.length;i++){
				if (allowArray[i] == fileExt.toLowerCase()){
					flag = true;
					break;
				}
			}
			if (flag == false){
				alert("不允许上传的文件类型，只允许上传jpg,gif,bmp类型的文件");
			}
			return flag;
		}
	}
	
</script>
	</head>

	<body>

		<div class="container">

			<div id="forms" class="mt10">
				<div class="box">
					<form
						action="<%=basePath %>servlet/CarServlet?method=updateCarInfo"
						method="post" enctype="multipart/form-data"
						onSubmit="return checkExt();">
						<div class="box_border">
							<div class="box_top">
								<b class="pl15">修改车辆信息</b>
								<input style="float: right;" type="submit" name="button"
									class="btn btn82 btn_add" value="修改">
							</div>
							<center>
								<input type="hidden" name="storeId"
									value="<%=car.get("storeId").toString() %>">
								<input type="hidden" name="carId"
									value="<%=car.get("carId").toString() %>">
								<input type="hidden" name="oldCarImg"
									value="<%=car.get("carImage").toString() %>">
								<table width="944" border="0"
									style="margin-bottom: 50px; margin-top: 40px;">
									<tr>
										<td colspan="2" rowspan="5">
											<img name="img"
												src="<%=basePath %>uploadFiles/car/<%=car.get("carImage") %>"
												style="width: 270px; height: 170px;">
											<input type="file" name="simg" id="simg"
												class="input-text lh30" size="10">
										</td>
										<td width="88" height="35" align="right">
											<strong>牌号</strong>
										</td>
										<td width="250">
											<input type="text" name="carNumber" class="input-text lh30"
												size="36" value="<%=car.get("carNumber")%>"
												style="padding-left: 8px;">
										</td>
										<td width="72" align="right">
											<strong>排挡</strong>
										</td>
										<td width="221">
											<span class="fl">
												<div class="select_border">
													<div class="select_containers ">
														<select name="carGear" class="select"
															style="width: 250px;">
															<%
															String carGear = car.get("carGear").toString();
															if (carGear.equals("自动")) {
														%>
															<option value="自动" selected="selected">
																自动
															</option>
															<option value="手动">
																手动
															</option>
															<%
															} else {
														%>
															<option value="自动">
																自动
															</option>
															<option value="手动" selected="selected">
																手动
															</option>
															<%
															}
														%>
														</select>
													</div>
												</div> </span>
										</td>
									</tr>
									<tr>
										<td height="37" align="right">
											<strong>品牌</strong>
										</td>
										<td height="37">
											<span class="fl">
												<div class="select_border">
													<div class="select_containers ">
														<select name="carBrand" class="select"
															style="width: 250px;"
															onchange="getTypeByBrand(this.value)">
															<%
															IBrandDAO brandDAO = new BrandDAO();
															ArrayList<String[]> brandList = brandDAO.getAllBrand();
															for(String[] brand : brandList){
																if(brand[0].equals(car.get("carBrand").toString())){
															 %>

															<option value=<%=brand[0] %> selected="selected">
																<%=brand[0] %>
															</option>

															<%}else{%>
															<option value=<%=brand[0] %>>
																<%=brand[0] %>
															</option>

															<%} }%>
														</select>
													</div>
												</div> </span>
										</td>
										<td align="right">
											<strong>排量</strong>
										</td>
										<td>
											<span class="fl">
												<div class="select_border">
													<input type="text" name="carDisplacement"
														class="input-text lh30" size="24"
														value="<%=car.get("carDisplacement").toString().substring(0, 3)%>">
													<div class="select_containers ">
														<select name="carDisplacementUnits" class="select"
															style="width: 70px;">
															<%
															String units = car.get("carDisplacement").toString()
																	.substring(3, 4);
															if (units.equals("L")) {
														%>
															<option value="L" selected="selected">
																L
															</option>
															<option value="T">
																T
															</option>
															<%
															} else if (units.equals("T")) {
														%>
															<option value="L">
																L
															</option>
															<option value="T" selected="selected">
																T
															</option>
															<%
															}
														%>
														</select>
													</div>
												</div> </span>
										</td>
									</tr>
									<tr>
										<td height="42" align="right">
											<strong>型号</strong>
										</td>
										<td height="42">
											<span class="fl">
												<div class="select_border">
													<div class="select_containers ">
														<select id="carType" name="carType" class="select"
															style="width: 250px;">
															<option value="0" selected="selected">
																--请选择车辆型号--
															</option>
														</select>
													</div>
												</div> </span>
										</td>
										<td align="right">
											<strong>座位</strong>
										</td>
										<td>
											<span class="fl">
												<div class="select_border">
													<div class="select_containers ">
														<select name="seat" id="seat" class="select"
															style="width: 250px;">
															<%
															if (car.get("seat").equals("2")) {
														%>
															<option value="2" selected="selected">
																2座
															</option>
															<option value="5">
																5座
															</option>
															<option value="7">
																7座
															</option>
															<option value="8">
																8座
															</option>
															<%
															} else if (car.get("seat").equals("5")) {
														%>
															<option value="2">
																2座
															</option>
															<option value="5" selected="selected">
																5座
															</option>
															<option value="7">
																7座
															</option>
															<option value="8">
																8座
															</option>
															<%
															} else if (car.get("seat").equals("7")) {
														%>
															<option value="2">
																2座
															</option>
															<option value="5">
																5座
															</option>
															<option value="7" selected="selected">
																7座
															</option>
															<option value="8">
																8座
															</option>
															<%
															} else if (car.get("seat").equals("8")) {
														%>
															<option value="2">
																2座
															</option>
															<option value="5">
																5座
															</option>
															<option value="7">
																7座
															</option>
															<option value="8" selected="selected">
																8座
															</option>
															<%
															}
														%>
														</select>

													</div>
												</div> </span>
										</td>
									</tr>
									<tr>
										<td height="40" align="right">
											<strong>类别</strong>
										</td>
										<td height="40">
											<span class="fl">
												<div class="select_border">
													<div class="select_containers ">
														<select name="carForm" class="select"
															style="width: 250px;">
															<%
															String carForm1 = car.get("carForm").toString();
															if (carForm1.equals("经济型")) {
														%>
															<option value="经济型" selected="selected">
																经济型
															</option>
															<option value="舒适型">
																舒适型
															</option>
															<option value="SUV">
																SUV
															</option>
															<option value="电动型">
																电动型
															</option>
															<%
															} else if (carForm1.equals("舒适型")) {
														%>
															<option value="经济型">
																经济型
															</option>
															<option value="舒适型" selected="selected">
																舒适型
															</option>
															<option value="SUV">
																SUV
															</option>
															<option value="电动型">
																电动型
															</option>
															<%
															} else if (carForm1.equals("SUV")) {
														%>
															<option value="经济型">
																经济型
															</option>
															<option value="舒适型">
																舒适型
															</option>
															<option value="SUV" selected="selected">
																SUV
															</option>
															<option value="电动型">
																电动型
															</option>
															<%
															} else if (carForm1.equals("电动型")) {
														%>
															<option value="经济型">
																经济型
															</option>
															<option value="舒适型">
																舒适型
															</option>
															<option value="SUV">
																SUV
															</option>
															<option value="电动型" selected="selected">
																电动型
															</option>
															<%
															}
														%>
														</select>
													</div>
												</div> </span>
										</td>
										<td align="right">
											<strong>厢数</strong>
										</td>
										<td>
											<span class="fl">
												<div class="select_border">
													<div class="select_containers ">
														<select name="compartment" id="compartment" class="select"
															style="width: 250px;">
															<option id="compartmentop1" value="两厢">
																两厢
															</option>
															<option id="compartmentop2" value="三厢">
																三厢
															</option>
															<option id="compartmentop3" value="SUV">
																SUV
															</option>
														</select>
													</div>
												</div> </span>
										</td>
									</tr>
									<tr>
										<td height="40" align="right">
											<strong>发动机号</strong>
										</td>
										<td height="40">
											<input type="text" name="engineNum" class="input-text lh30"
												size="36" value="<%=car.get("engineNum")%>"
												style="padding-left: 8px;">
										</td>
										<td align="right">
											<strong>购入日期</strong>
										</td>
										<td>
											<input name="buyDate" style="width: 250px; height: 30px"
												value="<%=car.get("carBufyData")%>" id="buyDate"
												class="laydate-icon" onclick="laydate()">
										</td>
									</tr>
									<tr>
										<td width="49" height="46" align="left">
											<strong>租金</strong>
										</td>
										<td width="220">
											<input type="text" name="carMoney" class="input-text lh30"
												size="32" value="<%=car.get("carMoney")%>"
												style="padding-left: 8px;">
										</td>
										<td align="right">
											<strong>车架号</strong>
										</td>
										<td>
											<input type="text" name="carframeNum" class="input-text lh30"
												size="36" value="<%=car.get("carframeNum")%>"
												style="padding-left: 8px;">
										</td>
										<td align="right">
											<strong>车辆状态</strong>
										</td>
										<td>
											<span class="fl">
												<div class="select_border">
													<div class="select_containers ">
														<select name="state" id="state" class="select"
															style="width: 250px;">
															<%
																String state = car.get("state").toString();
																if("1".equals(state)){
															%>

															<option id="close" value="0">
																停用
															</option>
															<option id="open" value="1" selected="selected">
																启用
															</option>
															<%}else{ %>
															<option id="close" value="0" selected="selected">
																停用
															</option>
															<option id="open" value="1">
																启用
															</option>

															<%} %>
														</select>
													</div>
												</div> </span>
										</td>
									</tr>
								</table>

								
								
							</center>
						</div>
					</form>
				</div>
			</div>
		</div>

		<script type="text/javascript">
		var compartment = "<%=car.get("compartment")%>";

		if (compartment == "两厢") {
			$("#compartmentop1").attr("selected", "selected");
		} else if (compartment == "三厢") {
			$("#compartmentop2").attr("selected", "selected");
		} else if (compartment == "SUV") {
			$("#compartmentop3").attr("selected", "selected");
		}
		
		var state="<%=car.get("state")%>";
	if (state == 1) {
		$("#open").attr("selected", "selected");
	} else if (state == 0) {
		$("#close").attr("selected", "selected");
	}
</script>
	</body>
</html>
