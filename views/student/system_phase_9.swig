{% extends "layout.swig" %}

{% set page = "system" %}

{% block page_header %}
	<style>
	</style>
{% endblock %}

{% block page_body %}
	<div class="page-title">
		<div class="title-env">
			<h1 class="title">졸업 작품/논문 진행</h1>
			<p class="description">다음 졸업 작품 및 논문 단계를 진행하시기 바랍니다.</p>
		</div>
		<div class="breadcrumb-env">
			<ol class="breadcrumb bc-1">
				<li>
					<a href="main"><i class="fa-home"></i>메인</a>
				</li>
				<li class="active">
					<strong>졸업 작품/논문 진행</strong>
				</li>
			</ol>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-12">
			<div class="panel panel-default">
				<div class="panel-heading">
					<div class="panel-title">
						서약서 및 제안서 제출
					</div>
					
					<small class="text-small pull-right" style="padding-top:5px;">
						제출 기간 : {{system.start}} ~ {{system.end}}
					</small>
				</div>
				<div class="panel-body">
					<form role="form" class="form-horizontal" id="ap" action="system/proc/oath_proposal" method="post" enctype="multipart/form-data">
						<div class="form-group">
							<label class="col-sm-2 control-label">서약서 양식</label>
							<div class="col-sm-10">
								<a href="/assets/sample/졸업작품논문_서약서.hwp" class="btn btn-info" style="margin-bottom:0px;">다운로드</a>
							</div>
						</div>
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">제안서 양식</label>
							<div class="col-sm-10">
								<a href="/assets/sample/졸업작품논문_제안서.hwp" class="btn btn-info" style="margin-bottom:0px;">다운로드</a>
							</div>
						</div>
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">작품/논문 제목</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="title" placeholder="작품 또는 논문의 제목을 입력해주세요." value="{{student.title}}">
							</div>
						</div>
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">작품/논문 여부</label>
							<div class="col-sm-10">
								<label class="radio-inline">
									<input type="radio" name="iswork" value="1" {% if student.iswork %}checked=""{% endif %}>
									작품
								</label>
								<label class="radio-inline">
									<input type="radio" name="iswork" value="0" {% if !student.iswork %}checked=""{% endif %}>
									논문
								</label>
							</div>
						</div>
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">개인/공동 여부</label>
							<div class="col-sm-10">
								<label class="radio-inline">
									<input type="radio" name="isgroup" value="0" {% if !student.isgroup %}checked=""{% endif %}>
									개인
								</label>
								<label class="radio-inline">
									<input type="radio" name="isgroup" value="1" {% if student.isgroup %}checked=""{% endif %}>
									공동
								</label>
							</div>
						</div>
						{% if student.oath %}
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">제출된 서약서</label>
							<div class="col-sm-10" id="oath_file" style="padding-top:7px;">
							</div>
						</div>
						{% endif %}
						<div class="form-group-separator"></div>
						<div class="form-group">								
							<label class="col-sm-2 control-label">서약서 {% if student.oath %}재{% endif %}업로드</label>								
							<div class="col-sm-10">
								<input type="file" class="form-control" name="oath">
							</div>
						</div>
						{% if student.proposal %}
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">제출된 제안서</label>
							<div class="col-sm-10" id="proposal_file" style="padding-top:7px;">
							</div>
						</div>
						{% endif %}
						<div class="form-group-separator"></div>
						<div class="form-group">								
							<label class="col-sm-2 control-label">제안서 {% if student.proposal %}재{% endif %}업로드</label>								
							<div class="col-sm-10">
								<input type="file" class="form-control" name="proposal">
							</div>
						</div>
						<div class="form-group-separator"></div>
						<div class="form-group">
							<div class="col-sm-10">
								<h5 class="text-muted">※ 제출기간 이후에는 수정 삭제가 불가능합니다.</h5>
							</div>
							<div class="col-sm-2">
								<button type="submit" class="btn btn-success" style="float:right;">제출하기</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

{% endblock %}

{% block page_footer %}
	<script src="/assets/js/jquery.form.min.js"></script>	
	<script type="text/javascript">
		jQuery(document).ready(function($) {
			$('form#ap').submit(function(e) {
		        e.preventDefault();
		        if($(this).find("input[name='title']").val()==""){
		        	$(this).find("input[name='title']").focus();
		        }
		        else {
		        	$(this).ajaxSubmit({
		                beforeSubmit: function(arr, $form, options) {
				        	$('button[type="submit"]').attr("disabled", "disabled");
				            show_loading_bar(70);
		                },
		                success: function(data) {
	                        show_loading_bar({
		                        delay: 1,
		                        pct: 100,
		                        finish: function() {
		                        	if(!data.result){
		                        		alert(data.text);
		                        		$('button[type="submit"]').removeAttr("disabled");
		                        	}
		                       		else{
		                       			alert("제출이 완료되었습니다.")
		                       			window.location.href = 'system';	
		                       		}
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

			{% if student.oath %}
				var size_;
				if({{student.oath.size}}>1024*1024) size_=({{student.oath.size}}/1024/1024).toFixed(1)+"M";
				else if({{student.oath.size}}>1024) size_=({{student.oath.size}}/1024).toFixed(1)+"K";
				else {{student.oath.size}}+"byte";
				$("#oath_file").append(
					'<a href="{{student.oath.link}}">'+
						'<span id="title"><i class="fa fa-file-o"></i> &nbsp;<b>{{student.oath.name}}</b> &nbsp;('+size_+')</span>'+
					'</a>'
				);
			{% endif %}
			{% if student.proposal %}
				var size_;
				if({{student.proposal.size}}>1024*1024) size_=({{student.proposal.size}}/1024/1024).toFixed(1)+"M";
				else if({{student.proposal.size}}>1024) size_=({{student.proposal.size}}/1024).toFixed(1)+"K";
				else {{student.proposal.size}}+"byte";
				$("#proposal_file").append(
					'<a href="{{student.proposal.link}}">'+
						'<span id="title"><i class="fa fa-file-o"></i> &nbsp;<b>{{student.proposal.name}}</b> &nbsp;('+size_+')</span>'+
					'</a>'
				);
			{% endif %}
		});
	</script>	
{% endblock %}