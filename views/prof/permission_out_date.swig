{% extends "layout.swig" %}

{% set page = "permission" %}

{% block page_header %}
	<style>
	</style>
{% endblock %}

{% block page_body %}
	<div class="page-title">
		<div class="title-env">
			<h1 class="title">지도 학생 선택</h1>
			<p class="description">지도 희망 학생을 선택하는 페이지 입니다.</p>
		</div>
		<div class="breadcrumb-env">
			<ol class="breadcrumb bc-1">
				<li>
					<a href="main"><i class="fa-home"></i>메인</a>
				</li>
				<li class="active">
					<strong>지도 학생 선택</strong>
				</li>
			</ol>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-12">
			<div class="page-error centered">				
				<div class="error-symbol">
					<i class="fa-warning"></i>
				</div>				
				<h2>
					지도 학생 선택 진행 기간이 아닙니다.
					{% if systems[2].isOver %}
						<small>일정 미확정 상태 입니다. 추후 다시 확인해 주시기 바랍니다.</small>						
					{% else %}
						<small>1차 선택 기간 : {{systems[0].start__}} ~ {{systems[0].end__}}</small>
						<small>2차 선택 기간 : {{systems[1].start__}} ~ {{systems[1].end__}}</small>
						<small>3차 선택 기간 : {{systems[2].start__}} ~ {{systems[2].end__}}</small>
					{% endif %}
				</h2>				
				<p>졸업 작품/논문 시스템 진행 정보 및 관련 문의사항은 좌측 공지사항 또는 질문 및 답변 게시판을 확인해주세요!</p>
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