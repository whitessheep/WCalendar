(function (L) {
	var _this = null;
	L.Lessonplan = L.Lessonplan || {};
	_this = L.Lessonplan = {
		data: {
			lessonplan_id: 0,
		},

		init: function () {
			_this.initEvents();

		},

		initEvents: function () {

			$("#add-lessonplan-btn").click(function () {
				$("#edit-user-result").hide();
				alert($(".coursename").val());
				$.ajax({
					url: '/course/addLessonplan',
					type: 'post',
					data: {
						semester: $(".semester").val(),
						coursename: $(".coursename").val(),
						teachername: $(".teachername").val(),
						classname: $(".classname").val()
					},
					dataType: 'json',
					success: function (result) {
						if (result.success) {
							$("#edit-user-result").show();
							$("#edit-user-resultdiv div").html("编辑成功");
						} else {
							$("#edit-user-result").show();
							$("#edit-user-resultdiv div").html("编辑资料发生错误，请重试");
						}
					},
					error: function () {
						$("#edit-user-result").show();
						$("#edit-user-result div div").html("编辑资料发生错误，请重试");
					}
				});
			});

		},

		initAddLessonplan: function () {
			$.ajax({
				type: 'get',
				url: '/course/all',
				dataType: 'json',
				success: function (result) {
					if (result.success) {
						var classes = $("select").eq(1);
						$(classes).children().remove();
						$.each(result.data.courses, function (index, item) {
							console.log("==================================", index, item.coursename)
							$(classes).append("<option>" + item.coursename + "</option>")
						})
					}
				}
			});
			$.ajax({
				type: 'get',
				url: '/teacher/all',
				dataType: 'json',
				success: function (result) {
					if (result.success) {
						var classes = $("select").eq(2);
						$(classes).children().remove();
						$.each(result.data.users, function (index, item) {
							console.log("==================================", index, item.coursename)
							$(classes).append("<option>" + item.teachername + "</option>")
						})
					}
				}
			});
		},

		initLessonplan: function () {
			$.ajax({
				type: 'get',
				url: '/course/all',
				dataType: 'json',
				success: function (result) {
					if (result.success) {
						var classes = $("select").eq(1);
						$(classes).children().remove();
						$.each(result.data.courses, function (index, item) {
							console.log("==================================", index, item.coursename)
							$(classes).append("<option>" + item.coursename + "</option>")
						})
					}
				}
			});
		},

		loadLessonplan: function () {
			$.ajax({
				url: '/lessonplan/get_all',
				type: 'get',
				cache: false,
				dataType: 'json',
				success: function (result) {
					if (result.success) {
						console.log("==================================success")
						if (!result.data) {
						} else {
							$.each(result.data.lessonplan, function (index, item) {
								console.log("==================================", index)
								var strState
								if (item.state == 0) {
									strState = '<font color="red">未提交</font>'
								}
								else if (item.state == 1) {
									strState = '待审核'
								}
								else {
									strState = '已批准'
								}
								$('.courseMessage').append('<tr><td>' + item.id + '</td><td>' + item.semester + '</td><td>' + item.coursename + '</td><td>' + item.teachername + '</td><td>' + item.classname + '</td><td>' + strState + '</td><td><button type="submit" class="btn btn-primary" id="btnModify">修改</button><button id="btnChgDIStatus" class="btn btn-danger" >删除</button></td></tr>')
							})
							var t = $('#example1').DataTable({
								"bProcessing": true,
								'paging': true,
								'lengthChange': true,
								'searching': true,
								'ordering': true,
								'info': true,
								'autoWidth': true,

								"bFilter": true, //是否启动过滤、搜索功能  


								"oLanguage": { //国际化配置  
									"sProcessing": "正在获取数据，请稍后...",
									"sLengthMenu": "显示 _MENU_ 条",
									"sZeroRecords": "没有您要搜索的内容",
									"sInfo": "从 _START_ 到  _END_ 条记录 总记录数为 _TOTAL_ 条",
									"sInfoEmpty": "记录数为0",
									"sInfoFiltered": "(全部记录数 _MAX_ 条)",
									"sInfoPostFix": "",
									"sSearch": "搜索",
									"sUrl": "",
									"oPaginate": {
										"sFirst": "第一页",
										"sPrevious": "上一页",
										"sNext": "下一页",
										"sLast": "最后一页"
									}
								},
							});
							function reloadDt() { };
							t.on('click', 'button#btnChgDIStatus', function () {

								var row = t.row($(this).parents('tr'));
								$.ajax({
									url: '/lessonplan/' + row.data()[0] + '/delete',
									type: 'get',
									data: {},
									dataType: 'json',
									success: function (result) {
										if (result.success) {
											row.remove().draw(false);
										} else {
											L.Common.showTipDialog("提示", result.msg);
										}
									},
									error: function () {
										L.Common.showTipDialog("提示", "删除文章请求发生错误");
									}
								});
								console.log("============", row.data()[0])
								// row.remove().draw(false);
							});
							t.on('click', 'button#btnModify', function () {

								var id = t.row($(this).parents('tr').data()[0]);
								var dataTab = t.row($(this).parents('tr')).data();
								var data = { "lessonplan": { "coursename": dataTab[2], "teachername": dataTab[3], "classname": dataTab[4] } };
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
					} else {
						$("#topics-body").html('<div class="alert alert-info" role="alert">' + result.msg + '</div>');
					}
				},
			});
		},
		setModal: function (initData, data, lessonplan_id) {
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
			_this.initAddLessonplan();
			$("#" + initData.modalId).modal('show');
			$("#btn-" + initData.modalId).click(function () {
				$.ajax({
					url: '/lessonplan/update',
					type: 'post',
					data: {
						lessonplan_id: lessonplan_id,
						semester: $(".semester").val(),
						coursename: $(".coursename").val(),
						teachername: $(".teachername").val(),
						classname: $("input[name=classname]").val(),
					},
					dataType: 'json',
					success: function (result) {
						window.location.href = "/lessonplan/view";
					},
					error: function () {
						$("#edit-user-result").show();
						$("#edit-user-result div div").html("编辑资料发生错误，请重试");
					}
				});

			});

			$("#btn-close" + initData.modalId).click(function () {
				initData.close();
			});
		},
		loadMyLessonplan: function () {
			$.ajax({
				url: '/lessonplan/get_user_all',
				type: 'get',
				data: {
				},
				cache: false,
				dataType: 'json',
				success: function (result) {
					if (result.success) {
						// console.log("==================================success")
						if (!result.data) {
						} else {
							$.each(result.data.lessonplan, function (index, item) {
								// console.log("==================================", index)
								if (item.state != 2) {
									var tmp = '';
									if (item.state == 1) {
										tmp = '<td>已提交</td>';
									}
									else {
										tmp = '<td><button type="submit" class="btn btn-primary" onclick="window.open(\'/lessonplan/' + item.id + '/fill\')">填写</button><button type="submit" id="btnSubmit" class="btn btn-primary" >提交</button></td>'
									}
									$('.courseMessage').append('<tr><td>' + item.id + '</td><td>' + item.semester + '</td><td>' + item.coursename + '</td><td>' + item.teachername + '</td><td>' + item.classname + '</td>'+ tmp + '<td><button type="submit" class="btn btn-primary" onclick="window.open(\'' + item.id + '/preview\')")">预览</button></td></tr>')
								}
								
							})
							var t = $('#example1').DataTable({
								"bProcessing": true,
								'paging': true,
								'lengthChange': true,
								'searching': true,
								'ordering': true,
								'info': true,
								'autoWidth': true,

								"bFilter": true, //是否启动过滤、搜索功能  


								"oLanguage": { //国际化配置  
									"sProcessing": "正在获取数据，请稍后...",
									"sLengthMenu": "显示 _MENU_ 条",
									"sZeroRecords": "没有您要搜索的内容",
									"sInfo": "从 _START_ 到  _END_ 条记录 总记录数为 _TOTAL_ 条",
									"sInfoEmpty": "记录数为0",
									"sInfoFiltered": "(全部记录数 _MAX_ 条)",
									"sInfoPostFix": "",
									"sSearch": "搜索",
									"sUrl": "",
									"oPaginate": {
										"sFirst": "第一页",
										"sPrevious": "上一页",
										"sNext": "下一页",
										"sLast": "最后一页"
									}
								},
							});
							t.on('click', 'button#btnSubmit', function () {

								var row = t.row($(this).parents('tr'));
								$.ajax({
									url: '/approval/' + row.data()[0] + '/submit',
									type: 'get',
									data: {},
									dataType: 'json',
									success: function (result) {
										if (result.success) {
											// row.remove().draw(false);
											window.location.href="/lessonplan/my";
										} else {
											L.Common.showTipDialog("提示", result.msg);
										}
									},
									error: function () {
										L.Common.showTipDialog("提示", "删除文章请求发生错误");
									}
								});
								console.log("============", row.data()[0])
								// row.remove().draw(false);
							});
							// console.log("=================sssssss");
						}
					} else {
						$("#topics-body").html('<div class="alert alert-info" role="alert">' + result.msg + '</div>');
					}
				},
			});
		},

		initFillLessonplan: function (lessonplan_id) {
			_this.data.lessonplan_id = lessonplan_id;
			console.log("==================================", lessonplan_id)
			$.ajax({
				url: '/lessonplan/schedule',
				type: 'get',
				cache: false,
				data: {
					lessonplan_id: lessonplan_id,
					week: 1
				},
				dataType: 'json',
				success: function (result) {
					if (result.success) {
						var data = result.data || {};
						var $container = $("#week-body");
						$container.empty();
						// console.log(data);
						var tpl = $("#week-item-tpl").html();
						var html = juicer(tpl, data);
						$container.html(html);

					} else {
						$("#week-body").html(result.msg);
					}
				},
				error: function () {
					$("#week-body").html("请求错误.");
				}
			});
			$("#fill-lesson-btn").click(function () {
				$("#edit-lessonplan").hide();
				$.ajax({
					url: '/lessonplan/fill',
					type: 'post',
					data: {
						lessonplan_id: _this.data.lessonplan_id,
						classname: $("input[name=classname]").val(),
						coursename: $("input[name=coursename]").val(),
						teachername: $("input[name=teachername]").val(),
						syllabus: $("input[name=syllabus]").val(),
						textbook: $("input[name=textbook]").val(),
						remark: $("#remark").val()
					},
					dataType: 'json',
					success: function (result) {
						$("#edit-lessonplan").show();
						$("#edit-lessonplan div div").html("保存成功");
					},
					error: function () {
						$("#edit-lessonplan").show();
						$("#edit-lessonplan div div").html("编辑资料发生错误，请重试");
					}
				});
			});
			console.log("==================================", 2)
			$("#edit-schedule-btn").click(function () {
				$("#edit-schedule-result").hide();
				$.ajax({
					url: '/lessonplan/schedule',
					type: 'post',
					data: {
						lessonplan_id: _this.data.lessonplan_id,
						lecture_period: $("input[name=lecture_period]").val(),
						experiment_period: $("input[name=experiment_period]").val(),
						exercise_period: $("input[name=exercise_period]").val(),
						disscussion_period: $("input[name=disscussion_period]").val(),
						other_period: $("input[name=other_period]").val(),
						week: $("select").eq(0).val(),
						content: $("#content").val()
					},
					dataType: 'json',
					success: function (result) {
						if (result.success) {
							$("#edit-schedule-result").show();
							$("#edit-schedule-result div div").html("保存成功");
						} else {
							$("#edit-schedule-result").show();
							$("#edit-schedule-result div div").html("编辑资料发生错误，请重试");
						}
					},
					error: function () {
						$("#edit-schedule-result").show();
						$("#edit-schedule-result div div").html("编辑资料发生错误，请重试");
					}
				});
			});
			console.log("==================================", 4)
			$("select").eq(0).change(function () {
				$("#edit-schedule-result").hide();
				$.ajax({
					url: '/lessonplan/schedule',
					type: 'get',
					cache: false,
					data: {
						lessonplan_id: lessonplan_id,
						week: $("select").eq(0).val()
					},
					dataType: 'json',
					success: function (result) {
						if (result.success) {
							var data = result.data || {};
							var $container = $("#week-body");
							$container.empty();
							// console.log(data);
							var tpl = $("#week-item-tpl").html();
							var html = juicer(tpl, data);
							$container.html(html);

						} else {
							$("#week-body").html(result.msg);
						}
					},
					error: function () {
						$("#week-body").html("请求错误.");
					}
				});
			});
		},

		initViewMy: function () {
			$.ajax({
				url: '/lessonplan/get_user_all',
				type: 'get',
				data: {
					type: 2
				},
				cache: false,
				dataType: 'json',
				success: function (result) {
					if (result.success) {
						// console.log("==================================success")
						if (!result.data) {
							// $("#topics-body").html('<div class="alert alert-info" role="alert">此分类下没有任何内容</div>');
						} else {
							$.each(result.data.lessonplan, function (index, item) {
								// console.log("==================================", index)
								var strState
								if (item.state == 0) {
									strState = '<font color="red">未提交</font>'
								}
								else if (item.state == 1) {
									strState = '待审核'
								}
								else {
									strState = '已批准'
								}
								$('.courseMessage').append('<tr><td>' + item.id + '</td><td>' + item.semester + '</td><td>' + item.coursename + '</td><td>' + item.teachername + '</td><td>' + item.classname + '</td><td>' + item.start_time + '</td><td>' + item.total_week + '</td><td>' + strState + '</td><td><button type="submit" class="btn btn-primary" onclick="window.open(\'' + item.id + '/preview\')")">预览</button></td></tr>')
							})
							var t = $('#example1').DataTable({
								"bProcessing": true,
								'paging': true,
								'lengthChange': true,
								'searching': true,
								'ordering': true,
								'info': true,
								'autoWidth': true,

								"bFilter": true, //是否启动过滤、搜索功能  


								"oLanguage": { //国际化配置  
									"sProcessing": "正在获取数据，请稍后...",
									"sLengthMenu": "显示 _MENU_ 条",
									"sZeroRecords": "暂时没有教学日历",
									"sInfo": "从 _START_ 到  _END_ 条记录 总记录数为 _TOTAL_ 条",
									"sInfoEmpty": "记录数为0",
									"sInfoFiltered": "(全部记录数 _MAX_ 条)",
									"sInfoPostFix": "",
									"sSearch": "搜索",
									"sUrl": "",
									"oPaginate": {
										"sFirst": "第一页",
										"sPrevious": "上一页",
										"sNext": "下一页",
										"sLast": "最后一页"
									}
								},
							});
							t.on('click', 'button#btnSubmit', function () {
								var row = t.row($(this).parents('tr'));
								$.ajax({
									url: '/approval/' + row.data()[0] + '/submit',
									type: 'get',
									data: {},
									dataType: 'json',
									success: function (result) {
										if (result.success) {
											row.remove().draw(false);
										} else {
											L.Common.showTipDialog("提示", result.msg);
										}
									},
									error: function () {
										L.Common.showTipDialog("提示", "请求发生错误");
									}
								});
								console.log("============", row.data()[0])
							});
						}
					} else {
						$("#topics-body").html('<div class="alert alert-info" role="alert">' + result.msg + '</div>');
					}
				},
				// error : function() {
				//     $("#topics-body").html('<div class="alert alert-info" role="alert">error to send request.</div>');
				// }
			});
		},
	};
}(APP));