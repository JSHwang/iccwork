{% extends "layout.swig" %}

{% set page = "qna" %}

{% block page_header %}
	<style>
		.text-gray {
			margin-top: 0px;
		}
		#files .form-group .col-sm-10 {
			padding-top: 7px;
		}
		#files .form-group .col-sm-10 input{
			margin-top: -7px;
		}
	</style>
{% endblock %}

{% block page_body %}
	<div class="page-title">
		<div class="title-env">
			<h1 class="title">질문 및 답변</h1>
			<p class="description">교수 또는 학생의 질문 및 답변 게시판 입니다.</p>
		</div>
		<div class="breadcrumb-env">
			<ol class="breadcrumb bc-1" >
				<li>
					<a href="main"><i class="fa-home"></i>메인</a>
				</li>
				<li class="active">
					<strong>질문 및 답변</strong>
				</li>
			</ol>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-12">
			<div class="panel panel-default">
				<div class="panel-body">
					<form role="form" class="form-horizontal" id="qna" action="/iccsys/ajax/board/modify/work_qna/{{id}}" method="post" enctype="multipart/form-data">
						<div class="form-group">
							<label class="col-sm-2 control-label" for="ids">작성자</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" name="name" value="" disabled>
							</div>
							<label class="col-sm-2 control-label" for="ids">비밀글</label>
							<div class="col-sm-1">
								<input type="checkbox" style="margin-top: 9px;" name="secret">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label" for="ids">제목</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="title" placeholder="제목을 입력해주세요.">
							</div>
						</div>
						<div class="form-group" style="padding-left:15px;padding-right:15px;">
							<textarea name="text" class="form-control editor_prof" rows="25">
							</textarea>
						</div>
						<div id="files">
							<div class="form-group">
								<label class="col-sm-2 control-label">첨부 파일 1</label>
								<div class="col-sm-10">
									<input type="file" class="form-control" name="file_1">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">첨부 파일 2</label>
								<div class="col-sm-10">
									<input type="file" class="form-control" name="file_2">
								</div>
							</div>							
						</div>
						<div class="form-group">
							<div class="col-sm-9">
								<h5 class="text-muted">※ 에디터 상단 [링크]와 [사진] 메뉴를 통해서 이미지 및 파일 업로드도 가능합니다.</h5>
							</div>
							<div class="col-sm-3" style="text-align:right;">
								<a class="btn btn-white" href="../list">목록</a>
								<button type="submit" class="btn btn-success">수정하기</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
{% endblock %}

{% block page_footer %}
	<script src="/assets/js/ckeditor/ckeditor.js"></script>
	<script src="/assets/js/ckeditor/adapters/jquery.js"></script>
	<script src="/assets/js/jquery.form.min.js"></script>
	<script type="text/javascript">
		jQuery(document).ready(function($) {
			$.post( "/iccsys/ajax/board/view/work_qna/{{id}}", function( data ) {
				if(data.result){
					$("form input[name='name']").val(data.post.name);
					$("form input[name='title']").val(data.post.title);
					$("form textarea[name='text']").html(data.post.text);
					$("form input[name='title']").focus();
					if(data.post.secret) $("form input[name='secret']").click();


					for(var index in data.post.files){
						var size_;
						if(data.post.files[index].size>1024*1024) size_=(data.post.files[index].size/1024/1024).toFixed(1)+"M";
						else if(data.post.files[index].size>1024) size_=(data.post.files[index].size/1024).toFixed(1)+"K";
						else size_+"byte";
						$("#files .form-group .col-sm-10").eq(index).html(
							'<a href="'+data.post.files[index].link+'">'+
								'<span id="title"><i class="fa fa-file-o"></i> &nbsp;<b>'+data.post.files[index].name+'</b> &nbsp;('+size_+') &nbsp;'+data.post.files[index].downs+'회</span>'+
							'</a> &nbsp;'+
							'<button type="button" class="btn btn-danger btn-xs" style="margin:0px;" onClick="delete_file(this,\''+data.post.files[index].link.split("/").reverse()[0]+'\','+(parseInt(index)+1)+')">삭제하기</button>'
						);
					}
				}
				else{
					alert(data.text);
					window.history.back();
				}
			}).fail(function(){
				alert("존재하지 않는 글 입니다.");
				window.history.back();
			}).always(function() {
				$(".editor_prof").ckeditor({
					filebrowserUploadUrl: '/iccsys/ajax/board/upload/work_qna'
				});
  			});			

			$('form#qna').submit(function(e) {
		        e.preventDefault();
	            if ($("form input[name='title']").val() === "") {
			        $("form input[name='title']").focus();
		        }
		        else {
					$(this).ajaxSubmit({
		                beforeSubmit: function(arr, $form, options) {
				        	$('form button[type="submit"]').attr("disabled", "disabled");
				            show_loading_bar(70);
		                },
		                success: function(data) {
	                        show_loading_bar({
		                        delay: 1,
		                        pct: 100,
		                        finish: function() {
		                        	if(!data.result) alert(data.text);
			                       	else window.location.href = '../view/{{id}}';
		                        }
		                    });
		                },
		                error: function(data) {
							show_loading_bar({
		                        delay: 1,
		                        pct: 100,
		                        finish: function() {
		                        	alert("에러가 발생하였습니다. 시스템 관리자에게 문의해주세요.");
		                        }
		                    });
		                }
		            });
		        }
		    });
			$("form input[name='title']").focus();
		});
		function delete_file(ele,file_name,index){
			if(confirm("정말 삭제하시겠습니까?")){
				$.post( "/iccsys/ajax/board/file/delete/work_qna/"+file_name, function( data ) {
					if(data.result){
						$(ele).parent().html('<input type="file" class="form-control" name="file_'+index+'">');
						alert("삭제되었습니다.");
					}
					else{
						alert(data.text);
					}
				}).fail(function(){
					alert("서버 응답이 없거나 잘못된 요청입니다.");
				});
			}
		}
	</script>
{% endblock %}