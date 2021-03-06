<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<style>
* {box-sizing: border-box;}
.mypage_container select[type]:focus {
	border-color: rgba(184, 223, 216, 0.5);
	box-shadow: 0 1px 1px rgb(184, 223, 216, 0.904) inset, 0 0 20px
	rgb(184, 223, 216, 0.6);
	outline: 0 none;
}
.mypage_container input[type]:focus {
	border-color: rgba(184, 223, 216, 0.5);
	box-shadow: 0 1px 1px rgb(184, 223, 216, 0.904) inset, 0 0 20px
	rgb(184, 223, 216, 0.6);
	outline: 0 none;
}
.mypage_container button[type] {background-color: #A9CCB3;border: #A9CCB3;color:white;}
.mypage_container #btn_pro_basic {background-color: #A9CCB3;border: #A9CCB3;color:white; width: 178.77px;height: 39px;}
.mypage_container #btn_modi_ck {margin: 30px;background-color: #7AB08A;border: #7AB08A;color:white; width: 250px;height: 50px;font-size: 19px;}
.mypage_container #btn_del_mem {margin: 30px; background-color: #A9A9A9;;border: #A9A9A9;;color:white; width: 250px;height: 50px;font-size: 19px;}
.mypage_container button[type]:focus {box-shadow: 0 1px 1px rgb(184, 223, 216, 0.904) inset, 0 0 20px rgb(184, 223, 216, 0.6);outline: 0 none;}
.mypage_container button[type]:hover {background:#7AB08A;box-shadow: 0 1px 1px rgb(184, 223, 216, 0.904) inset, 0 0 20px rgb(184, 223, 216, 0.6);outline: 0 none;}
.mypage_container input[type] {border-color: rgba(184, 223, 216, 0.5);}
.mypage_container .incon {overflow: hidden;}
.mypage_container .btn_pw {width: 127px;}
.mypage_container .exex {border: none;}
.mypage_container .con_btn_modify {text-align: center;}
.mypage_container .empty {height: 100px;}
.mypage_container #hidden {display: none;}
/* 비번변경위해 확인 안맞을시 */
.mypage_container .pw_input_reg_1 {color: red;display: none;}
.img_con {width: 150px !important;height: 150px !important;border-radius: 70%;overflow: hidden;}
.img_profile {width: 100%;height: 100%;object-fit: cover;}
/* 비번일치 */
.mypage_container .pw_input_re_1 {color: green;display: none;}
/* 비번불일치 */
.mypage_container .pw_input_re_2 {color: red;display: none;}
.mypage_container .btn_modi_name_02 {display: none;}
.mypage_container .btn_modi_school_02 {display: none;}
.btn_modi_phone_02 {display: none;}
.mypage_container .btn_modi_age_02 {display: none;}
/* 새비번 설정 */
.mypage_container .new_pw_con {display: none;}
/* 모든 비활성 <input> 선택 */
.mypage_container input:disabled {background: #E4EFE7;}
/* 이미지 청아꺼 */
 #excelName{ position: absolute; width: 1px; height: 1px; padding: 0; margin: -1px; overflow: hidden; clip:rect(0,0,0,0); border: 0; } 
.filebox label { 
      display: inline-block; 
      padding: .5em .75em; 
      color: white;
      font-size: inherit; 
      line-height: normal; 
      vertical-align: middle; 
      background-color: darkgray;
      cursor: pointer; 
      border: 1px solid #ebebeb; 
      border-bottom-color: #e2e2e2; 
      border-radius: .25em; 
    } 
    /* named upload */ 
    .upload-name { 
      display: inline-block; 
      padding: .5em .75em; /* label의 패딩값과 일치 */ 
      font-size: inherit; 
      font-family: inherit; 
      line-height: normal; 
      vertical-align: middle; 
      background-color: white;
      border: 1px solid #ebebeb; 
      border-bottom-color: #e2e2e2; 
      border-radius: .25em; 
      -webkit-appearance: none; /* 네이티브 외형 감추기 */ 
      -moz-appearance: none; 
      appearance: none; 
    }
</style>
<script>
	$(function() {
		function setdto() {
			$('#email').val($('.mail_input').val());
			$('#name').val($('.inp_modi_name').val());
			$('#school').val($('.inp_modi_school').val());
			$('#age').val($('.age_show').val());
			$('#phone').val($('.inp_modi_phone').val());
		};
		//비번변경
		$(".btn_pw").click(function() {
			$('#pw').val($('.inp_modi_pw').val());
			$.ajax({
				type : "post",
				url : "/mem/pwck",
				data : {
					"email" : $("#Email_input").val(),
					"pw" : $(".inp_modi_pw").val()
				},
				success : function(result) {
					console.log("성공 여부" + result);
					if (result != 'fail') {
						$('.new_pw_con').css("display", "inline-block");
					} else {//사용가능
						Swal.fire({
							  icon: 'error',
							  title: '비밀번호가 일치하지않습니다.',
							  text: '확인 후 다시 시도해주세요.'
							})
						// alert("비밀번호가 일치하지않습니다.\n확인 후 다시 시도해주세요.");
					}
				}
			});
		})
		//비번일치여부
		$(".inp_pw2,.inp_pw1").on("propertychange change keyup paste input", function() {
			var inp_pw1 = $('.inp_pw1').val();
			var inp_pw2 = $('.inp_pw2').val();
			if (inp_pw1 != inp_pw2) {//불일치
				$('.pw_input_re_2').css("display", "inline-block");
				$('.pw_input_re_1').css("display", "none");
			} else {
				$('.pw_input_re_1').css("display", "inline-block");
				$('.pw_input_re_2').css("display", "none");
			}
		});
		$(".btn_modi_pw").click(function() {
			var inp_pw1 = $('.inp_pw1').val();
			var inp_pw2 = $('.inp_pw2').val();
			let pwReg = /^[a-z0-9]{6,15}$/;
			if (inp_pw1 == inp_pw2) {
				if (!(pwReg.test(inp_pw2))){
					alert("형식에 맞지 않습니다.\n a-z,0-9로만 6~15자로 설정합니다.");
				}else{
					setdto();
					$('#pw').val($('.inp_pw2').val());
					$("#frm_modi").attr("action", "/mem/modiPw").submit();
				}
			}else{
				alert("비밀번호가 일치하지 않습니다.");
			}
		})
		//이름변경
		$(".btn_modi_name_01").click(function() {
			$('.btn_modi_name_01').css("display", "none");
			$('.btn_modi_name_02').css("display", "inline-block");
			$('.inp_modi_name').attr("disabled", false).focus();
		})
		$(".btn_modi_name_02").click(function() {
			let nameReg = /^[가-힣]{2,10}$/;
			var inp_modi_name = $('.inp_modi_name').val();
			if (!(nameReg.test(inp_modi_name))){
				alert("이름은 한글로 2~10자로 작성해주세요");
				$('.inp_modi_name').focus();
				return;
			}else{
				$('.btn_modi_name_02').css("display", "none");
				$('.btn_modi_name_01').css("display", "inline-block");
				$('.inp_modi_name').attr("disabled", true).blur();
				setdto();
				$("#frm_modi").attr("action", "/mem/modiName").submit();	
			}
		})
		//학교변경
		$(".btn_modi_school_01").click(function() {
			$('.btn_modi_school_01').css("display", "none");
			$('.btn_modi_school_02').css("display", "inline-block");
			$('.inp_modi_school').attr("disabled", false).focus();
		})
		$(".btn_modi_school_02").click(function() {
			let schoolReg = /^[가-힣]+[초중고대]$/;
			var inp_modi_school = $('.inp_modi_school').val();
			if (!(schoolReg.test(inp_modi_school))){
				alert("학교명을 공백없이 초, 중, 고, 대 로 끝나도록 작성해주세요");
				$('.inp_modi_school').focus();
				return;
			}else{
				$('.btn_modi_school_02').css("display", "none");
				$('.btn_modi_school_01').css("display", "inline-block");
				$('.inp_modi_school').attr("disabled", true).blur();
				setdto();
				$("#frm_modi").attr("action", "/mem/modiSchool").submit();
			}
		})
		//연락처변경
		$(".btn_modi_phone_01").click(function() {
			$('.btn_modi_phone_01').css("display", "none");
			$('.btn_modi_phone_02').css("display", "inline-block");
			$('.inp_modi_phone').attr("disabled", false).focus();
		})
		$(".btn_modi_phone_02").click(function() {
			let phoneReg = /^01[0-9]{1}-[0-9]{3,4}-[0-9]{4}$/;
			var inp_modi_phone = $('.inp_modi_phone').val();
			if (!(phoneReg.test(inp_modi_phone))){
				alert("연락처가 형식에 맞지 않습니다.\n예시 010-1234-1234");
				$('#phone').focus();
				return;
			}else{
				$('.btn_modi_phone_02').css("display", "none");
				$('.btn_modi_phone_01').css("display", "inline-block");
				$('.inp_modi_phone').attr("disabled", true).blur();
				setdto();
				$("#frm_modi").attr("action", "/mem/modiPhone").submit();
			}
		})
		//나이변경
		$(".btn_modi_age_01").click(function() {
			$('.btn_modi_age_01').css("display", "none");
			$('.btn_modi_age_02').css("display", "inline-block");
			$('.sel_modi_age').attr("disabled", false)
		})
		$(".btn_modi_age_02").click(function() {
			if ($('.sel_modi_age').val()==null){
				alert("나이대를 선택해주세요");
				 $('.sel_modi_age').focus();
				return;
			}else{
				$('.btn_modi_age_02').css("display", "none");
				$('.btn_modi_age_01').css("display", "inline-block");
				$('.age_show').val($('.sel_modi_age').val());
				$('.sel_modi_age').attr("disabled", true)
				setdto();
				$("#frm_modi").attr("action", "/mem/modiAge").submit();
			}
		})
		//적용사항보기
		$(".btn_modi_ck").click(function() {
			location.href = "/mem/mypage";
		})
		//청아파일코드
	    $(".upload-hidden").on("change", function(){ // 값이 변경되면 
	         var file = $(this)[0].files[0];
	         var form = $("#frm_modi")[0];       
			 var formData = new FormData(form); 

	         if(file.size >= 1048576) {
	             // alert("업로드 할 수 있는 파일 사이즈를 초과했습니다.");
	             Swal.fire({
					icon: 'warning',
					title: '업로드 할 수 있는 \n파일 사이즈를 초과했습니다.',
					text: '파일크기를 확인해주세요.'
				 })
	             return false;
	         }
	         let regex = /(.*?)\.(jpg|jpeg|png|gif|bmp)$/;
	         if(!regex.test(file.name)){
	             // alert("이미지 파일만 업로드 가능합니다.");
	             Swal.fire({
					icon: 'warning',
					title: '이미지 파일만 업로드 가능합니다.',
					text: '파일 형식을 확인해주세요'
				})
	             return false;
	         }
	        $(".upload-name").val(file.name); // 추출한 파일명 삽입
	         
	        $.ajax({
	            url:"/mem/imgupload",
	            type:"POST",
	            data:formData,
	    		processData: false, // data가 서버에 전달될때 String 형식아니고 "multipart/form-data"로 보내야됨
	    		contentType: false, // "application/x-www-form-urlencoded; charset=UTF-8"이것이 아니라 "multipart/form-data"로 보내야됩니다.
	    		cache:false
	         }).done(function(resp){
	             console.log(resp);
	             $(".img_profile").attr("src","/mem/display?fileName="+resp);
	          })
        });
		/* 기본이미지로 */
		$("#btn_pro_basic").on("click",function(){
			var email = $('#email').val();
			var sysnull = "";
			//setdto();
		    $.ajax({
				type:"GET",
				url:"/mem/profileBasic",
				data:{"email":email,"sysnull":sysnull},
				dataType:"json"
				}).done(function(resp){
					console.log(resp);
					if(resp>0){
						alert("기본이미지로 재설정 되었습니다.");
						setdto();
						//${login.sysName} == null
						location.href  ="/mem/mypage"
						
					}else{
						alert("기본이미지로 변경을 실패했습니다. \n다시 시도해주세요.");
					}
				})
		});
		/* 탈퇴 */
		$("#btn_del_mem").on("click",function(){
			var email = $('#email').val();
			
			var result = confirm("정말로 탈퇴하시겠습니까?");
	    		if(result){
	    			location.href = "/mem/delMem?email="+email;
	    		}else{
	    			alert("ss");
	    		}
		});
})
</script>
</head>
<body>
	<jsp:include page="../layout/header.jsp" />

	<form action="" method="post" id="frm_modi" enctype="multipart/form-data">
		<div class="mypage_container container p-5">
			<!--    <div class="mypage_container container-fluid"> -->
			<div class="profile">
				<!-- <div class="profile mr-5 ml-5"> -->
				<div class="title incon row m-5">
					<h2 class="col-12">마이페이지</h2>
					<hr class="col-12">
				</div>
				<div class="id_pw_con incon row m-5 ">
					<div class="col-1"></div>
					<div class="img_con ml-3">
					<c:choose>
						<c:when test="${login.sysName == null}">
							<img class="img_profile" src="/img/profile.png">
						</c:when>
						<c:otherwise>
							<img class="img_profile" src="/mem/display?fileName=${login.sysName }">
						</c:otherwise>
					</c:choose>
						<!-- <img class="img_profile" src=""> -->
<!-- 						<img class="img_profile" src="/img/profile.png"> -->
					</div>
				</div>
				<div class="id_pw_con incon row m-5 ">
					<div class="col-12 col-sm-12 col-md-6 col-lg-9 p-0"
						id="excleupload">
							<div class="filebox w-100" style="text-align: left;">
								<button type="button" class="btn btn-success  btn_pro_basic " id="btn_pro_basic">기본 이미지로 변경</button>
								<input class="upload-name hidden" id="hidden" value="파일선택" disabled="disabled">
								<label for="excelName" class="mb-0">프로필 이미지 업로드</label> 
								<input type="file" id="excelName" name="file" class="upload-hidden">
							</div>
					</div>
				</div>
				<div class="id_pw_con incon row m-5 ">
					<h5 class="col-12">이메일</h5>
					<p class="col-12 mb-4">
						- <mark>아이디</mark>로 사용되는 이메일은 변경이 불가합니다.
					</p>
					<div class="col-12">
						<div class="row">
							<div class="col-sm-6 col-md-6 col-lg-4">
								<input type="text" class="form-control inp_id mail_input" id="Email_input" disabled value=${login.email}>
							</div>
						</div>
					</div>
				</div>
				<div class="id_pw_con incon row m-5">
					<h5 class="col-12 mb-4">비밀번호 변경</h5>
					<p class="col-12 mb-4">
						-<mark>기존 비밀번호</mark>를 입력하여 확인합니다.
					</p>
					<div class="col-12">
						<div class="row">
							<div class="col-sm-6 col-md-6 col-lg-4">
								<input type="password" class="form-control inp_modi_pw">

							</div>
							<div class="col-sm-5 col-md-3 col-lg-2 ">
								<button type="button" class="btn btn-success btn_pw  ">비밀번호 확인</button>
							</div>
						</div>
						<div class="row">
							<div class="col-12">
								<div class="form-control  exex pw_input_reg_1">비밀번호가 불일치 합니다.</div>
							</div>
						</div>
					</div>
				</div>
				<div class="id_pw_con incon row m-5 new_pw_con">
					<h5 class="col-12 mb-4">새 비밀번호 설정</h5>
					<p class="col-12 mb-4">
						- 비밀번호는 <mark>a-z</mark> 그리고 <mark>0-9</mark>로만<mark>6자에서 15자 사이</mark>로 설정합니다.
					</p>
					<div class="col-12 col-sm-5 col-lg-5">
						<input type="password" class="form-control inp_pw1 ">
					</div>
					<div class="col-12">
						<div class="row">
							<div class="col-12 col-sm-5 col-lg-5">
								<input type="password" class="form-control inp_pw2 mt-3">
							</div>
							<div class="col-12 col-sm-7 col-lg-6 pt-3">
								<div class="form-control  exex pw_input_re_1">비밀번호가 일치합니다.</div>
								<div class="form-control  exex pw_input_re_2">비밀번호가 불일치합니다.</div>
								<div class="col-md-1 col-lg-none"></div>
							</div>
						</div>
					</div>
					<div class="col-12 mt-3">
						<button type="button" class="btn btn-success btn_modi_pw">비밀번호 변경하기</button>
					</div>
				</div>
			</div>
			<div class="privacy pt-4">
				<div class="title incon row m-5">
					<h2 class="col-12">개인 정보</h2>
					<hr class="col-12">
				</div>
				<div class="id_pw_con incon row m-5">
					<h5 class="col-12 mb-4">이름</h5>
					<div class="col-12">
						<div class="row">
							<div class="col-sm-12 col-md-6 col-lg-3">
								<input type="text" class="form-control inp_modi_name" value=${login.name } disabled>
							</div>
							<div class="col-sm-12 col-md-6 col-lg-8 ">
								<button type="button" class="btn btn-success btn_modi_name_01 ">이름 변경하기</button>
								<button type="button" class="btn btn-primary btn_modi_name_02 ">이름 저장하기</button>
							</div>
						</div>
					</div>
				</div>
				<div class="id_pw_con incon row m-5">
					<h5 class="col-12 mb-4">소속 학교 정보</h5>
					<div class="col-12">
						<div class="row">
							<div class="col-12 mt-3">
								<div class="row">
									<div class="col-12 col-md-6 col-lg-4">
										<input type="text" class="form-control inp_modi_school " value=${login.school } disabled>
									</div>
									<div class="col-12 col-md-6 col-lg-8 ">
										<button type="button" class="btn btn-success btn_modi_school_01 ">소속 학교 변경하기</button>
										<button type="button" class="btn btn-primary btn_modi_school_02 ">소속 학교 저장하기</button>
									</div>
								</div>
								<div class="row">
									<div class="col-12 col-md-12">
										<div class="form-control  exex pb-5">예시 - 무학여고, 마산중 (공백없이 입력해주세요)</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="id_pw_con incon row m-5">
					<h5 class="col-12 mb-4">나이대</h5>
					<div class="input-group row pl-3">
						<div class="col-sm-2 col-md-2">
							<input type="text" class="form-control age_show" value=${login.age } disabled>
						</div>
						<select type="select" class=" custom-select col-sm-5 col-md-2 sel_modi_age" disabled>
							<option value="" selected disabled>선택</option>
							<option value="20대">20대</option>
							<option value="30대">30대</option>
							<option value="40대">40대</option>
							<option value="50대">50대</option>
							<option value="60대">60대</option>
						</select>
						<div class="col-sm-5 col-md-6">
							<button type="button" class="btn btn-success btn_modi_age_01 ">나이대 변경하기</button>
							<button type="button" class="btn btn-primary btn_modi_age_02 ">나이대 저장하기</button>
						</div>
					</div>
				</div>
				<div class="id_pw_con incon row m-5">
					<h5 class="col-12 mb-4">연락처</h5>
					<p class="col-12">
						- <mark>비밀번호 찾기</mark> 시 이용 됩니다
					</p>
					<div class="col-12">
						<div class="row">
							<div class="col-3 col-md-5">
								<input type="text" class="form-control inp_modi_phone " value=${login.phone } disabled>
							</div>
							<div class="col-6 col-md-5">
								<button type="button" class="btn btn-success btn_modi_phone_01 ">연락처 변경하기</button>
								<button type="button" class="btn btn-primary btn_modi_phone_02 ">연락처 저장하기</button>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-12 col-md-12">
							<div class="form-control  exex">연락처 형식 일치 여부</div>
						</div>
					</div>
				</div>
			</div>
			<div class="empty"></div>
			<div class="con_btn_modify m-5">
				<button type="button" class="btn  btn_modi_ck" id="btn_modi_ck">수정 된 정보 확인하기</button>
				<button type="button" class="btn  btn_modi_ck" id="btn_del_mem">회원탈퇴</button>
			</div>
			<div class="empty">
				<input type="hidden" name="email" id="email" value=${login.email}> 
				<input type="hidden" name="pw" id="pw" value=${login.pw}> 
				<input type="hidden" name="name" id="name"> 
				<input type="hidden" name="school" id="school"> 
				<input type="hidden" name="gender" id="gender" value=${login.gender}> 
				<input type="hidden" name="age" id="age"> 
				<input type="hidden" name="oriName" id="oriName" value=${login.oriName}> 
				<input type="hidden" name="sysName" id="sysName" value=${login.sysName}>
				<input type="hidden" name="phone" id="phone"> 
				<input type="hidden" name="reg_date" id="reg_date" value=${login.reg_date}>
			</div>
		</div>
	</form>
	<jsp:include page="../layout/footer.jsp" />
	
</body>
</html>


