{% extends "layout.swig" %}

{% set page = "main" %}

{% block page_header %}
	<link rel="stylesheet" href="/assets/js/fullcalendar/fullcalendar.min.css">
	<style>
		.xe-widget.xe-progress-counter.xe-progress-counter-blue {
		    background-color: #0e62c7
		}
		.xe-widget.xe-progress-counter.xe-progress-counter-blue .xe-background {
		    color: #fff
		}
		.xe-widget.xe-progress-counter.xe-progress-counter-blue .xe-upper {
		    background-color: transparent
		}
		.xe-widget.xe-progress-counter .except {
			font-size: 100px;
			left: -12%;
			top: 25%;
		}
		.xe-widget.xe-progress-counter .except2 {
			font-size: 100px;
			left: -18%;
			top: 25%;
		}
		.calendar-env {
			margin-bottom: 20px;
		}		
		.calendar-main {
			padding: 0px !important;
		}
	</style>
{% endblock %}

{% block page_body %}
	<div class="page-title">
		<div class="title-env">
			<h1 class="title">졸업 작품/논문 시스템에 접속하신걸 환영합니다!</h1>
			<p class="description">시스템을 통해 지도 학생 선택 및 배정 학생의 작품/논문을 관리하실수 있습니다.</p>
		</div>
		<div class="breadcrumb-env">
			<ol class="breadcrumb bc-1">
				<li class="active">
					<a href="main"><i class="fa-home"></i>메인</a>
				</li>
			</ol>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-6">
			<div class="row">
				<div class="col-sm-6">
					<a href="student_list">
						<div class="xe-widget xe-progress-counter xe-progress-counter-pink " data-count=".num" data-from="0" data-to="{{users.length}}" data-duration="2">
							<div class="xe-background">
								<i class="el-group"></i>
							</div>				
							<div class="xe-upper">
								<div class="xe-icon">
									<i class="el-group"></i>
								</div>
								<div class="xe-label">
									<span>졸업 작품/논문 지도 학생</span>
									<strong class="num">0</strong>명
								</div>
							</div>				
							<div class="xe-progress">
								<span class="xe-progress-fill"  data-fill-from="0" data-fill-to="{{systems[12].userCnt/users.length*100}}" data-fill-unit="%" data-fill-property="width" data-fill-duration="2" data-fill-easing="true"></span>
							</div>
							
							<div class="xe-lower">
								<span>작품/논문 진행 학생 : {{users.length-systems[12].userCnt}} 명</span>
								<strong>작품/논문 수료 학생 : {{systems[12].userCnt}} 명</strong>
							</div>				
						</div>
					</a>
				</div>
				<div class="col-sm-6">
					<a href="student_list">
						<div class="xe-widget xe-progress-counter xe-progress-counter-warning" data-count=".num" data-from="0" data-to="{{systems[1].userCnt}}" data-duration="2">
							<div class="xe-background except2">
								<i class="el-pencil"></i>
							</div>				
							<div class="xe-upper">
								<div class="xe-icon">
									<i class="el-pencil"></i>
								</div>
								<div class="xe-label">
									<span>신청서 제출 단계 학생</span>
									<strong class="num">0</strong>명
								</div>
							</div>				
							<div class="xe-progress">
								<span class="xe-progress-fill"  data-fill-from="0" data-fill-to="{{systems[1].userCmpCnt/systems[1].userCnt*100}}" data-fill-unit="%" data-fill-property="width" data-fill-duration="2" data-fill-easing="true"></span>
							</div>
							
							<div class="xe-lower">
								<span>제출 미완료 학생 : {{systems[1].userCnt-systems[1].userCmpCnt}} 명</span>
								<strong>제출 완료 학생 : {{systems[1].userCmpCnt}} 명</strong>
							</div>				
						</div>
					</a>
				</div>
				<div class="col-sm-6">
					<a href="student_list">
						<div class="xe-widget xe-progress-counter xe-progress-counter-secondary" data-count=".num" data-from="0" data-to="{{systems[8].userCnt}}" data-duration="2">
							<div class="xe-background except">
								<i class="fa-files-o"></i>
							</div>				
							<div class="xe-upper">
								<div class="xe-icon">
									<i class="fa-files-o"></i>
								</div>
								<div class="xe-label">
									<span>서약서 및 제안서 제출 단계 학생</span>
									<strong class="num">0</strong>명
								</div>
							</div>				
							<div class="xe-progress">
								<span class="xe-progress-fill"  data-fill-from="0" data-fill-to="{{systems[8].userCmpCnt/systems[8].userCnt*100}}" data-fill-unit="%" data-fill-property="width" data-fill-duration="2" data-fill-easing="true"></span>
							</div>
							
							<div class="xe-lower">
								<span>제출 미완료 학생 : {{systems[8].userCnt-systems[8].userCmpCnt}} 명</span>
								<strong>제출 완료 학생 : {{systems[8].userCmpCnt}} 명</strong>
							</div>				
						</div>
					</a>
				</div>
				<div class="col-sm-6">
					<a href="student_list">
						<div class="xe-widget xe-progress-counter xe-progress-counter-info" data-count=".num" data-from="0" data-to="{{systems[9].userCnt}}" data-duration="2">
							<div class="xe-background except">
								<i class="fa-file-o"></i>
							</div>				
							<div class="xe-upper">
								<div class="xe-icon">
									<i class="fa-file-o"></i>
								</div>
								<div class="xe-label">
									<span>중간보고서 제출 단계 학생</span>
									<strong class="num">0</strong>명
								</div>
							</div>				
							<div class="xe-progress">
								<span class="xe-progress-fill"  data-fill-from="0" data-fill-to="{{systems[9].userCmpCnt/systems[9].userCnt*100}}" data-fill-unit="%" data-fill-property="width" data-fill-duration="2" data-fill-easing="true"></span>
							</div>
							
							<div class="xe-lower">
								<span>제출 미완료 학생 : {{systems[9].userCnt-systems[9].userCmpCnt}} 명</span>
								<strong>제출 완료 학생 : {{systems[9].userCmpCnt}} 명</strong>
							</div>				
						</div>
					</a>
				</div>
				<div class="col-sm-6">
					<a href="student_list">
						<div class="xe-widget xe-progress-counter xe-progress-counter-blue" data-count=".num" data-from="0" data-to="{{systems[10].userCnt}}" data-duration="2">
							<div class="xe-background except">
								<i class="fa-file-text-o"></i>
							</div>				
							<div class="xe-upper">
								<div class="xe-icon">
									<i class="fa-file-text-o"></i>
								</div>
								<div class="xe-label">
									<span>최종자료 제출 단계 학생</span>
									<strong class="num">0</strong>명
								</div>
							</div>				
							<div class="xe-progress">
								<span class="xe-progress-fill"  data-fill-from="0" data-fill-to="{{systems[10].userCmpCnt/systems[10].userCnt*100}}" data-fill-unit="%" data-fill-property="width" data-fill-duration="2" data-fill-easing="true"></span>
							</div>
							
							<div class="xe-lower">
								<span>제출 미완료 학생 : {{systems[10].userCnt-systems[10].userCmpCnt}} 명</span>
								<strong>제출 완료 학생 : {{systems[10].userCmpCnt}} 명</strong>
							</div>				
						</div>
					</a>
				</div>
				<div class="col-sm-6">
					<a href="examine">
						<div class="xe-widget xe-progress-counter xe-progress-counter-purple" data-count=".num" data-from="0" data-to="{{systems[11].userCnt}}" data-duration="2">
							<div class="xe-background except2">
								<i class="fa-graduation-cap"></i>
							</div>				
							<div class="xe-upper">
								<div class="xe-icon">
									<i class="fa-graduation-cap"></i>
								</div>
								<div class="xe-label">
									<span>작품/논문 심사 단계 학생</span>
									<strong class="num">0</strong>명
								</div>
							</div>				
							<div class="xe-progress">
								<span class="xe-progress-fill"  data-fill-from="0" data-fill-to="{{systems[11].userCmpCnt/systems[11].userCnt*100}}" data-fill-unit="%" data-fill-property="width" data-fill-duration="2" data-fill-easing="true"></span>
							</div>
							
							<div class="xe-lower">
								<span>심사 미완료 학생 : {{systems[11].userCnt-systems[11].userCmpCnt}} 명</span>
								<strong>심사 완료 학생 : {{systems[11].userCmpCnt}} 명</strong>
							</div>				
						</div>
					</a>
				</div>
			</div>
		</div>
		<div class="col-sm-6">
			<div class="panel panel-default calendar-env">
				<div class="panel-heading">
					<strong>졸업 작품/논문 시스템 일정</strong>
				</div>
				<div class="panel-body calendar-right">
					<div class="calendar-main">				
						<div id="calendar"></div>				
					</div>			
				</div>
			</div>
		</div>
	</div>
{% endblock %}

{% block page_footer %}
	<script src="/assets/js/moment.min.js"></script>
	<script src="/assets/js/fullcalendar/fullcalendar.min.js"></script>
	<script src="/assets/js/xenon-widgets.js"></script>
	<script type="text/javascript">
		jQuery(document).ready(function($) {
			calendar = $('#calendar').fullCalendar({
				header: {
					left: 'title',
					center: '',
					right: 'prev,next'
				},
				buttonIcons: {
					prev: 'prev fa-angle-left',
					next: 'next fa-angle-right',
				},
				selectable: true,
				eventLimit: true,				
				events: [
					{% for system in systems %}
						{% if system.id!=1 && system.id!=13 %}
							{
								title: "{{system.phase}}",
								start: "{{system.start_}}",
								end: "{{system.end_}}"
							},
						{% endif %}
					{% endfor %}			        
			    ]
			});
			$(window).trigger('xenon.resized');
		});
	</script>
{% endblock %}