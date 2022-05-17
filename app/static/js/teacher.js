(function (L) {
    var _this = null;
    L.Teacher = L.Teacher || {};
    _this = L.Teacher = {
        data: {
        },
 
        init: function () {
        	_this.initEvents();
        	// _this.initUploader();
    
        },

        initEvents:function(){
        	$("#edit-user-btn").click(function(){
        		$("#edit-user-result").hide();
        		$.ajax({
		            url : '/teacher/addTeacher',
		            type : 'post',
		            data: {
		                username: $("input[name=username]").val(),
		                teachername: $("input[name=teachername]").val(),
		                password: hex_md5($("input[name=password]").val() + L.pwd_secret),
		                position: $("input[name=position]").val(),
						email: $("input[name=email]").val(),
						sign: $("input[name=sign]").val(),
						is_admin: $("#user_is_admin").prop("checked")?1:0,
		            },
		            dataType : 'json',
		            success : function(result) {
		                if(result.success){
							$("#edit-user-result").show();
		                     $("#edit-user-result div div").html("成功");
		                }else{
							$("#edit-user-result").show();
		                     $("#edit-user-result").html("编辑资料失败，请重试");
		                }
		            },
		            error : function() {
		            	$("#edit-user-result").show();
		                $("#edit-user-result div div").html("编辑资料发生错误，请重试");
		            }
		        });
        	});


        },

        uploadTip: function(ok, content){
        	if(ok){
				$("#edit-user-pwd-result").show();
				$("#edit-user-pwd-result div div").removeClass("alert-danger").addClass("alert-success").html(content);
        	}else{
        		$("#edit-user-pwd-result").show();
				$("#edit-user-pwd-result div div").removeClass("alert-success").addClass("alert-danger").html(content);
        	}
        },

        initUploader:function() {
        	$("#avatar_image").fileupload({  
	            url: '/upload/avatar',
	            sequentialUploads: true,
		        fail: function(e, data) {
		        	$("#upload_result_tip").html('<span style="color:red;">更改头像发生错误，请检查文件大小和格式</span>');
		        },
	        }).bind('fileuploadprogress', function (e, data) {  
	            var progress = parseInt(data.loaded / data.total * 100, 10);  
	            $("#avatar_upload_progress").css('width',progress + '%');  
	            $("#avatar_upload_progress").html(progress + '%');  
	        }).bind('fileuploaddone', function (e, data) { 
	        	//console.dir(data.result)
	        	var result = data.result || {};
	        	if(result.success && result.filename){
	        		var avatar_path = "/static/avatar/" + result.filename;
	        		$("#avatar_show").attr("src",avatar_path);
	            	$("#my_avatar").attr("src",avatar_path);
	            	$("#upload_result_tip").html('');
	        	}else{
	        		$("#upload_result_tip").html('<span style="color:red;">更改头像失败'  + (result.msg?": "+result.msg:"")+ '</span>');
	        	}
	        });  
        },

		loadCourse: function(type, pageNo){
        	pageNo = pageNo || 1;
        	$.ajax({
	            url : '/course/all',
	            type : 'get',
	            cache: false,
	            data: {
	                page_no: 1,
	                type: type,
	                category: _this.data.current_category
	            },
	            dataType : 'json',
	            success : function(result) {
	                if(result.success){
						console.log("==================================success")
	                	if(!result.data){
	                		// $("#topics-body").html('<div class="alert alert-info" role="alert">此分类下没有任何内容</div>');
	                	}else{
							$.each(result.data.courses, function(index,item) {
								console.log("==================================", index)
								$('.courseMessage').append('<tr><td>' + item.id + '</td><td>'+item.coursename+'</td><td>'+item.total_period+'</td><td>'+item.theoretical_period+'</td><td>'+item.experimental_period+'</td><td><button type="submit" class="btn btn-primary" onclick="javaScript:window.location.href=\'generalles.html\'">修改</button><button type="submit" class="btn btn-danger" onclick="deleteLes(\''+item.courseId+'\')">删除</button></td></tr>')
							})
	                	}
	                }else{
	                    $("#topics-body").html('<div class="alert alert-info" role="alert">'+result.msg+'</div>');
	                }
	            },
	            // error : function() {
	            //     $("#topics-body").html('<div class="alert alert-info" role="alert">error to send request.</div>');
	            // }
	        });
        },
		
        initAddLessonplan: function(){
			$.ajax({
				type: 'get',
				url: '/course/all',
                dataType: 'json',
                success : function(result){
					if(result.success){
						var classes=$("select").eq(1);
						$(classes).children().remove();
						$.each(result.data.courses, function(index,item) {
							console.log("==================================", index, item.coursename)
							$(classes).append("<option>" + item.coursename + "</option>")
						})
					}
                }
            });
        },
		initLessonplan: function(){
			$.ajax({
				type: 'get',
				url: '/course/all',
                dataType: 'json',
                success : function(result){
					if(result.success){
						var classes=$("select").eq(1);
						$(classes).children().remove();
						$.each(result.data.courses, function(index,item) {
							console.log("==================================", index, item.coursename)
							$(classes).append("<option>" + item.coursename + "</option>")
						})
					}
                }
            });
        },
		loadTeachers: function(){
        	$.ajax({
	            url : '/teacher/all',
	            type : 'get',
	            cache: false,
	            dataType : 'json',
	            success : function(result) {
	                if(result.success){
						console.log("==================================success")
	                	if(!result.data){
	                		// $("#topics-body").html('<div class="alert alert-info" role="alert">此分类下没有任何内容</div>');
	                	}else{
							$.each(result.data.users, function(index,item) {
								console.log("==================================", index, typeof(item.is_admin))
								$('.courseMessage').append('<tr><td>' + item.id + '</td><td>'+item.username+'</td><td>'+(item.teachername == '' ? '无' : item.teachername)+'</td><td>'+(item.position== '' ? '无' : item.position)+'</td><td>'+(item.email == '' ? '无' : item.email)+'</td><td>'+item.create_time+'</td><td>'+(item.is_admin == 1 ? '是' : '否')+'</td><td><button type="submit" class="btn btn-primary" id="btnModify">修改</button><button id="btnChgDIStatus" class="btn btn-danger" >删除</button></td></tr>')
							})
							var t = $('#example1').DataTable({
								"bProcessing" : true, 
								'paging'      : true,
								'lengthChange': true,
								'searching'   : true,
								'ordering'    : true,
								'info'        : true,
								'autoWidth'   : true,
								
								"bFilter" : true, //是否启动过滤、搜索功能  
								
								
								"oLanguage": { //国际化配置  
									"sProcessing" : "正在获取数据，请稍后...",    
									"sLengthMenu" : "显示 _MENU_ 条",    
									"sZeroRecords" : "没有您要搜索的内容",    
									"sInfo" : "从 _START_ 到  _END_ 条记录 总记录数为 _TOTAL_ 条",    
									"sInfoEmpty" : "记录数为0",    
									"sInfoFiltered" : "(全部记录数 _MAX_ 条)",    
									"sInfoPostFix" : "",    
									"sSearch" : "搜索",    
									"sUrl" : "",    
									"oPaginate": {    
										"sFirst" : "第一页",    
										"sPrevious" : "上一页",    
										"sNext" : "下一页",    
										"sLast" : "最后一页"    
									}  
								},
							});
							function reloadDt() {};
							t.on('click', 'button#btnChgDIStatus', function () {
								
								var row = t.row($(this).parents('tr'));
								$.ajax({
									url : '/user/'+row.data()[0]+'/delete',
									type : 'get',
									data : {},
									dataType : 'json',
									success : function(result) {
										if(result.success){
											row.remove().draw(false);
										}else{
											L.Common.showTipDialog("提示", result.msg);
										}
									},
									error : function() {
										L.Common.showTipDialog("提示", "删除文章请求发生错误");
									}
								});
								console.log("============",row.data()[0])
								// row.remove().draw(false);
							});
							t.on('click', 'button#btnModify', function () {
								
								var id = t.row($(this).parents('tr').data()[0]);
								var dataTab = t.row($(this).parents('tr')).data();
								var data = {"user":{"username":dataTab[1],"teachername":dataTab[2],"position":dataTab[3],"email":dataTab[4]}};
								// console.log(data);
								// console.log(data[1],data[2],data[3],data[4]);
								var initData = {
									"appendId": "modalRef",//加到哪里去
									"modalId": "myModal",
									"title": "修改",
									"formId": "formEdit", //form的ID
									// "loadUrl": "null", //如果不从页面加载，写成"null" 
									// "loadParas": { "ID": id },     //向loadUrl传的数据
									"postUrl": "/BasicManage/Edit", //提交add的url
									"close": reloadDt, //关闭弹出窗后调用的方法
									// "cols": [ {"displayName":"菜单名","fieldName":"Name"}]   
								};
								_this.setModal(initData, data, dataTab[0])
							});
	                	}
	                }else{
	                    $("#topics-body").html('<div class="alert alert-info" role="alert">'+result.msg+'</div>');
	                }
	            },
	            // error : function() {
	            //     $("#topics-body").html('<div class="alert alert-info" role="alert">error to send request.</div>');
	            // }
	        });
        },
		setModal: function (initData, data, course_id) {
			var modal = "<div class='modal fade' id='" + initData.modalId + "' tabindex='-1' role='dialog' aria-labelledby='myModalLabel' aria-hidden='true'> <div class='modal-dialog'> <div class='modal-content'> <div class='modal-header'> <button type='button' class='close'  data-dismiss='modal' aria-hidden='true'> </button><h4 class='modal-title' id='myModalLabel'>" + initData.title + "</h4> </div> <div class='modal-body' id = 'modalBody'> </div> <div class='modal-footer'><button id='btn-close" + initData.modalId + "' type='button' class='btn btn-default'  data-dismiss='modal'> 关闭 </button> <button type='button' id='btn-" + initData.modalId + "' class='btn btn-primary'> 提交</button> </div></div></div> </div>";
			$("#" + initData.appendId).empty();
			$("#" + initData.appendId).append(modal);
		
			//加载一个页面的内容
			// if (data.loadUrl != "null") {
			// 	var form2 = "<form id='" + data.formId + "'>  </form>";
			// 	$("#" + data.modalId + " .modal-body").append(form2);
			// 	$("#" + data.formId).load(data.loadUrl, data.loadParas);
			// }
			// else {
				// var form2 = "<form id='" + data.formId + "' action='#'";
				// for (var i = 0; i < data.cols.length; i++) {
				// 	form2 += " <div > <label  >" + data.cols[i]["displayName"] + "</label> <input type='text' class='form-control' name='" + data.cols[i]["fieldName"] + "' placeholder=''> </div>";
				// }
				// form2 += "</form>";
				// $("#" + data.modalId + " .modal-body").append(form2);
			// }
			var $container = $("#modalBody");
			$container.empty();

			var tpl = $("#modal-tpl").html();
			var html = juicer(tpl, data);
			$container.html(html);
			$("#" + initData.modalId).modal('show');
			$("#btn-" + initData.modalId).click(function ()
			{
        		$.ajax({
		            url : '/user/update',
		            type : 'post',
		            data: {
						username: data.user.username,
		                teachername: $("input[name=teachername]").val(),
		                password: hex_md5($("input[name=password]").val() + L.pwd_secret),
		                position: $("input[name=position]").val(),
						email: $("input[name=email]").val(),
						is_admin: $("#user_is_admin").prop("checked")?1:0,
		            },
		            dataType : 'json',
		            success : function(result) {
						window.location.href="/teacher/viewTeacher";
		            },
		            error : function() {
		            	$("#edit-user-result").show();
		                $("#edit-user-result div div").html("编辑资料发生错误，请重试");
		            }
		        });
		
			});
		
			$("#btn-close" + initData.modalId).click(function () {
				initData.close();
			});
		},
    };
}(APP));