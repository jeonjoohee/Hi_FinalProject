<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.js"></script>
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<style>
* {
	box-sizing: border-box;
}

/* div {
            border: 1px solid black;
        } */
select[type]:focus {
	border-color: rgba(184, 223, 216, 0.5);
	box-shadow: 0 1px 1px rgb(184, 223, 216, 0.904) inset, 0 0 20px
		rgb(184, 223, 216, 0.6);
	outline: 0 none;
}

input[type]:focus {
	border-color: rgba(184, 223, 216, 0.5);
	box-shadow: 0 1px 1px rgb(184, 223, 216, 0.904) inset, 0 0 20px
		rgb(184, 223, 216, 0.6);
	outline: 0 none;
}

input[type] {
	border-color: rgba(184, 223, 216, 0.5);
}

.mypage_container .incon {
	overflow: hidden;
}

.mypage_container .btn_pw {
	width: 127px;
}

.mypage_container .exex {
	border: none;
}

.mypage_container .con_btn_modify {
	text-align: center;
}

.mypage_container .empty {
	height: 100px;
}

/* 비번변경위해 확인 안맞을시 */
.mypage_container .pw_input_reg_1 {
	color: red;
	display: none;
}

.img_con {
	width: 150px !important;
	height: 150px !important;
	border-radius: 70%;
	overflow: hidden;
}

.img_profile {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

/* 비번일치 */
.mypage_container .pw_input_re_1 {
	color: green;
	display: none;
}

/* 비번불일치 */
.mypage_container .pw_input_re_2 {
	color: red;
	display: none;
}
</style>
<script>
	$(function() {
		AOS.init();
		$("#main").addClass("active");
	})
</script>
</head>
<body>
	<jsp:include page="../layout/header.jsp" />
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
					<img class="img_profile" src="/img/profile.png">
				</div>

			</div>
			<div class="id_pw_con incon row m-5 ">
				<div>
					<button type="button" class="btn btn-success   ">기본 이미지로
						변경</button>
					<button type="button" class="btn btn-success   ">프로필 이미지
						변경</button>
				</div>
			</div>
			<div class="id_pw_con incon row m-5 ">
				<h5 class="col-12">이메일</h5>
				<p class="col-12 mb-4">
					-
					<mark>아이디</mark>
					로 사용되는 이메일은 변경이 불가합니다.
				</p>
				<div class="col-12">
					<div class="row">
						<div class="col-sm-6 col-md-6 col-lg-4">
							<input type="text" class="form-control inp_id mail_input"
								id="Email_input" name="email" disabled>

						</div>
					</div>
				</div>
			</div>
			<div class="id_pw_con incon row m-5">
				<h5 class="col-12 mb-4">비밀번호 변경</h5>
				<p class="col-12 mb-4">
					-
					<mark>기존 비밀번호</mark>
					를 입력하여 확인합니다..
				</p>
				<div class="col-12">
					<div class="row">
						<div class="col-sm-6 col-md-6 col-lg-4">
							<input type="text" class="form-control  ">

						</div>
						<div class="col-sm-5 col-md-3 col-lg-2 ">
							<button type="button" class="btn btn-success btn_pw  ">비밀번호
								확인</button>
						</div>
					</div>
					<div class="row">
						<div class="col-12">
							<div class="form-control  exex pw_input_reg_1">비밀번호가 불일치
								합니다.</div>
						</div>

					</div>
				</div>
			</div>
			<div class="id_pw_con incon row m-5">
				<h5 class="col-12 mb-4">새 비밀번호 설정</h5>
				<p class="col-12 mb-4">
					- 비밀번호는
					<mark>a-z</mark>
					그리고
					<mark>0-9</mark>
					로만
					<mark>6자에서 15자 사이</mark>
					로 설정합니다.
				</p>
				<div class="col-12 col-sm-5 col-lg-5">
					<input type="text" class="form-control inp_pw1 ">
				</div>
				<div class="col-12">
					<div class="row">
						<div class="col-12 col-sm-5 col-lg-5">
							<input type="text" class="form-control inp_pw2 mt-3">
						</div>
						<div class="col-12 col-sm-7 col-lg-6">
							<!-- <div class="form-control  exex">비번일치 여부</div> -->
							<div class="form-control  exex pw_input_re_1">비밀번호가 일치합니다.</div>
							<div class="form-control  exex pw_input_re_2">비밀번호가 불일치합니다.</div>
							<div class="col-md-1 col-lg-none"></div>
						</div>
					</div>
				</div>
				<div class="col-12 mt-3">
					<button type="button" class="btn btn-success ">비밀번호 변경하기</button>
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
							<input type="text" class="form-control ">

						</div>
						<div class="col-sm-12 col-md-6 col-lg-8 ">
							<button type="button" class="btn btn-success  ">이름 변경하기</button>
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
									<input type="text" class="form-control  " name="school">
								</div>
								<div class="col-12 col-md-6 col-lg-8 ">
									<button type="button" class="btn btn-success  ">소속 학교
										변경하기</button>
								</div>
							</div>
							<div class="row">
								<div class="col-12 col-md-12">
									<div class="form-control  exex pb-5">예시 - 무학여고, 마산중 (공백없이
										입력해주세요)</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="id_pw_con incon row m-5">
				<h5 class="col-12 mb-4">나이대</h5>
				<div class="input-group row">
					<select type="select" name="age"
						class=" custom-select col-sm-5 col-md-2 ml-4"
						id="inputGroupSelect01">
						<option selected>선택</option>
						<option value="20">20대</option>
						<option value="30">30대</option>
						<option value="40">40대</option>
						<option value="50">50대</option>
						<option value="60">60대</option>
					</select>
					<div class="col-sm-5 col-md-6">
						<button type="button" class="btn btn-success  ">나이대 변경하기</button>
					</div>
				</div>
			</div>

			<div class="id_pw_con incon row m-5">
				<h5 class="col-12 mb-4">연락처</h5>
				<p class="col-12">
					-
					<mark>비밀번호 찾기</mark>
					시 이용 됩니다
				</p>
				<div class="col-12">
					<div class="row">
						<div class="col-2 col-md-2 ml-1 p-0">
							<input type="text" class="form-control  " name="ph1">
						</div>
						<div class="col-1 col-md-1 ">
							<p>-</p>
						</div>
						<div class="col-3 col-md-2 ml-1 p-0">
							<input type="text" class="form-control  " name="ph2">
						</div>
						<div class="col-1 col-md-1 ">
							<p>-</p>
						</div>
						<div class="col-3 col-md-2 ml-1 p-0">
							<input type="text" class="form-control  " name="ph3">
						</div>
					</div>


				</div>
				<div class="row">
					<div class="col-12 col-md-12">
						<div class="form-control  exex">연락처 형식 일치 여부</div>
					</div>
					<div class="col-sm-5 col-md-6">
						<button type="button" class="btn btn-success  ">연락처 변경하기</button>
					</div>
				</div>


			</div>
		</div>
		<div class="empty"></div>
		<div class="con_btn_modify m-5">
			<button class="btn btn-success">수정 된 정보 확인하기</button>
		</div>
		<div class="empty"></div>
	</div>
	<jsp:include page="../layout/footer.jsp" />
</body>
</html>


