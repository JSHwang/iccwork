{% extends "layout.swig" %}

{% set page = "notice_prof" %}

{% block page_header %}
	<style>
		#name,#time,#views,#title {
			width: 100%;
			display: inline-block;
			padding-top: 7px;
			color: #373e4a;
		}
		#name,#time,#views {
			text-align: center;
		}
		#text {
			overflow-x: hidden;
		}
		.rotate{
		    -ms-transform:rotate(180deg);
		    -moz-transform:rotate(180deg);
		    -webkit-transform:rotate(180deg);
		    transform:rotate(180deg);
		}
	</style>
{% endblock %}

{% block page_body %}
	<div class="page-title">
		<div class="title-env">
			<h1 class="title">공지사항</h1>
			<p class="description">졸업작품시스템 교수 페이지 공지사항 게시판입니다.</p>
		</div>
		<div class="breadcrumb-env">
			<ol class="breadcrumb bc-1">
				<li>
					<a href="main"><i class="fa-home"></i>메인</a>
				</li>
				<li style="color:#979898;">			
					게시판 관리
				</li>
				<li class="active">
					<strong>교수 페이지 공지사항</strong>
				</li>
			</ol>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-12">
			<div class="panel panel-default">
				<div class="panel-body">
					<form role="form" class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label" for="ids">작성자</label>
							<div class="col-sm-5">
								<span id="name"></span>
							</div>
							<label class="col-sm-1 control-label" for="ids">작성</label>
							<div class="col-sm-2">
								<span id="time"></span>
							</div>
							<label class="col-sm-1 control-label" for="ids">조회</label>
							<div class="col-sm-1">
								<span id="views"></span>
							</div>
						</div>
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label" for="ids">제목</label>
							<div class="col-sm-10">
								<span id="title"></span>
							</div>
						</div>
						<div class="form-group-separator"></div>
						<div class="form-group" style="padding-left:15px;padding-right:15px;">
							<div id="text"></div>
						</div>
						<div class="form-group-separator"></div>
						<div id="files">
						</div>
						<div class="form-group">
							<div class="col-sm-4">
								<a class="btn btn-primary" id="prev">이전글</a>
								<a class="btn btn-primary" id="next">다음글</a>
							</div>
							<div class="col-sm-8" style="text-align:right;">
								<a class="btn btn-white" id="modify" href="../modify/{{id}}">수정</a>
								<a class="btn btn-white" id="delete">삭제</a>
								<a class="btn btn-white" id="reply">답변</a>
								<a class="btn btn-white" href="../list">목록</a>
								<a class="btn btn-success" href="../write">글쓰기</a>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
{% endblock %}

{% block page_footer %}
	<script type="text/javascript">
		jQuery(document).ready(function($) {
			$.post( "/iccsys/ajax/board/view/work_prof_notice/{{id}}", function( data ) {
				if(data.result){
					$("#name").text(data.post.name);
					$("#time").text(data.post.time);
					$("#views").text(data.post.views);
					$("#title").html((data.post.notice?"[공지] ":(data.post.ParentId?"<i class='fa fa-reply rotate'></i> ":""))+data.post.title+(data.post.secret?" <i class='fa fa-lock'></i>":""));
					$("#text").html(data.post.text);
					for(var index in data.post.files){
						var size_;
						if(data.post.files[index].size>1024*1024) size_=(data.post.files[index].size/1024/1024).toFixed(1)+"M";
						else if(data.post.files[index].size>1024) size_=(data.post.files[index].size/1024).toFixed(1)+"K";
						else size_+"byte";
						$("#files").append(
							'<div class="form-group">'+
								'<label class="col-sm-2 control-label">첨부 파일 '+(parseInt(index)+1)+'</label>'+
								'<div class="col-sm-10">'+
									'<a href="'+data.post.files[index].link+'">'+
										'<span id="title"><i class="fa fa-file-o"></i> &nbsp;<b>'+data.post.files[index].name+'</b> &nbsp;('+size_+') &nbsp;'+data.post.files[index].downs+'회</span>'+
									'</a>'+
								'</div>'+
							'</div>'
						);
					}
					if(data.prev==null) $("#prev").attr("disabled",true);
					else $("#prev").attr("href","../view/"+data.prev.id);
					if(data.next==null) $("#next").attr("disabled",true);
					else $("#next").attr("href","../view/"+data.next.id);
					if(data.post.UserId!={{session().user.id}}&&{{session().user.type}}!=0) $("#modify, #delete").hide();
					if(data.post.notice) $("#reply").hide();
					//if(data.post.notice||data.post.ParentId) $("#reply").hide();
					$("#reply").attr("href","../reply/"+(data.post.ParentId?data.post.ParentId:data.post.id));
				}
				else{
					alert(data.text);
					window.history.back();
				}
			}).fail(function(){
				alert("존재하지 않는 글 입니다.");
				window.history.back();
			});
			$("#delete").click(function(){
				if(confirm("정말 삭제하시겠습니까?")){
					$.post( "/iccsys/ajax/board/delete/work_prof_notice/{{id}}", function( data ) {
						if(data.result){
							window.location.href = '../list';
						}
						else{
							alert(data.text);
						}
					}).fail(function(){
						alert("서버의 응답이 없습니다.");
					});
				}
			});
		});
	</script>
{% endblock %}