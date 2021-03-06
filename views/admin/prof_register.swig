{% extends "layout.swig" %}

{% set page = "prof_register" %}

{% block page_header %}
	<link rel="stylesheet" href="/assets/js/select2/select2.css">
	<link rel="stylesheet" href="/assets/js/select2/select2-bootstrap.css">
	<style>
	</style>
{% endblock %}

{% block page_body %}
	<div class="page-title">
		<div class="title-env">
			<h1 class="title">교수 등록 및 수정</h1>
			<p class="description">추가하고 싶은 교수님의 정보를 입력 또는 수정하고 싶은 교수님을 선택하시기 바랍니다.</p>
		</div>
		<div class="breadcrumb-env">
			<ol class="breadcrumb bc-1">
				<li>
					<a href="main"><i class="fa-home"></i>메인</a>
				</li>
				<li style="color:#979898;">			
					교수 관리
				</li>
				<li class="active">
					<strong>교수 등록 및 수정</strong>
				</li>
			</ol>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-12">
			<form role="form" class="form-horizontal" id="register" action="{% if selectedId %}../{% endif %}prof_register" method="post">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">교수 선택</h3>
					</div>
					<div class="panel-body">
						<div class="form-group">
							<label class="col-sm-2 control-label">교수 선택</label>
							<div class="col-sm-10">
								<select class="form-control" name="id">
									<option></option>
									{% for profs in data %}
										<optgroup label="{{ loop.key }}">
										{% for prof in profs %}
											<option value="{{prof.id}}">{{prof.name}}</option>											
										{% endfor %}
									{% endfor %}
								</select>
							</div>
						</div>
					</div>
					<div class="panel-heading">
						<h3 class="panel-title">교수 기본 정보</h3>
					</div>
					<div class="panel-body">
						<div class="form-group">
							<label class="col-sm-2 control-label" for="ids">아이디</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="ids" placeholder="ex) 1234 (교수 내선번호)" autocomplete="off">
							</div>
						</div>
						<div class="form-group-separator"></div>						
						<div class="form-group">
							<label class="col-sm-2 control-label">비밀번호</label>
							<div class="col-sm-10">
								<input type="password" class="form-control" name="password" placeholder="ex) 1234 (교수 내선번호)">
							</div>
						</div>
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">이름</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="name" placeholder="ex) 홍길동 (교수님 성함)">
							</div>
						</div>
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">이메일</label>
							<div class="col-sm-10">
								<input type="email" class="form-control" name="email" placeholder="ex) test1234@skku.edu">
							</div>
						</div>
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">연락처</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="phone" placeholder="ex) 031-290-1234">
							</div>
						</div>
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">전공</label>
							<div class="col-sm-10">
								<select class="form-control" name="major">
									<option value="0">전자전기공학부</option>
									<option value="1">컴퓨터공학과</option>
									<option value="2">반도체시스템공학과</option>
									<option value="3">소프트웨어학과</option>
									<option value="4">정보통신대학</option>
								</select>
							</div>
						</div>
						<div class="form-group-separator"></div>
						<div class="form-group">
							<button type="submit" class="btn btn-success" style="float:right;">등록하기</button>
							<button type="button" class="btn btn-danger" id="delete_btn" style="float:right;margin-right:20px;display:none;">삭제하기</button>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
{% endblock %}

{% block page_footer %}
	<script src="/assets/js/select2/select2.min.js"></script>
	<script src="/assets/js/jquery.form.min.js"></script>		
	<script type="text/javascript">
		jQuery(document).ready(function($) {
			$("select[name='id']").select2({
				placeholder: '교수를 선택해 주세요. (교수 등록시 미선택)'
			}).on("select2-selecting", function(e) {

				var id;
				if(e.val) id=e.val;
				else id=$("select[name='id']").val();

				$.post( "{% if selectedId %}../{% endif %}prof_register/ajax/get_prof",{id:id}, function( data ) {
					$('.form-group').removeClass('has-warning');
					$('input[name="ids"]').val(data.ids).attr("disabled", "disabled");;
					$('input[name="password"]').val("").attr('placeholder','(비밀번호 변경일 경우 입력)');
					$('input[name="name"]').val(data.name);
					$('input[name="email"]').val(data.email);
					$('input[name="phone"]').val(data.phone);
					$('select[name="major"]').select2('val',data.major);
					$('button[type="submit"]').text('수정하기');
					$('#delete_btn').show();
				});
			});
			$("select[name='major']").select2({
				placeholder: '전공을 선택해 주세요.'
			});

			$('form#register').submit(function(e) {
		        e.preventDefault();

		        if($('select[name="id"]').select2('val')==="" && $('input[name="ids"]').val()===""){
		       		$('input[name="ids"]').focus().parent().parent().addClass('has-warning');
		       	}
		       	else if($('select[name="id"]').select2('val')==="" && $('input[name="password"]').val()===""){
		       		$('input[name="ids"]').parent().parent().removeClass('has-warning');
		       		$('input[name="password"]').focus().parent().parent().addClass('has-warning');
		       	}
		       	else {
		        	$(this).ajaxSubmit({
		                beforeSubmit: function(arr, $form, options) {
				        	$('button[type="submit"],button[type="button"]').attr("disabled", "disabled");
		            		show_loading_bar(70);
		                },
		                success: function(data) {
							show_loading_bar({
		                        delay: 1,
		                        pct: 100,
		                        finish: function() {
		                        	if(!data.result){
		                        		alert(data.text);	
		                        		window.location.href = './{% if selectedId %}../{% endif %}prof_register';
		                        	} 
		                        	else window.location.href = './{% if selectedId %}../{% endif %}prof_register/{{selectedId}}';
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
			$('#delete_btn').click(function(){
				if(confirm("교수 정보를 정말 삭제하시겠습니까?\n(배정된 학생은 교수 미배정으로 수정됩니다.)")){
					$('button[type="submit"],button[type="button"]').attr("disabled", "disabled");
			        show_loading_bar(70);
					$.post( "{% if selectedId %}../{% endif %}prof_register/ajax/del_prof",{id:$("select[name='id']").select2('val')}, function( data ) {
						show_loading_bar({
	                        delay: 0.5,
	                        pct: 100,
	                        finish: function() {
								if(!data.result){
			                		alert(data.text);	
			                		window.location.href = './prof_register';
			                	} 
			                	else window.location.href = './prof_list';
	                        }
	                    });
					});
				}
			});

			{% if selectedId %}
				$('select[name="id"]').select2('val',{{ selectedId }}).trigger('select2-selecting');
			{% endif %}
		});
	</script>
{% endblock %}