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
			<div class="page-error centered">				
				<div class="error-symbol">
					<i class="fa-graduation-cap"></i>
				</div>				
				<h2>
					논문/작품 심사는 {{user.Student.System.end}} 까지 진행됩니다.
					<small>심사기간 이후 메인페이지에서 결과를 확인할 수 있습니다.</small>
				</h2>				
				<p>졸업 작품/논문 시스템 진행 정보 및 관련 문의사항은 좌측 공지사항 또는 질문 및 답변 게시판을 확인해주세요.</p>
			</div>
		</div>
	</div>
{% endblock %}

{% block page_footer %}
	<script type="text/javascript">
		jQuery(document).ready(function($) {
		});
	</script>
{% endblock %}