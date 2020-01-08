<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./DataTables/media/css/jquery.dataTables.css"></link>


<style type="text/css">
    html {
        padding: 0px;
        margin: 0px;
        font-size: 0.75rem;
    }
 
    body {
        padding: 0px;
        margin: 0px;
        font-size: 1.0rem;
    }
 
    form {
        width: 400px;
        margin: 20px;
    }
 
    .form-group {
        margin-bottom: 1.25rem;
    }
 
    .form-group {
        display: flex;
        align-items: center;
    }
 
    .form-group>label {
        width: 8.0rem;
        text-align: right;
        box-sizing: border-box;
        padding-right: 1.25rem;
        align-self: center;
    }
 
    .form-group>input {
        flex-grow: 1;
        border: 1px solid #ddd;
        border-radius: 0.25rem;
        padding: .375rem .75rem;
        font-size: 1.0rem;
        background-color: #fff;
        background-clip: padding-box;
        transition: border-color .15s ease-in-out, box-shadow .15s ease-in-out;
    }
 
    .form-group>input[type='text']:focus,
    .form-group>input[type="textarea"]:focus,
    .form-group>input[type="password"]:focus {
        color: #495057;
        border-color: #80bdff;
        outline: 0;
        box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, .25);
    }
 
    input[type='radio'],
    input[type='checkbox'] {
        display: none;
    }
 
    input[type='radio']+label,
    input[type='checkbox']+label {
        margin-right: 1.25rem;
    }
 
    input[type='radio']+label:before,
    input[type='checkbox']+label:before {
        content: "";
        /*不换行空格*/
        display: inline-block;
        width: 1.2rem;
        height: 1.2rem;
        margin-right: .4rem;
        border-radius: 100%;
        border: 1px solid #ddd;
        line-height: 1;
        box-sizing: border-box;
 
    }
 
    input[type='radio']+label:before {
        vertical-align: -0.166667rem;
        /*因为content为空，数据无法对齐，只能用vertical-align调整*/
    }
 
    input[type='radio']:checked+label:before {
        background-color: #5cb5f9;
        background-clip: content-box;
        padding: .15rem;
        border-color: #5cb5f9;
    }
 
    input[type='checkbox']+label:before {
        content: "√";
        color: #fff;
        border-radius: 0.25rem;
        font-weight: bold;
    }
 
    input[type='checkbox']:checked+label:before {
        background-color: #5cb5f9;
        text-align: center;
        font-weight: bold;
        border-color: #5cb5f9;
 
    }
 
    input[type='checkbox']#switch+label {
        cursor: pointer;
        width: 4rem;
        height: 1.5rem;
        display: block;
        position: relative;
        border: 1px solid #727577;
        background-color: #727577;
        border-radius: 1rem;
        margin-right: 0px;
        -webkit-transition: all 0.2s;
        -o-transition: all 0.2s;
        transition: all 0.2s;
 
    }
 
    input[type='checkbox']#switch+label:before {
        content: "";
        width: 1.5rem;
        height: 1.5rem;
        border-radius: 100%;
        background: #fff;
        position: absolute;
        margin-right: 0px;
        -webkit-transition: all 0.3s;
        -o-transition: all 0.3s;
        transition: all 0.3s;
 
    }
 
    input[type='checkbox']#switch+label:after {
        content: attr(data-off);
        color: #fff;
        position: absolute;
        right: 0.5rem;
        -webkit-transition: all 0.3s;
        -o-transition: all 0.3s;
        transition: all 0.3s;
    }
 
    input[type='checkbox']#switch:checked+label {
        border: 1px solid #5cb5f9;
        background-color: #5cb5f9;
    }
 
    input[type='checkbox']#switch:checked+label:before {
        right: 0px;
    }
 
    input[type='checkbox']#switch:checked+label:after {
        content: attr(data-on);
        left: 0.5rem;
    }
 
    .form-range-group {
        width: 12.5rem;
    }
 
    input[type=range] {
        -webkit-appearance: none;
        -moz-appearance: none;
        appearance: none;
        /*这三个是去掉那条线原有的默认样式，亲测没啥用！*/
        width: 100%;
        border: none;
        outline: none;
        margin: 0px;
        padding: 0px;
        display: block;
    }
 
    /*设置控制条轨迹的样式*/
    /* chrome 或者 safari */
    input[type='range']::-webkit-slider-runnable-track {
        height: 1rem;
        background-color: #eee;
        border-radius: 1rem;
    }
 
    /*firefox */
    input[type='range']::-moz-range-track {
        height: 1rem;
        background-color: #eee;
        border-radius: 1rem;
    }
 
    /*IE*/
    input[type="range"]::-ms-track {
        color: transparent;
        background-color: #eee;
    }
 
    /*设置控制的拖拽按钮样式*/
    /*firefox 和 chrome*/
    input[type='range']::-webkit-slider-thumb {
        -webkit-appearance: none;
        height: 1rem;
        width: 1rem;
        border-radius: 20%;
        background: #1ba1e2;
        cursor: pointer;
        /*占用空间最小高度为16px,在父元素中使用align-items:center改变占用空间*/
    }
 
    /*firefox */
    input[type='range']::-moz-range-thumb {
        -moz-appearance: none;
        height: 1rem;
        width: 1rem;
        border-radius: 20%;
        background: #1ba1e2;
        border: none;
        cursor: pointer;
        /*占用空间最小高度为17.33*/
    }
 
    /*IE*/
    input[type='range']::-ms-thumb {
        -ms-appearance: none;
        height: 1rem;
        width: 1rem;
        border-radius: 20%;
        background: #1ba1e2;
        border: none;
        cursor: pointer;
    }
 
 
    .btn {
        display: inline-block;
        font-weight: 400;
        text-align: center;
        white-space: nowrap;
        vertical-align: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
        border: 1px solid transparent;
        padding: .375rem .75rem;
        line-height: 1.5;
        border-radius: .25rem;
        transition: color .15s ease-in-out, background-color .15s ease-in-out, border-color .15s ease-in-out, box-shadow .15s ease-in-out;
    }
 
    .btn:not(:disabled):not(.disabled) {
        cursor: pointer;
 
    }
 
    .btn-primary {
        color: #fff;
        background-color: #007bff;
        border-color: #007bff;
    }
 
    .btn-primary:hover {
        filter: hue-rotate(14deg);
    }
    
   .warp{
   		width:100%;
   		text-align: center;
   }
    </style>
</head>
<script type="text/javascript" src="./DataTables/media/js/jquery.js"></script>  
<script type="text/javascript" src="./DataTables/media/js/jquery.dataTables.js"></script>  
<script type="text/javascript">
		 
</script>
<body>
	<div class="wrapper" style="position:absolute; left:500px;top:100px;">
	<form action="modifyServlet" method="post">
			<div class="form-group">
               <input id="id" type="hidden" name="id" value="${user.id}"/>
            </div>
			<div class="form-group">
                <label for="inputname">姓名</label>
               <input id="name" type="text" name="name" minlength="2" maxlength="12" class="error" value="${user.name}"/>
            </div>
            <div class="form-group">
                <label for="inputpassword">家乡</label>
                <input id="address" type="text" maxlength="100" name="address" value="${user.address}"/>
            </div>
           <div class="form-group">
                <label for="inputname">毕业院校</label>
                <input id="school" type="text" maxlength="50" name="school" value="${user.school}"/>
            </div>
            <div class="form-group">
                <label for="inputname">邮箱</label>
               <input id="email" type="text" name="email" value="${user.email}" 
				pattern="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"/>
            </div>
            <div class="form-group">
                <label for="inputname">电话</label>
                 <input id="phone" type="text" maxlength="11" name="phone" value="${user.phone}"
		pattern="(\d{11})|^((\d{7,8})|(\d{4}|\d{3})-(\d{7,8})|(\d{4}|\d{3})-(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1})|(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1}))$"/>
            </div>
            <div class="form-group">
                <label for="inputname">自我介绍</label>
                <input type="text" id="description" name="description" value="${user.description}" maxlength="200"></input>
            </div>
            <div class="form-group">
                <label for=""></label>
                <div class="form-button-group">
                    <button type="submit" class="btn btn-primary">确认</button>
                    <button id="cancle" class="btn btn-primary">取消</button>
                </div>
            </div>
        </form>
    </div>
</body>


<script type="text/javascript">
	$("#cancle").click(function(){
		window.location.href="/table2.jsp";
	}) 


</script>
</html>