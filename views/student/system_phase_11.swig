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
						최종보고서 및 논문/작품, 발표자료 제출
					</div>
					
					<small class="text-small pull-right" style="padding-top:5px;">
						제출 기간 : {{system.start}} ~ {{system.end}}
					</small>
				</div>
				<div class="panel-body">
					<form role="form" class="form-horizontal" id="ap" action="system/proc/final_etc" method="post" enctype="multipart/form-data">
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
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">최종보고서 양식</label>
							<div class="col-sm-10">
								<a href="/assets/sample/졸업작품논문_최종보고서.hwp" class="btn btn-info" style="margin-bottom:0px;">다운로드</a>
							</div>
						</div>
						{% if student.finalreport %}
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">제출된 최종보고서</label>
							<div class="col-sm-10" id="finalreport_file" style="padding-top:7px;">
							</div>
						</div>
						{% endif %}
						<div class="form-group-separator"></div>
						<div class="form-group">								
							<label class="col-sm-2 control-label">최종보고서 {% if student.finalreport %}재{% endif %}업로드</label>
							<div class="col-sm-10">
								<input type="file" class="form-control" name="finalreport">
							</div>
						</div>
						{% if student.paperwork %}
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">제출된 논문/작품</label>
							<div class="col-sm-10" id="paperwork_file" style="padding-top:7px;">
							</div>
						</div>
						{% endif %}
						<div class="form-group-separator"></div>
						<div class="form-group">								
							<label class="col-sm-2 control-label">논문/작품 {% if student.paperwork %}재{% endif %}업로드</label>
							<div class="col-sm-10">
								<input type="file" class="form-control" name="paperwork">
							</div>
						</div>
						{% if student.presentation %}
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">제출된 발표자료</label>
							<div class="col-sm-10" id="presentation_file" style="padding-top:7px;">
							</div>
						</div>
						{% endif %}
						<div class="form-group-separator"></div>
						<div class="form-group">								
							<label class="col-sm-2 control-label">교내 발표자료 {% if student.presentation %}재{% endif %}업로드</label>
							<div class="col-sm-10">
								<input type="file" class="form-control" name="presentation">
							</div>
						</div>
						{% if student.conference %}
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">학회 발표증빙자료</label>
							<div class="col-sm-10" id="conference_file" style="padding-top:7px;">
							</div>
						</div>
						{% endif %}
						<div class="form-group-separator"></div>
						<div class="form-group">								
							<label class="col-sm-2 control-label">학회 발표증빙자료 {% if student.conference %}재{% endif %}업로드</label>
							<div class="col-sm-10">
								<input type="file" class="form-control" name="conference">
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
		        var flag = false;
		        if($("input[name='iswork']:checked").val()==1){
		        	{% if student.finalreport && student.presentation %}
		        		flag = true;
		        	{% else %}
		        		if($(this).find("input[type='file']:eq(0)").val()!="" && $(this).find("input[type='file']:eq(2)").val()!=""){
		        			flag = true;
		        		}
		        		else{
		        			alert("작품의 경우 '최종보고서' 및 '교내 발표자료' 를 꼭 업로드 해야합니다.");
		        		}
		        	{% endif %}
		        }
		        else{
		        	{% if student.finalreport && student.presentation && student.conference %}
		        		flag = true;
		        	{% else %}
		        		if($(this).find("input[type='file']:eq(0)").val()!="" && $(this).find("input[type='file']:eq(2)").val()!="" && $(this).find("input[type='file']:eq(3)").val()!="" ){
		        			flag = true;
		        		}
		        		else{
		        			alert("논문의 경우 '최종보고서' 및 '교내 발표자료', '학회 발표증빙자료' 를 꼭 업로드 해야합니다.");
		        		}
		        	{% endif %}
		        }

		        if(flag){
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

			{% if student.finalreport %}
				var size_;
				if({{student.finalreport.size}}>1024*1024) size_=({{student.finalreport.size}}/1024/1024).toFixed(1)+"M";
				else if({{student.finalreport.size}}>1024) size_=({{student.finalreport.size}}/1024).toFixed(1)+"K";
				else {{student.finalreport.size}}+"byte";
				$("#finalreport_file").append(
					'<a href="{{student.finalreport.link}}">'+
						'<span id="title"><i class="fa fa-file-o"></i> &nbsp;<b>{{student.finalreport.name}}</b> &nbsp;('+size_+')</span>'+
					'</a>'
				);
			{% endif %}
			{% if student.paperwork %}
				var size_;
				if({{student.paperwork.size}}>1024*1024) size_=({{student.paperwork.size}}/1024/1024).toFixed(1)+"M";
				else if({{student.paperwork.size}}>1024) size_=({{student.paperwork.size}}/1024).toFixed(1)+"K";
				else {{student.paperwork.size}}+"byte";
				$("#paperwork_file").append(
					'<a href="{{student.paperwork.link}}">'+
						'<span id="title"><i class="fa fa-file-o"></i> &nbsp;<b>{{student.paperwork.name}}</b> &nbsp;('+size_+')</span>'+
					'</a>'
				);
			{% endif %}
			{% if student.presentation %}
				var size_;
				if({{student.presentation.size}}>1024*1024) size_=({{student.presentation.size}}/1024/1024).toFixed(1)+"M";
				else if({{student.presentation.size}}>1024) size_=({{student.presentation.size}}/1024).toFixed(1)+"K";
				else {{student.presentation.size}}+"byte";
				$("#presentation_file").append(
					'<a href="{{student.presentation.link}}">'+
						'<span id="title"><i class="fa fa-file-o"></i> &nbsp;<b>{{student.presentation.name}}</b> &nbsp;('+size_+')</span>'+
					'</a>'
				);
			{% endif %}
			{% if student.conference %}
				var size_;
				if({{student.conference.size}}>1024*1024) size_=({{student.conference.size}}/1024/1024).toFixed(1)+"M";
				else if({{student.conference.size}}>1024) size_=({{student.conference.size}}/1024).toFixed(1)+"K";
				else {{student.conference.size}}+"byte";
				$("#conference_file").append(
					'<a href="{{student.conference.link}}">'+
						'<span id="title"><i class="fa fa-file-o"></i> &nbsp;<b>{{student.conference.name}}</b> &nbsp;('+size_+')</span>'+
					'</a>'
				);
			{% endif %}
		});
	</script>	
{% endblock %}