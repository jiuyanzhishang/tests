<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>DataTables Demo</title>
<link rel="stylesheet" href="./DataTables/css/jquery.dataTables.css"></link>
<link rel="stylesheet"
	href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
</head>
<script src="./js/jquery.js"></script>
<script src="./DataTables/js/jquery.dataTables.js"></script>
<script
	src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript">
	var table;
	$(document).ready(function() {
		table = $('#tables').DataTable({
			// 国际化
			language : {
				"sProcessing" : "处理中...",
				"sLengthMenu" : "显示 _MENU_ 项结果",
				"sZeroRecords" : "没有匹配结果",
				"sInfo" : "显示第 _START_ 至 _END_ 项结果，共 _TOTAL_ 项",
				"sInfoEmpty" : "显示第 0 至 0 项结果，共 0 项",
				"sInfoFiltered" : "(由 _MAX_ 项结果过滤)",
				"sInfoPostFix" : "",
				"sSearch" : "搜索:",
				"sUrl" : "",
				"sEmptyTable" : "表中数据为空",
				"sLoadingRecords" : "载入中...",
				"sInfoThousands" : ",",
				"oPaginate" : {
					"sFirst" : "首页",
					"sPrevious" : "上页",
					"sNext" : "下页",
					"sLast" : "末页"
				},
				"oAria" : {
					"sSortAscending" : ": 以升序排列此列",
					"sSortDescending" : ": 以降序排列此列"
				}
			},
			retrieve : true,
			paging : true, //翻页功能
			ordering : false, //表的排序功能
			info : true,
			autoWidth : true,
			colReorder : true, //设置拖动调节列宽
			pageLength : 10, //每页显示10条数据
			pagingType : "full_numbers", //分页样式：simple,simple_numbers,full,full_numbers
			searching : false, //搜索功能控件
			//bFilter: false, //去掉搜索框方法
			bLengthChange : false, //去掉选择页面展示条数选择功能
			serverSide : true, //启用服务器端分页，要进行后端分页必须的环节
			/* 
			data发到服务器上的参数 
			callback回调函数，服务器回传的集合作为参数
			*/
			ajax : function(data, callback, settings) {
				//封装相应的请求参数，这里获取页大小和当前页码
				var pagesize = data.length; //页面显示记录条数，在页面显示每页显示多少项的时候,页大小
				var start = data.start; //开始的记录序号
				var page = (data.start) / data.length + 1; //当前页码
				var data = {
					page : page,
					pagesize : pagesize, //当前页和页大小
				}
				var json = {
					dataArray : JSON.stringify(data)
				}
				$.ajax({
					type : "POST",
					url : "tableServlet",
					data : json, //传入已封装的参数
					dataType : "json", //返回数据格式为json
					success : function(data) {
						var arr = "";
						if ('object' == typeof data) {
							arr = data;
						} else {
							arr = $.parseJSON(data); //将json字符串转化为了一个Object对象
						}
						console.log("============数据==========")
						console.log(arr)
						var returnData = {};

						returnData.recordsTotal = arr.totalCount; //totalCount指的是总记录数
						returnData.recordsFiltered = arr.totalCount; //后台不实现过滤功能,全部的记录数都需输出到前端，记录数为总数
						returnData.data = arr.studentList; //返回学生信息列表
						console.log("======returnData.data=======")
						console.log(returnData.recordsTotal)
						console.log(returnData.recordsFiltered)
						callback(returnData);
					},
					error : function(error) {
						alert(error);
					}
				});
			},

			//添加行内按钮
			"columnDefs" : [ {
				// 定义操作列
				"targets" : 4, //操作按钮目标列，这是一个列定义对象数组（从左到右，从0开始）
				"data" : null,
				"render" : function(data, type, row) { //data读取该column对应字段的数据，row读取一整条记录，
					var id = row.id;

					var html = "<button class='edit-btn' type='button'>编辑</button>";
					html += "<button onclick='deleteThisTableRow(" + id + ")' > 删除</button>";
					return html;
				}
			} ],

			columns : [
				{
					"data" : "name"
				},
				{
					"data" : "className"
				},
				{
					"data" : "school"
				},
				{
					"data" : "job"
				}
			]
		});
		
		$("#tables tbody").on("click", ".edit-btn", function() {
			var tds = $(this).parents("tr").children();
			$.each(tds, function(i, val) {
				var jqob = $(val);
				if (jqob.has('button').length) {
					return true;
				} //跳过第1项 序号,按钮
				var txt = jqob.text();
				var put = $("<input type='text'>");
				put.val(txt);
				jqob.html(put);
			});
			$(this).html("保存");
			$(this).toggleClass("edit-btn");
			$(this).toggleClass("save-btn");
		});

		$("#tables tbody").on("click", ".save-btn", function() {
			var row = table.row($(this).parents("tr"));
			var tds = $(this).parents("tr").children();
			$.each(tds, function(i, val) {
				var jqob = $(val);
				//把input变为字符串
				if (!jqob.has('button').length) {
					var txt = jqob.children("input").val();
					jqob.html(txt);
					table.cell(jqob).data(txt); //修改DataTables对象的数据
				}
			});
			var data = row.data();
			$.ajax({
				"url" : "UpdataServlet",
				"data" : data,
				"type" : "post",
				"error" : function() {
					alert("服务器未正常响应，请重试");
				},
				"success" : function(response) {
					//alert(response);
				}
			});
			$(this).html("编辑");
			$(this).toggleClass("edit-btn");
			$(this).toggleClass("save-btn");
		});
	})
	function deleteThisTableRow(id) {
		alert(id)
		var r = confirm("请确认是否删除");
		if(r==true){
			$.ajax({
				type : "get",
				url : "delServlet",
				data : {
					"id" : id
				},
				success : function() {
					alert("删除成功");
					location.reload();
				},
				error : function() {
					alert("删除失败");
				}
			})
		}else {return;}
		
		
	}

	

	/* function editThisTableRow(id) {
        window.location.href="/zhaoziyuan/EditServlet?id="+id
    } */
</script>
<body>
	<table id="tables" class="table table-striped table-bordered ">
		<thead>
			<tr>
				<td>姓名</td>
				<td>班级</td>
				<td>学校</td>
				<td>职业</td>
				<td style="width: 200px">操作</td>
			</tr>
		</thead>
	</table>
</body>
</html>