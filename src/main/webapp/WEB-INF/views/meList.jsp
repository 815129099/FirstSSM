<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>
           <%@ page isELIgnored="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta charset="UTF-8">
    <title>用户列表</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    <link href="style/css/style20160105.css" rel="stylesheet">
    <link href="http://apps.bdimg.com/libs/fontawesome/4.2.0/css/font-awesome.min.css" rel="stylesheet"/>
   	<link rel="stylesheet" href="style/css/table.css">
   	<link rel="stylesheet" href="style/css/bootstrap.min.css">

  </head>


  <body>
    <div class="x-body">
<div class="container" style="padding-top:30px;height:100%;weight:80%;">
	<div class="content">
		<!-- Content wrapper -->
		<div class="wrapper">
			<!--主页-->
			<div>
				<!-- Table with toolbar -->
				<div class="widget">
					<!--查询条件-->
					<div class="well">
						<form class="form-inline" role="form" id="query">
							<div class="form-group" style="margin-right:10px">
								<label>书籍代码:</label>
								<input type="text" class="form-control" name="bookId" id="bookId" maxlength="128" placeholder="书籍代码">
							</div>

							<div class="form-group" style="margin-right:10px">
								<label>书籍名称:</label>
							<input type="text" class="form-control" name="bookName" id="bookName" maxlength="128" placeholder="书籍名称">
							</div>

							<div class="form-group" style="margin-right:10px">
                            	<label>书籍储位:</label>
                            	<input type="text" class="form-control" name="bookLocation" id="bookLocation" maxlength="128" placeholder="书籍储位">
                            </div>
							<div class="form-group">
							<button type="button" class="btn btn-warning" id="querybtn">查询</button>
							</div>
						</form>
					</div>
					<!-- /well -->
				</div>

				<!--/数据表格-->
				<ul class="toolbar">
					<li><a href="javascript:void(0)" id="addBook"><i class="fa fa-user"></i><span>添加</span></a></li>
					<li><a href="javascript:void(0)" id="lockUser" onclick='lockUser()'><i class="fa fa-toggle-on"></i><span>锁定</span></a></li>
                    <li><a href="javascript:void(0)" id="clearUser" onclick='clearUser()'><i class="fa fa-toggle-off"></i><span>解锁</span></a></li>
				</ul>
					<table class="table table-striped table-bordered table-hover" id="userTable">
						<thead>
							<tr>

							<th>#</th>
							<th>书籍代码</th>
							<th>书名</th>
							<th>书籍储位</th>
							<th>总数量</th>
							<th>可借数量</th>
							<th>操作</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
							<tfoot>
								<tr>
									<td colspan="8">
									<div id="total" class="pull-left" style="padding-top:20px;padding-left:10px">&nbsp;</div>
									<div class="pull-right">
			                           <ul class="pagination" id="pagination"></ul>
			                        </div>
									</td>
								</tr>
							</tfoot>
						</table>


		</div>
				<!--登记-->
				<div class="modal fade" id="resetModal" role="dialog"
					aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
							<!--
								<button type="button" class="close" aria-hidden="true">&times;</button>
								-->
								<h4 class="modal-title" id="myModalLabel">登记借阅信息</h4>
							</div>
					        <form role="form" id="resetform" method="post">
                            <input type="hidden" name="id" id="id"/>
							<div class="modal-body">
								<div class="well">
									<div id="sucUpd" class="alert alert-success">
									 <button type="button" class="close" id="close" aria-hidden="true">
                                     &times;
                                     </button>
										<strong>登记成功！</strong>
									</div>
									<div id="failUpd" class="alert alert-warning">
									 <button type="button" class="close" id="close"   aria-hidden="true">
                                      &times;
                                     </button>
										<strong>登记失败！</strong>
									</div>

									<div class="alert alert-danger hide" id="tipError" style='color: white'>&nbsp;</div>
                                        <div class="form-group" style="margin-right: 10px">
											<label>书籍代码:</label> <input type="text"
												class="form-control" name="bookId" id="bookId" readonly>
										</div>
										<div class="form-group" style="margin-right: 10px">
											<label>借阅人工号:</label> <input type="text"
												class="form-control" name="geNumber" id="geNumber" placeholder="工号">
										</div>
										<div class="form-group" style="margin-right: 10px">
											<label>借阅人姓名:</label> <input type="text"
												class="form-control" name="geName" id="geName" placeholder="名字">
										</div>

								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default"
									data-dismiss="modal" id="cancel">取消</button>
								<button type="submit" class="btn btn-warning" id="resetBtn">登记</button>
							</div>
                         </form>
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal -->
				</div>
				<!-- 重置密码-->

				<!--添加用户-->
				<div class="modal fade" id="addModal" role="dialog"
					aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h4 class="modal-title" id="myModalLabel">添加书籍</h4>
							</div>
					        <form role="form" id="addform" method="post">
							<div class="modal-body">
								<div class="well">
									<div id="sucUpd" class="alert alert-success">
									 <button type="button" class="close" id="close" aria-hidden="true">
                                     &times;
                                     </button>
										<strong>添加成功！</strong>
									</div>
									<div id="failUpd" class="alert alert-warning">
									 <button type="button" class="close" id="close"   aria-hidden="true">
                                      &times;
                                     </button>
										<strong>添加失败！</strong>
									</div>

									<div class="alert alert-danger hide" id="tipError" style='color: white'>&nbsp;</div>
                                        <div class="form-group" style="margin-right: 10px" id="bId">
											<label>书籍代码:</label> <input type="text"
												class="form-control" name="bookId" id="bookId" placeholder="书籍代码">
										</div>
										<div class="form-group" style="margin-right: 10px">
											<label>书籍名称:</label> <input type="text"
												class="form-control" name="bookName" id="bookName" placeholder="书籍名称">
										</div>
										<div class="form-group" style="margin-right: 10px">
											<label>书籍数量:</label> <input type="text"
												class="form-control" name="bookNumber" id="bookNumber" placeholder="书籍数量">
										</div>
										<div class="form-group" style="margin-right: 10px">
											<label>书籍储位:</label>
											<select name="type" id="bookLocation" class="form-control">
											    <option value="A-1-1">A-1-1</option>
												<option value="A-1-2">A-1-2</option>
												<option value="A-2-1">A-2-1</option>
                                                <option value="A-2-2">A-2-2</option>
                                                <option value="A-2-3">A-2-3</option>
                                                <option value="A-3-1">A-3-1</option>
                                                <option value="A-3-2">A-3-2</option>
                                                <option value="A-4-1">A-4-1</option>
                                                <option value="A-4-2">A-4-2</option>
                                                <option value="A-4-3">A-4-3</option>
                                                <option value="A-5-1">A-5-1</option>
                                                <option value="A-5-2">A-5-2</option>
                                                <option value="B-1-1">B-1-1</option>
                                                <option value="B-2-1">B-2-1</option>
                                                <option value="B-3-1">B-3-1</option>
                                                <option value="B-4-1">B-4-1</option>
                                                <option value="B-5-1">B-5-1</option>
                                                <option value="C-1-1">C-1-1</option>
                                                <option value="C-1-2">C-1-2</option>
                                                <option value="C-2-1">C-2-1</option>

											</select>
										</div>

								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default"
									data-dismiss="modal" id="cancel">取消</button>
								<button type="submit" class="btn btn-warning" id="addBtn">添加</button>
							</div>
                         </form>
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal -->
				</div>
				<!-- /添加用户-->

                <!--修改用户-->
				<div class="modal fade" id="updateModal" role="dialog"
					aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
							<!--
								<button type="button" class="close" aria-hidden="true">&times;</button>
								-->
								<h4 class="modal-title" id="myModalLabel">修改用户信息</h4>
							</div>
					        <form role="form" id="updateform" method="post">
							<div class="modal-body">
								<div class="well">
									<div id="sucUpd" class="alert alert-success">
									 <button type="button" class="close" id="close" aria-hidden="true">
                                     &times;
                                     </button>
										<strong>登记成功！</strong>
									</div>
									<div id="failUpd" class="alert alert-warning">
									 <button type="button" class="close" id="close"   aria-hidden="true">
                                      &times;
                                     </button>
										<strong>登记失败！</strong>
									</div>

									<div class="alert alert-danger hide" id="tipError" style='color: white'>&nbsp;</div>
                                        <div class="form-group" style="margin-right: 10px">
											<label>登录名:</label> <input type="text"
												class="form-control" name="email" id="email" placeholder="电子邮箱" readonly>
										</div>
										<div class="form-group" style="margin-right: 10px">
											<label>用户名:</label> <input type="text"
												class="form-control" name="realname" id="realname" placeholder="用户名">
										</div>
										<div class="form-group" style="margin-right: 10px">
											<label>手机号码:</label> <input type="text"
												class="form-control" name="mobile" id="mobile" placeholder="手机号码">
										</div>
										<div class="form-group" style="margin-right: 10px">
											<label>权限:</label>
											<select name="type" id="type" class="form-control">
											    <option value="普通用户">普通用户</option>
												<option value="管理员">管理员</option>
											</select>
										</div>

								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default" data-dismiss="modal" id="cancelbtn">取消</button>
								<button type="submit" class="btn btn-warning" id="addBtn">修改</button>
							</div>
                         </form>
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal -->
				</div>
				<!-- 修改用户-->
				<div class="col-lg-1"></div>
</div>
</div>
</div>
    </div>
      <script src="style/js/jquery.1.10.1.min.js"></script>
        <script src="style/js/bootstrap.min.js"></script>
        <script type="text/javascript"  src="style/lib/layui/layui.js" ></script>
        <script type="text/javascript" src="style/js/xadmin.js"></script>
        <script src="style/js/service.ddlist.jquery.min.js"></script>

     <!-- 表单验证 -->
        <script src="style/js/validate/jquery.validate.min.js"></script>
        <script src="style/js/validate/additional-methods.js"></script>
         <script type="text/javascript" src="style/js/jquery.dataTables.min.js"></script>
    <!-- 表格 -->
        <script type="text/javascript" src="style/js/common1.js"></script>
     <!-- 分页 -->
        <script src="style/js/jqPaginator/jqPaginator.min.js"></script>
    <script type="text/javascript">
    //表单验证
    $.validator.setDefaults({
        debug: true
    });

    $(document).ready(function(){
    	//查询全部用户列表
    	listBook();
    $("#chkAll").click(function(){
    	chkAll("chkAll","chk");
    });
    	//查询功能
    	$("#querybtn").click(function(){
    		listBook();
    	});

    	//添加用户
            	$("a#addBook").click(function(){

            	    $("#addform #bookId").val("");
            		$("#addform #bookName").val("");
            		$("#addform #bookNumber").val("");
            		$("#addform #bookLocation").val("");
            		$("label.error").remove();

            		$("div#addModal #sucUpd").hide();
            		$("div#addModal #failUpd").hide();

            		$("#addModal").modal('show');

            		//验证书籍代码是否已用
            		$("#addform #bookId").blur(function(){

            			$.post("isIdExist.do",{"bookId":$("#addform #bookId").val()},function(response){
            			$("#addform #bookId").parent().find("label.error").remove();
                            if(response.tip=="error"){
                            	$("#addform #bookId").parent().append("<label class='error'>该书籍代码已存在</label>");
                            	$("#addform #bookId").focus();
            				}
            			});
            		});

            		//验证书籍名称是否已存在
                    $("#addform #bookName").blur(function(){

                            $.post("isNameExist.do",{"bookName":$("#addform #bookName").val()},function(response){
                            $("#addform #bookName").parent().find("label.error").remove();
                                  if(response.tip=="error"){
                                        $("#addform #bookName").parent().append("<label class='error'>该书籍已录入，可直接修改数量</label>");
                                        $("#addform #bookName").focus();
                                  }
                            });
                    });

            		//设置表单验证
            		$("#addform").validate({
            			  //onfocusout:false,
            			  onkeyup:false,
            		      rules:{
            		    	  bookId:{required:true,rangelength:[5,5]},
            		    	  bookName:{required:true},
            		    	  bookNumber:{required:true},
            		    	  bookLocation:{required:true},
            		      },
            		      messages:{
            		    	  bookId:{required:"书籍代码不能为空<br/>",rangelength:"请输入5位书籍代码<br/>"},
            		    	  bookName:{required:"书籍名称不能为空<br/>"},
            		    	  bookNumber:{required:"书籍数量不能为空<br/>"},
            		    	  bookLocation:{equalTo:"书籍储位不能为空<br/>"}
            		      },
            		      submitHandler:function(){
            					if(!$("#addform").valid()){
            						$("div#addModal #sucUpd").hide();
            						$("div#addModal #failUpd").hide();
            					}
            					else{
            					$.post("addBook.do",
            							{"bookId":$("#addform #bookId").val(),
            						     "bookName":$("#addform #bookName").val(),
            						     "bookNumber":$("#addform #bookNumber").val(),
            						     "bookLocation":$("#addform #bookLocation").val()
            						     },
            						     function(response){
            						if(response.tip=="success"){
            							   $("div#addModal #sucUpd").show();
            							    $("div#addModal #failUpd").hide();
            								 //关闭窗口后刷新列表
            							    $("#addform #cancel").click(function(){
            							    	listBook();
            							    });
            						   }
            						   else{
            							   $("div#addModal #failUpd").show();
            							   $("div#addModal #sucUpd").hide();
            						   }
            					});
            				}
            		      }
            		  });
            	});

    });
    	function listBook(){
    	//查询条件
    	var bookId = $("form#query #bookId").val();
    	var bookName = $("form#query #bookName").val();
    	var bookLocation = $("form#query #bookLocation").val();

    	//获取用户列表
    	$.post('listBook.do',
    	       {"bookId":bookId,
    	       "bookName":bookName,
    	       "bookLocation":bookLocation
    	       },
    	       function(response){
    	       console.log(response.page);
    	    	 //生成结果列表
    			 initDataTable("userTable", 6, new Array("bookId","bookName","bookLocation","bookNumber","lendNumber"), response.page,
    						"listBook.do",  {"bookId":bookId,
    						    "bookName":bookName,
    						    "bookLocation":bookLocation
    					       }, false, true, true, true,true,
    					       "<a href='javascript:void(0)' id='update' title='登记' style='padding-right:20px' onclick='check(this)'><i class='fa fa-edit'></i></a>"+
    					       "<a href='javascript:void(0)' title='删除' id='del' style='padding-right:20px' onclick='delUser(this)'><i class='fa fa-trash'></i></a>"+
    					       "<a href='javascript:void(0)' title='查看'  style='padding-right:20px' onclick='preview(this)'><i class='fa fa-wrench'></i></a>",
    					       "id"
    			 );
    	    	 //设置查询条件
    			 $("form#query #bookId").val(bookId);
    			 $("form#query #bookName").val(bookName);
    			 $("form#query #bookLocation").val(bookLocation);
    	       }
    	);
    	}

    	//删除用户
    	function delUser(obj){
    		if(confirm("是否删除该用户")){
    			var id =  $(obj).parent("td").attr("id");
    			alert(id);
    			$.post("delUser.do",{"id":id},function(response){
                				if(response.tip=="success"){
                					alert("用户删除成功");
                					listBook();
                				}
                				else if(response.tip=="error"){
                					alert("用户删除失败!"+response.msg);
                				}
                			});
    		}
    	}

    	//查看用户
        	function preview(obj){
        			var id =  $(obj).parent("td").attr("id");
        			window.open("pre?id="+id);
        	}

    function lockUser(){
    	var row,id;
    	var num = 0;
    	 $("input[type='checkbox']").each(function(){
    		 if($(this).is(":checked"))
              {
              num++;
    			 row = $(this).parent("td").parent("tr");
    			 id = row.find("td #update").parents("td").attr("id");
              }
    		        	 $.post("lockUser.do",
    					{"id":id});
    		        	  listBook();
    	 });
    	 if(num==0){
    	 alert("请选择用户");
    	 }
    	 $("#chkAll").attr("checked",false);
    };

    function clearUser(){
    	var row,id;
    	var num = 0;
    	 $("input[type='checkbox']").each(function(){
    		 if($(this).is(":checked"))
              {
              num++;
    			 row = $(this).parent("td").parent("tr");
    			 id = row.find("td #update").parents("td").attr("id");
              }
    		        	 $.post("clearUser.do",
    					{"id":id});
    		        	  listBook();
    	 });
    	 if(num==0){
    	 alert("请选择用户");
    	 }
    	 $("#chkAll").attr("checked",false);
    };

    //登记
    	function check(obj){
    		//初始化模态窗口
    		var id = $(obj).parent("td").attr("id");
    		var bookId = $(obj).parent("td").siblings("td").eq(1).html();
    		alert(bookId);
    		$("#resetform #id").val(id);
    		$("#resetform #bookId").val(bookId);
    		$("#resetform #geNumber").val("");
    		$("#resetform #geName").val("");
    		$("label.error").remove();

    		$("div#resetModal #sucUpd").hide();
    		$("div#resetModal #failUpd").hide();
            var number = parseInt($(obj).parent("td").siblings("td").eq(5).html());
            if(number<=0){
            alert("该书剩余数量为0，无法借阅！");
            }else{
            $("#resetModal").modal('show');
            }


    		//设置表单验证
    		 $("#resetform").validate({
    			  onfocusout:false,
    			  onkeyup:false,
    		      rules:{
    		    	  geName:{required:true},
    		    	  geNumber:{required:true}
    		      },
    		      messages:{
    		    	  geName:{required:"借阅人名字不能为空<br/>"},
    		    	  geNumber:{required:"借阅人工号不能为空<br/>"},
    		      }
    		    });

    		$("#resetform").submit(function(){
    			if(!$("#resetform").valid()){
    				$("div#resetModal #sucUpd").hide();
    				$("div#resetModal #failUpd").hide();
    			}
    			//,"geName":$("#resetform #geName").val(),"geNumber":$("#resetform #geNumber").val()
    			else{
    			$.post("checkBook.do",{"bookId":bookId},function(response){
    				if(response.tip=="success"){
    					   $("div#resetModal #sucUpd").show();
    					    $("div#resetModal #failUpd").hide();
    						$("#resetform #bookName").val("");
    						$("#resetform #bookNumber").val("");
    						listBook();
    				   }
    				   else{
    					   $("div#resetModal #failUpd").show();
    					   $("div#resetModal #sucUpd").hide();
    				   }
    			});
    		}
    			return false;
    		});

    	}
    </script>
  </body>

</html>