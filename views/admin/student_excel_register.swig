{% extends "layout.swig" %}

{% set page = "student_excel_register" %}

{% block page_header %}
	<style>
	</style>
{% endblock %}

{% block page_body %}
	<div class="page-title">
		<div class="title-env">
			<h1 class="title">학생 일괄 등록</h1>
			<p class="description">기본 양식 엑셀파일을 다운받아 작성후 업로드해주시기 바랍니다.</p>
		</div>
		<div class="breadcrumb-env">
			<ol class="breadcrumb bc-1">
				<li>
					<a href="main"><i class="fa-home"></i>메인</a>
				</li>
				<li style="color:#979898;">			
					학생 관리
				</li>
				<li class="active">
					<strong>학생 일괄 등록</strong>
				</li>
			</ol>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-12">
			<div class="panel panel-default">
				<div class="panel-body">
					<form role="form" class="form-horizontal" id="excel_register" action="./student_excel_register" method="post" enctype="multipart/form-data">
						<div class="form-group">
							<div class="col-sm-12">
								<p class="bg-info"><i class="fa fa-check"></i> 첨부파일 우측 상단의 안내사항을 참고하시기 바랍니다.</p>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">엑셀 양식</label>
							<div class="col-sm-10">
								<a href="/assets/sample/졸업작품시스템_학생_일괄등록_양식.xlsx" class="btn btn-info" style="margin-bottom:0px;">다운로드</a>
							</div>
						</div>
						<div class="form-group-separator"></div>						
						<div class="form-group">
							<label class="col-sm-2 control-label">엑셀 파일 선택</label>
							<div class="col-sm-10">
								<input type="file" class="form-control" name="file">
							</div>
						</div>
						<div class="form-group-separator"></div>
						<div class="form-group">
							<div class="col-sm-10">
								<h5 class="text-muted">※ 이미 등록된 중복 아이디의 경우 데이터가 수정됩니다.</h5>
							</div>
							<div class="col-sm-2">
								<button type="submit" class="btn btn-success" style="float:right;">등록하기</button>
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
			$('form#excel_register').submit(function(e) {
		        e.preventDefault();
		        if($(this).find("input[type='file']").val()){

		        	$(this).ajaxSubmit({
		                beforeSubmit: function(arr, $form, options) {
				        	$('button[type="submit"]').attr("disabled", "disabled");
	                        show_loading_bar({
		                        delay: 5,
		                        pct: 70
		                    });
		                },
		                success: function(data) {
	                        show_loading_bar({
		                        delay: 1,
		                        pct: 100,
		                        finish: function() {
		                        	alert(data.text+"\n학생 현황 페이지로 이동합니다.");
		                        	window.location.href = './student_list';
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
		});
	</script>
{% endblock %}