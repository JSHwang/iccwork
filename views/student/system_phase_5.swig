{% extends "layout.swig" %}

{% set page = "system" %}

{% block page_header %}
	<link rel="stylesheet" href="/assets/js/select2/select2.css">
	<link rel="stylesheet" href="/assets/js/select2/select2-bootstrap.css">
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
						2차 희망 교수 선택
					</div>
					
					<small class="text-small pull-right" style="padding-top:5px;">
						선택 기간 : {{system.start}} ~ {{system.end}}
					</small>
				</div>
				<div class="panel-body">
					<form role="form" class="form-horizontal" id="permission" action="system/proc/permission" method="post">
						<div class="form-group">
							<label class="col-sm-2 control-label">1지망 선택</label>
							<div class="col-sm-10">
								<select class="form-control" name="firstProfId">
									<option></option>
								</select>
							</div>
						</div>
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">2지망 선택</label>
							<div class="col-sm-10">
								<select class="form-control" name="secondProfId">
									<option></option>
								</select>
							</div>
						</div>
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">3지망 선택</label>
							<div class="col-sm-10">
								<select class="form-control" name="thirdProfId">
									<option></option>
								</select>
							</div>
						</div>
						<div class="form-group-separator"></div>
						<div class="form-group">
							<div class="col-sm-10">
								<h5 class="text-muted">※ 교수님의 1차 지도 학생 선택 기간중 미선택될 경우 2차 희망 교수 선택 단계로 넘어갑니다.</h5>
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
	<script src="/assets/js/select2/select2.min.js"></script>
	<script src="/assets/js/jquery.form.min.js"></script>	
	<script type="text/javascript">
		jQuery(document).ready(function($) {
			$.post( "system/ajax/permission", function( data ) {
				var result = {};
				var majorArr = ['전자전기공학부', '컴퓨터공학과', '반도체시스템공학과', '소프트웨어학과', '정보통신대학', '(미등록)'];
		        majorArr.forEach(function(major) {
		            result[major] = [];
		        });

		        data.data.forEach(function(user) {
		            if (user.major === null) user.major = 5;
		            result[majorArr[user.major]].push(user);
		        });
		        for(var major in result){

		        	for(var order in ["first","second","third"]){
			        	var ele=$('<optgroup label="'+major+'">');
			        	result[major].forEach(function(user){
			        		ele.append('<option value="'+user.id+'">'+user.name+' ( 지도 가능 학생수 : '+user.selectable+'명, '+(parseInt(order)+1)+'지망 선택 : '+user[["firstSelected","secondSelected","thirdSelected"][order]]+'명 )</option>')			        	
			        	});
					 	$("#permission select:eq("+order+")").append(ele);
					}
		        }

			 	$("#permission select").select2({
					placeholder: '교수님을 선택해주세요.'
				});
			 	if(data.selected){
		 			$('select[name="firstProfId"]').select2('val',data.selected.firstProfId);
				 	$('select[name="secondProfId"]').select2('val',data.selected.secondProfId);
					$('select[name="thirdProfId"]').select2('val',data.selected.thirdProfId);
				}
				else alert("1차 지도 학생 선택에 미선택되었습니다. 2차 희망 교수 선택을 진행하시기 바랍니다.");
			});

			

			$('form#permission').submit(function(e) {
		        e.preventDefault();
		        var a=$('select[name="firstProfId"]').select2('val');
				var b=$('select[name="secondProfId"]').select2('val');
				var c=$('select[name="thirdProfId"]').select2('val');
				if(a==''||b==''||c==''){
					alert("교수님을 선택해주세요.")
				}
				else if(a!=''&&b!=''&&c!=''&&(a==b||a==c||b==c)){
					alert("서로 다른 교수님을 선택하셔야 합니다.");
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
		});
	</script>	
{% endblock %}