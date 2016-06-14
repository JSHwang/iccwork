{% extends "layout.swig" %}

{% set page = "student_register" %}

{% block page_header %}
	<link rel="stylesheet" href="/assets/js/select2/select2.css">
	<link rel="stylesheet" href="/assets/js/select2/select2-bootstrap.css">
	<style>
	</style>
{% endblock %}

{% block page_body %}
	<div class="page-title">
		<div class="title-env">
			<h1 class="title">학생 등록 및 수정</h1>
			<p class="description">추가하고 싶은 학생의 정보를 입력 또는 수정하고 싶은 학생을 선택하시기 바랍니다.</p>
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
					<strong>학생 등록 및 수정</strong>
				</li>
			</ol>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-12">
			<form role="form" class="form-horizontal" id="register" action="{% if selectedId %}../{% endif %}student_register" method="post">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">학생 선택</h3>
					</div>
					<div class="panel-body">
						<div class="form-group">
							<label class="col-sm-2 control-label">학생 선택</label>
							<div class="col-sm-10">
								<select class="form-control" name="id" placeholder="학생를 선택해 주세요. (학생 등록시 미선택)">
									<option></option>
									{% for users_ in users %}
										<optgroup label="{{ loop.key }}">
										{% for user in users_ %}
											{% if user.type == 2 %}
												<option value="{{user.id}}">{{user.name}}</option>
											{% endif %}
										{% endfor %}
									{% endfor %}
								</select>
							</div>
						</div>
					</div>
					<div class="panel-heading">
						<h3 class="panel-title">학생 기본 정보</h3>
					</div>
					<div class="panel-body">
						<div class="form-group">
							<label class="col-sm-2 control-label" for="ids">아이디</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="ids" placeholder="ex) 2010123456 (학번)" autocomplete="off">
							</div>
						</div>
						<div class="form-group-separator"></div>						
						<div class="form-group">
							<label class="col-sm-2 control-label">비밀번호</label>
							<div class="col-sm-10">
								<input type="password" class="form-control" name="password" placeholder="ex) 900102 (생년월일)">
							</div>
						</div>
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">이름</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="name" placeholder="ex) 홍길동">
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
								<input type="text" class="form-control" name="phone" placeholder="ex) 010-1111-2222">
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
					</div>
					<div class="panel-heading">
						<h3 class="panel-title">학생 작품/논문 정보</h3>
					</div>
					<div class="panel-body">
						<div class="form-group">
							<label class="col-sm-2 control-label">학기</label>
							<div class="col-sm-4">
								<select class="form-control" name="term">
									{% for index in [1,2,3,4,5,6,7,8,9,10] %}
										<option value="{{index}}">{{index}} 학기</option>
									{% endfor %}
								</select>
							</div>
							<label class="col-sm-2 control-label">재학/졸업 여부</label>
							<div class="col-sm-4">
								<select class="form-control" name="status">
									<option value="0">재학</option>
									<option value="1">휴학</option>
									<option value="2">수료</option>
									<option value="3">졸업</option>
								</select>
							</div>
						</div>
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">작품/논문 여부</label>
							<div class="col-sm-4">
								<select class="form-control" name="iswork">
									<option value="1">작품</option>
									<option value="0">논문</option>
								</select>
							</div>
							<label class="col-sm-2 control-label">개인/공동 여부</label>
							<div class="col-sm-4">
								<select class="form-control" name="isgroup">
									<option value="0">개인</option>
									<option value="1">공동</option>
								</select>
							</div>
						</div>						
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">작품/논문 제목</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="title">
							</div>
						</div>
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">심사 단계</label>
							<div class="col-sm-4">
								<select class="form-control" name="result">
									<option value="0">미심사</option>
									<option value="1">심사통과</option>
									<option value="2">심사탈락</option>
									<option value="3">기합격</option>
								</select>
							</div>
						</div>						
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">지도교수 메세지</label>
							<div class="col-sm-10">
								<textarea class="form-control autogrow" name="note" placeholder="지도학생에게 보여지는 메시지란 입니다."></textarea>
							</div>
						</div>
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">비고</label>
							<div class="col-sm-10">
								<textarea class="form-control autogrow" name="comment" placeholder="학생에 관한 내용을 입력하는 비고란입니다."></textarea>
							</div>
						</div>
						<div class="form-group-separator"></div>
						<div class="form-group">
							<label class="col-sm-2 control-label">졸업 예정 학기</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" name="gryearterm" placeholder="ex) 201502 (년도 + 1학기 01, 2학기 02)">
							</div>	
						</div>					
					</div>
					<div class="panel-heading">
						<h3 class="panel-title">학생 시스템 단계</h3>
					</div>
					<div class="panel-body">
						<div class="form-group">
							<label class="col-sm-2 control-label">시스템 단계</label>
							<div class="col-sm-4">
								<select class="form-control" name="SystemId">
									{% for system in systems %}
										<option value="{{system.id}}">{{system.phase}}</option>
									{% endfor %}
								</select>
							</div>
							<label class="col-sm-2 control-label">시스템 락 (다음 학기 진행)</label>
							<div class="col-sm-4">
								<select class="form-control" name="islock">
									<option value="0">아니오</option>
									<option value="1">예</option>
								</select>
							</div>
						</div>
					</div>
					<div class="panel-heading">
						<h3 class="panel-title">학생 교수 배정 정보</h3>
					</div>
					<div class="panel-body">
						<div class="form-group">
							<label class="col-sm-2 control-label">배정 학기</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" name="yearterm" placeholder="ex) 201502 (년도 + 1학기 01, 2학기 02)">
							</div>
							<label class="col-sm-2 control-label">배정 교수</label>
							<div class="col-sm-4">
								<select class="form-control" name="ProfId" placeholder="교수 선택">
									<option></option>
									{% for users_ in users %}
										<optgroup label="{{ loop.key }}">
										{% for user in users_ %}
											{% if user.type == 1 %}
												<option value="{{user.ProfId}}">{{user.name}}</option>
											{% endif %}
										{% endfor %}
									{% endfor %}
								</select>
							</div>
						</div>
						<div class="form-group-separator"></div>
						<div class="form-group">
							<div class="col-sm-8">
								<h5 class="text-muted" id="deleteComment">
									※ 시스템 락은 현재 단계를 진행 할 수 없고, 다음학기 자동으로 해제되어 시작되는 설정 입니다.<br>
									ex) 교수 배정 단계 (6학기) 종료 후 서약서 및 제안서 업로드 단계로 설정된 (6학기) 때<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;또는 서약서 및 제안서 업로드 (7학기) 종료 후 중간보고서 단계로 설정된 (7학기) 때
								</h5>
							</div>
							<div class="col-sm-4">
								<button type="submit" class="btn btn-success" style="float:right;">등록하기</button>
								<button type="button" class="btn btn-danger" id="delete_btn" style="float:right;margin-right:20px;display:none;">삭제하기</button>
							</div>
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

			$("#register select").select2({
				minimumResultsForSearch: -1
			});
			$("#register select[name='id'],#register select[name='ProfId']").select2({
				minimumResultsForSearch: 1
			});

			$("select[name='id']").on("select2-selecting", function(e) {

				var id;
				if(e.val) id=e.val;
				else id=$("select[name='id']").val();

				$.post( "{% if selectedId %}../{% endif %}student_register/ajax/get_student",{id:id}, function( data ) {
					$('.form-group').removeClass('has-warning');
					$('input[name="ids"]').val(data.ids).attr("disabled", "disabled");;
					$('input[name="password"]').val("").attr('placeholder','(비밀번호 변경일 경우 입력)');
					$('input[name="name"]').val(data.name);
					$('input[name="email"]').val(data.email);
					$('input[name="phone"]').val(data.phone);
					$('select[name="major"]').select2('val',data.major);

					$('select[name="term"]').select2('val',data.Student.term);
					$('select[name="status"]').select2('val',data.Student.status);
					$('select[name="iswork"]').select2('val',(data.Student.iswork?1:0));
					$('select[name="isgroup"]').select2('val',data.Student.isgroup?1:0);
					$('input[name="title"]').val(data.Student.title);
					$('select[name="result"]').select2('val',data.Student.result);
					$('textarea[name="note"]').val(data.Student.note);
					$('textarea[name="comment"]').val(data.Student.comment);

					$('input[name="yearterm"]').val(data.Student.yearterm);
					$('select[name="ProfId"]').select2('val',data.Student.ProfId);

					$('select[name="SystemId"]').select2('val',data.Student.SystemId);
					$('select[name="islock"]').select2('val',(data.Student.islock?1:0));

					$('button[type="submit"]').text('수정하기');
					$('#delete_btn').show();
				});
			})

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
		                        		window.location.href = './{% if selectedId %}../{% endif %}student_register';
		                        	} 
		                        	else window.location.href = './{% if selectedId %}../{% endif %}student/{{selectedId}}';
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
				if(confirm("학생에 관한 모든 정보를 정말 삭제하시겠습니까?")){
					$('button[type="submit"],button[type="button"]').attr("disabled", "disabled");
			        show_loading_bar(70);
					$.post( "{% if selectedId %}../{% endif %}student_register/ajax/del_student",{id:$("select[name='id']").select2('val')}, function( data ) {
						show_loading_bar({
	                        delay: 0.5,
	                        pct: 100,
	                        finish: function() {
								if(!data.result){
			                		alert(data.text);	
			                		window.location.href = './student_register';
			                	} 
			                	else window.location.href = './student_list';
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