{% extends "layout.swig" %}

{% set page = "system" %}

{% block page_header %}
	<link rel="stylesheet" href="/assets/js/daterangepicker/daterangepicker-bs3.css">
	<style>
	</style>
{% endblock %}

{% block page_body %}
	<div class="page-title">
		<div class="title-env">
			<h1 class="title">시스템 일정</h1>
			<p class="description">시스템 전체 일정을 기간에 따라 수정해 주시기 바랍니다.</p>
		</div>
		<div class="breadcrumb-env">
			<ol class="breadcrumb bc-1">
				<li>
					<a href="main"><i class="fa-home"></i>메인</a>
				</li>
				<li class="active">
					<strong>시스템 일정</strong>
				</li>
			</ol>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-12">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">시스템 현재 시간</h3>
				</div>
				<div class="panel-body">
					<h1 style="margin:0px; padding-left:20px; margin-bottom:30px;">
						<small>{{date}} {{['일요일','월요일','화요일','수요일','목요일','금요일','토요일'][day]}} {{time}}</small>
					</h1>
				</div>
				<div class="panel-heading">
					<h3 class="panel-title">시스템 일정 설정</h3>
				</div>
				<div class="panel-body">
					<form role="form" class="form-horizontal" id="system" action="./system" method="post">
					<form role="form" class="form-horizontal" id="system">
						{% for system in systems %}
							<div class="form-group">
								<label class="col-sm-3 control-label">{{system.phase}}</label>
								<div class="col-sm-7">
									<div class="input-group">
										<input type="text" class="form-control daterange" name="{{system.id}}" data-start-date="{{system.start}}" data-end-date="{{system.end}}" value="{{system.start}} - {{system.end}}"/>
										<div class="input-group-addon">
											<a href="#"><i class="linecons-calendar"></i></a>
										</div>
									</div>									
								</div>
								<div class="col-sm-2">
									<button type="button" class="btn btn-info" style="float:right;" onClick="scheduleStart({{system.id}})">즉시실행</button>
								</div>
							</div>
							<div class="form-group-separator"></div>
						{% endfor %}
						<div class="form-group">
							<div class="col-sm-10">
								<h5 class="text-muted">※ 모든 일정 마지막날 23시 59분에 자동 처리 됩니다. 시스템 락은 2월 28일, 8월 31일에 자동 해제 됩니다.</h5>
							</div>
							<div class="col-sm-2">
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
	<script src="/assets/js/moment.min.js"></script>
	<script src="/assets/js/daterangepicker/daterangepicker.js"></script>
	<script src="/assets/js/jquery.form.min.js"></script>	
	<script type="text/javascript">
		jQuery(document).ready(function($) {
			$('.daterange').daterangepicker({
				format: 'YYYY-MM-DD',
			});
			$('form#system').submit(function(e) {
				e.preventDefault();
				// 1차 2차 3차 기간 중복 검사 넣어줘야함
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
	                        	window.location.href = './system';
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
			});
		});
		function scheduleStart(id){
			if(confirm("이 단계의 스케쥴러를 즉시 실행하시겠습니까?")){
				show_loading_bar(70);
				$.post("system/"+id, function( data ) {
					show_loading_bar({
	                    delay: 0.5,
	                    pct: 100,
	                    finish: function() {
                        	if(data.result) alert("실행되었습니다.");
                        	else alert('알 수 없는 오류가 발생하였습니다.');
                        }
	                });
				});
			}
		}
	</script>
{% endblock %}