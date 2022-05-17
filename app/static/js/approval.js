(function (L) {
    var _this = null;
    L.Approval = L.Approval || {};
    _this = L.Approval = {
        data: {
        	Approval_id:0,
        },
 
        initView: function () {
        	_this.loadLessonplan();
    
        },
		loadLessonplan: function(){
        	$.ajax({
	            url : '/lessonplan/get_all',
	            type : 'get',
				data : {
					type: 1
				},
	            cache: false,
	            dataType : 'json',
	            success : function(result) {
	                if(result.success){
						console.log("==================================success")
	                	if(!result.data){
	                	}else{
							$.each(result.data.lessonplan, function(index,item) {
								console.log("==================================", index)
								$('.courseMessage').append('<tr><td>' + item.id + '</td><td>'+item.semester+'</td><td>'+item.coursename+'</td><td>'+item.teachername+'</td><td>'+item.classname+'</td><td>'+item.start_time+'</td><td>'+item.total_week+'</td><td>'+'<button type="submit" class="btn btn-primary" id="btnAllow">批准</button><button id="btnRefuse" class="btn btn-danger" >打回</button></td><td>'+'<button type="submit" class="btn btn-primary" onclick="window.open(\'/lessonplan/'+item.id+'/preview\')")">预览</button></td></tr>')
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
							t.on('click', 'button#btnAllow', function () {
								
								var row = t.row($(this).parents('tr'));
								$.ajax({
									url : '/approval/'+row.data()[0]+'/allow',
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
							});
							t.on('click', 'button#btnRefuse', function () {
								
								var row = t.row($(this).parents('tr'));
								$.ajax({
									url : '/approval/'+row.data()[0]+'/refuse',
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
								// console.log("============",row.data()[0])
								// row.remove().draw(false);
							});
	                	}
	                }else{
	                    $("#topics-body").html('<div class="alert alert-info" role="alert">'+result.msg+'</div>');
	                }
	            },
	        });
        },

 
    };
}(APP));