{% extends "../../layout.swig" %}

{% block page_body_menu %}
	<div class="sidebar-menu-inner">
		<header class="logo-env">
			<div class="logo">
				<a href="/iccsys/work/prof/main" class="logo-expanded">
					<img src="/assets/img/logo/logo_main.png" alt="SKKU ICC Iccsys" />
				</a>
				<a href="/iccsys/work/prof/main" class="logo-collapsed">
					<img src="/assets/img/logo/logo_main_small.png" alt="SKKU ICC Iccsys" />
				</a>
			</div>
			<div class="mobile-menu-toggle visible-xs">
				<a href="#" data-toggle="mobile-menu">
					<i class="fa-bars"></i>
				</a>
			</div>
		</header>
				
		<ul id="main-menu" class="main-menu">
			<li {% if page=="main" %} class="active" {% endif %}>
				<a href="/iccsys/work/prof/main">
					<i class="fa fa-home"></i>
					<span class="title">메인</span>
				</a>
			</li>
			<li {% if page=="notice" %} class="active" {% endif %}>
				<a href="/iccsys/work/prof/notice">
					<i class="fa fa-star"></i>
					<span class="title">공지사항</span>
				</a>
			</li>
			<li {% if page=="permission" %} class="active" {% endif %}>
				<a href="/iccsys/work/prof/permission">
					<i class="fa fa-user"></i>
					<span class="title">지도 학생 선택</span>
				</a>
			</li>
			<li {% if page=="student" %} class="active" {% endif %}>
				<a href="/iccsys/work/prof/student_list">
					<i class="fa fa-users"></i>
					<span class="title">지도 학생 관리</span>
				</a>
			</li>
			<li {% if page=="examine" %} class="active" {% endif %}>
				<a href="/iccsys/work/prof/examine">
					<i class="fa fa-graduation-cap"></i>
					<span class="title">작품/논문 심사</span>
				</a>
			</li>
			<li {% if page=="qna" %} class="active" {% endif %}>
				<a href="/iccsys/work/prof/qna/list">
					<i class="fa fa-envelope"></i>
					<span class="title">질문 및 답변</span>
				</a>
			</li>
			<li {% if page=="config" %} class="active" {% endif %}>
				<a href="/iccsys/work/prof/config">
					<i class="fa fa-wrench"></i>
					<span class="title">회원정보 수정</span>
				</a>
			</li>
		</ul>
	</div>
{% endblock %}


{% block page_body_footer %}
	<style>
		.main-footer .tooltip, .main-footer .tooltip-inner {
		    min-width: 270px !important;
		}
	</style>
	<footer class="main-footer sticky footer-type-1">
		<div class="footer-inner">
			<div class="footer-text">
				© Copyright 2015 성균관대학교 자연과학캠퍼스 정보통신대학 <strong><a href="http://scg.skku.ac.kr" class="tooltip-primary" data-toggle="tooltip" data-placement="top" title="" data-original-title="컴퓨터공학과 10학번 강성현(PM), 황준성 제작">시스템컨설턴트그룹</a></strong>. All Rights Reserved.
			</div>
		</div>
	</footer>
{% endblock %}


