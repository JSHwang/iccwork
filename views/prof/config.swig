{% extends "layout.swig" %}

{% set page = "config" %}

{% block page_header %}
	<style>
	</style>
{% endblock %}

{% block page_body %}
	<div class="page-title">
		<div class="title-env">
			<h1 class="title">회원정보 수정</h1>
			<p class="description">교수님의 개인 정보를 수정하는 페이지입니다.</p>
		</div>
		<div class="breadcrumb-env">
			<ol class="breadcrumb bc-1">
				<li>
					<a href="main"><i class="fa-home"></i>메인</a>
				</li>
				<li class="active">
					<strong>회원정보 수정</strong>
				</li>
			</ol>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-12">
			<div class="panel panel-default">
				<div class="panel-body">
					<form role="form" class="form-horizontal" id="update" action="config" method="post">
						<div class="form-group">
							<label class="col-sm-2 control-label">아이디</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" placeholder="{{user.ids}}" readonly>
							</div>
						</div>
						<div class="form-group-separator"></div>						
						<div class="form-group">
							<label class="col-sm-2 control-label">비밀번호</label>
							<div class="col-sm-10">
								<input type="password" class="form-control" name="password" placeholder="(비밀번호 변경일 경우 입력)">
							</div>
						</div>
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">이름</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" placeholder="{{user.name}}" readonly>
							</div>
						</div>
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">이메일</label>
							<div class="col-sm-10">
								<input type="email" class="form-control" name="email" value="{{user.email}}">
							</div>
						</div>
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">연락처</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="phone" value="{{user.phone}}">
							</div>
						</div>
						<div class="form-group-separator"></div>
						<div class="form-group">
							<div class="col-sm-12">
								<button type="submit" class="btn btn-success" style="float:right;">수정하기</button>
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
			$('form#update').submit(function(e) {
				e.preventDefault();
		        var flag = true;
				$(this).find("[name='email'],[name='phone']").each(function(index) {
		            if ($(this).val() === "") {
		                $(this).focus();
		                $(this).parent().parent().addClass('has-warning');
		                flag=false;
		            }
		        });
		        if(flag&&confirm("정말 수정하시겠습니까?")){
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
			                       	else window.location.href = './config';
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