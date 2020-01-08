<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>列表</title>
    <link rel="stylesheet" href="../DataTables/media/css/jquery.dataTables.css"></link>
    <link rel="stylesheet" href="../bootstrap-4.4.1-dist/css/bootstrap.css"></link>
    <style type="text/css">
		tr th {text-align: center;}
		.modal{
		    position:fixed;
		    left:0;
		    right:0;
		    top:0;
		    bottom:0;
		    background: rgba(0,0,0,0.3);
		    z-index:9999;
		}
		.modal_dialog{
		    width:400px;
		    height:200px;
		    margin:100px auto;
		    background: #fff;
		    border-radius: 2px;
		}
		.modal_header{
		    width: 380px;
		    height:42px;
		    line-height: 42px;
		    background: #e8e8e8;
		    border-top-right-radius: 2px;
		    border-top-left-radius: 2px;
		    font-size: 16px;
		    padding-left: 20px;
		}
		.modal_information{
		    width:254px;
		    margin:0 auto;
		    margin-top:21px;
		    font-size: 16px;
		}
		.modal_information>span{
		    position: relative;
		    top:-20px;
		}
		.yes,.no{
		    display: inline-block;
		    width:124px;
		    height:42px;
		    line-height: 42px;
		    border-radius: 2px;
		    font-size: 16px;
		    background: #ccc;
		    margin-top:17px;
		    cursor: pointer;
		    color: #fff;
		    border-radius: 10px;
		}
		.yes>span{
		    margin-left: 45px;
		}
		.no>span{
		    margin-left: 38px;
		}
		.yes{
		    margin-left:52px;
		    margin-right: 48px;
		    background: #0aa1ed;
		}
		
</style>
</head>
<script type="text/javascript" src="../DataTables/media/js/jquery.js"></script> 
<script type="text/javascript" src="../bootstrap-4.4.1-dist/js/bootstrap.js"></script> 
<script type="text/javascript" src="../DataTables/media/js/jquery.dataTables.js"></script>  
<script type="text/javascript" src="../DataTables/media/js/colResizable-1.5.min.js"></script>  
<script type="text/javascript">
    $(document).ready(function() {
       var table=$("#table_id_example").DataTable({
            retrieve: true,
            paging: true,
            ordering: false,
            info: true,
            autoWidth: false,
            scrollX: true,
            pageLength: 10,//每页显示10条数据
            pagingType: "full_numbers", //分页样式：simple,simple_numbers,full,full_numbers，
            bFilter: false, //去掉搜索框方法
            bLengthChange: false,//也就是页面上确认是否可以进行选择一页展示多少条
            serverSide: true, //启用服务器端分页，要进行后端分页必须的环节
            ajax: function (data, callback, settings) {
                //封装相应的请求参数，这里获取页大小和当前页码
                console.log(data);
                var pagesize = data.length;//页面显示记录条数，在页面显示每页显示多少项的时候,页大小
                var start = data.start;//开始的记录序号
                var page = (data.start) / data.length + 1;//当前页码
                $.ajax({
                    type: "post",
                    url: "../user/showData.do",
                    data: "page="+page+"&pagesize="+pagesize,   
                    dataType: "json",
                    success: function(data) {
                        var arr = "";
                        console.log(data);
                         if ('object' == typeof data) {
                            arr = data;
                        } else {
                            arr = $.parseJSON(data);		//将json字符串转化为了一个Object对象
                        } 
                        var returnData = {};
                        console.log("count="+data.totalCount);
                        returnData.recordsTotal = data.totalCount;		//totalCount指的是总记录数
                        returnData.recordsFiltered = data.totalCount;	//后台不实现过滤功能,全部的记录数都需输出到前端，记录数为总数
                        returnData.data = arr.data;
                        callback(returnData);
                    },
                    error: function(XMLHttpRequest, textStatus, errorThrown) {
                        alert("查询失败");
                       /*  $wrapper.spinModal(false); */
                    }
                });
            },
            columns: [
                {"data": "name", "width": "120px"},
                {"data": "age", "width": "120px"},
                {"data": "address", "width": "120px"},
                {"data": "sex", "width": "120px"},
                {"data": "operate", "width": "120px"}
            ],
            
            language: {
                "processing":   "处理中...",
                "lengthMenu":   "_MENU_ 记录/页",
                "zeroRecords":  "没有匹配的记录",
                "info":         "第 _START_ 至 _END_ 项记录，共 _TOTAL_ 项",
                "infoEmpty":    "第 0 至 0 项记录，共 0 项",
                "infoFiltered": "(由 _MAX_ 项记录过滤)",
                "infoPostFix":  "",
                "search":       "搜索:",
                "url":          "",
                "decimal": ",",
                "thousands": ".",
                "emptyTable":"未找到符合条件的数据",
                "paginate": {
                    "first":    "首页",
                    "previous": "上页",
                    "next":     "下页",
                    "last":     "末页"
                }
            },
          //添加行内按钮
     	   "columnDefs" : [{
     	    "targets" : -1, //操作按钮目标列
     	    "data" : null,
     	    "render" : function(data, type, row) {
     	     var id = row.id;
     	     var html = 
 				"<button type='button' class='edit-btn' id='edit-btn'>编辑</button>";
     	     html += "<button type='button' onclick='deleteThisTableRow("+id+")' class='del'> 删除</button>";
     	     return html;
     	    }
     	   }]
        })
    
    //点击编辑按钮
	$("#table_id_example tbody").on("click",".edit-btn",function(){
           var tds=$(this).parents("tr").children();
           console.log(tds);
           $.each(tds, function(i,val){
               var jqob=$(val);
               //console.log(jqob);
               if(i > 4 || jqob.has('button').length ){return true;}
               //txt 是点击当前行的值
               var txt=jqob.text();
               console.log(txt);
               var put=$("<input type='text'>");
               put.val(txt);
               jqob.html(put);
           });
           $(this).html("保存");
           $(this).toggleClass("edit-btn");
           $(this).toggleClass("save-btn");
           $(this).next().html("取消");
           $(this).next().toggleClass("del");
           $(this).next().toggleClass("cancle-btn"); 
       });
    //点击保存事件
   	$("#table_id_example tbody").on("click",".save-btn",function(){
	  	 var row = table.row($(this).parents("tr"));
	  	 var tds = $(this).parents("tr").children();
	  	 $.each(tds,function(i,val){
	  		var jqob = $(val);
	  		 if(!jqob.has('button').length){
	  			 var txt =jqob.children("input").val();
	  			 jqob.html(txt);
	  			 table.cell(jqob).data(txt);
	  		 }
	  	 });
	  	 var data = row.data();
	  	 console.log(data);
	  	 $.ajax({
	  		"url":"../user/update.do",
	  		"data" : data,
			"type" : "post",
			"success" : function() {
				alert('修改成功!');
			},
			"error" : function() {
				alert("服务器未正常响应，请重试！");
			}
	  	 });
	  	 $(this).html("编辑");
	  	 $(this).toggleClass("edit-btn");
	  	 $(this).toggleClass("save-btn");
	  	 $(this).next().html("删除");
	  	 $(this).next().toggleClass("cancle-btn");
         $(this).next().toggleClass("del"); 
 	  });
    	
    	//点击取消事件
	    $("#table_id_example tbody").on("click",".cancle-btn",function(){
			window.location='../user/show.do';//location.reload();
		});
    });
    
      function deleteThisTableRow(id){
			console.log(id);
			$('.modal').fadeIn();
			$('.no').click(function(){
				$('.modal').fadeOut();
			});
			$('.yes').click(function(){
				alert(id);
				var url ="../user/removeById.do?id="+id;
				 window.location.href=url;
		})
	};
</script>
<body>
<div class="modal" style="display:none">
    <div class="modal_dialog">
        <div class="modal_header">
          		 删除提示
        </div>
        <div class="modal_information">
            <span>确定删除该信息吗？</span>
        </div>
        <div class="yes"><span>删除</span></div>
        <div class="no"><span>不删除</span></div>
    </div>
</div>


<table id="table_id_example" class="table-striped no-footer dataTable" style="white-space: nowrap; " border="1">
    <thead>
    <tr>
        <th>姓名</th>
        <th>年龄</th>
        <th>地址</th>
        <th>性别</th>
         <th>操作</th>
    </tr>
    </thead>
</table>
</body>
</html>