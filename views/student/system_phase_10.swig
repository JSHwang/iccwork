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
						중간보고서 제출
					</div>
					
					<small class="text-small pull-right" style="padding-top:5px;">
						제출 기간 : {{system.start}} ~ {{system.end}}
					</small>
				</div>
				<div class="panel-body">
					<form role="form" class="form-horizontal" id="ap" action="system/proc/midreport" method="post" enctype="multipart/form-data">
						<div class="form-group">
							<label class="col-sm-2 control-label">중간보고서 양식</label>
							<div class="col-sm-10">
								<a href="/assets/sample/졸업작품논문_중간보고서.hwp" class="btn btn-info" style="margin-bottom:0px;">다운로드</a>
							</div>
						</div>
						{% if student.midreport %}
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">제출된 중간보고서</label>
							<div class="col-sm-10" id="midreport_file" style="padding-top:7px;">
							</div>
						</div>
						{% endif %}
						<div class="form-group-separator"></div>
						<div class="form-group">								
							<label class="col-sm-2 control-label">중간보고서 {% if student.midreport %}재{% endif %}업로드</label>
							<div class="col-sm-10">
								<input type="file" class="form-control" name="midreport">
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
		        if($(this).find("input[type='file']").val()){
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

			{% if student.midreport %}
				var size_;
				if({{student.midreport.size}}>1024*1024) size_=({{student.midreport.size}}/1024/1024).toFixed(1)+"M";
				else if({{student.midreport.size}}>1024) size_=({{student.midreport.size}}/1024).toFixed(1)+"K";
				else {{student.midreport.size}}+"byte";
				$("#midreport_file").append(
					'<a href="{{student.midreport.link}}">'+
						'<span id="title"><i class="fa fa-file-o"></i> &nbsp;<b>{{student.midreport.name}}</b> &nbsp;('+size_+')</span>'+
					'</a>'
				);
			{% endif %}
		});
	</script>	
{% endblock %}