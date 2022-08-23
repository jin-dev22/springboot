<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="메뉴 REST API" />
</jsp:include>
<style>
div.menu-test {
	width: 50%;
	margin: 0 auto;
	text-align: center;
}

div.result {
	width: 70%;
	margin: 0 auto;
}
</style>

<!-- 
	GET /menu 				
	GET /menu/type/kr 		
	GET /menu/type/ch 
	GET /menu/type/jp
	
	GET /taste/mild 		
	GET /taste/hot
	
	GEt /menu/type/kr/taste/mild
	
	GET /menu/10 			
	
	POST /menu 				
	
	PUT /menu 				
	PATCH /menu
	
	DELETE /menu/10
 -->
<div id="menu-container" class="text-center">
	<!-- 1.GET /menus-->
	<div class="menu-test">
		<h4>전체메뉴조회(GET)</h4>
		<input type="button"
			class="btn btn-block btn-outline-success btn-send" id="btn-menus"
			value="전송" />
	</div>
	<div class="result" id="menus-result"></div>
	<script>
	document.querySelector("#btn-menus").addEventListener('click', (e)=>{
		$.ajax({
			url : "${pageContext.request.contextPath}/menu",
			method : "GET",
			success(response){
				console.log(response);
				renderTable(response, "#menus-result");
			},
			error : console.log
		});
	});
	
	const renderTable = (response, id) => {
		const container = document.querySelector(id);
		let html = `
		<table class='table'>
			<thead>
				<tr>
					<th>번호</th>
					<th>음식점</th>
					<th>메뉴명</th>
					<th>가격</th>
					<th>타입</th>
					<th>맛</th>
				</tr>
			</thead>
			<tbody>
			`;
		if(response.length){
				response.forEach((menu)=>{
					const {id, restaurant, name, price, type, taste} = menu;
					html += `
						<tr>
							<td>\${id}</td>
							<td>\${restaurant}</td>
							<td>\${name}</td>
							<td>￦\${price.toLocaleString()}</td>
							<td>
								<span class="badge badge-pill badge-\${type === 'kr' ? 'primary' : (type === 'jp' ? 'secondary' : 'warning')}">\${type}</span>	
							</td>
							<td>
								<span class="badge badge-pill badge-\${taste === 'mild' ? 'info' : 'danger'}">\${taste}</span>	
							</td>
						</tr>
					`;
				});
		}
		else{
			html += `
				<tr>
					<td class='text-center' colspan="6">검색된 결과가 없습니다.</td>
				</tr>
			`;
		}
			
		html +=`
			</tbody>
		</table>
			`;
			
		container.innerHTML = html;
	};
	</script>
	
    <div class="menu-test">
       <h4>메뉴 타입별 조회(GET)</h4>
       <select class="form-control" id="typeSelector">
           <option value="" disabled selected>음식타입선택</option>
           <option value="kr">한식</option>
           <option value="ch">중식</option>
           <option value="jp">일식</option>
           <option value="th">태국음식</option>
       </select>
    </div>
    <div class="result" id="menuType-result"></div>
    <script>
    document.querySelector("#typeSelector").addEventListener('change', (e)=> {
    	const type = e.target.value;
    	console.log(type);
    	$.ajax({
    		url : `${pageContext.request.contextPath}/menu/type/\${type}`,
    		method : "GET",
    		success(response){
    			console.log(response);
    			renderTable(response, "#menuType-result");
    		},
    		error(xhr, statusText, err){
    			if(xhr.status === 404){
    				alert("해당 타입의 메뉴가 존재하지 않습니다.");
    			}
    			else{
    				console.log(xhr, statusText, err);
    			}
    		}
    	});
    });
    </script>
    
    <div class="menu-test">
	    <h4>메뉴 타입/맛별 조회(GET)</h4>
	    <form name="menuTypeTasteFrm">
	        <div class="form-check form-check-inline">
	            <input type="radio" class="form-check-input" name="type" id="get-kr" value="kr">
	            <label for="get-kr" class="form-check-label">한식</label>&nbsp;
	            <input type="radio" class="form-check-input" name="type" id="get-ch" value="ch">
	            <label for="get-ch" class="form-check-label">중식</label>&nbsp;
	            <input type="radio" class="form-check-input" name="type" id="get-jp" value="jp">
	            <label for="get-jp" class="form-check-label">일식</label>&nbsp;
	        </div>
	        <br />
	        <div class="form-check form-check-inline">
	            <input type="radio" class="form-check-input" name="taste" id="get-hot" value="hot">
	            <label for="get-hot" class="form-check-label">매운맛</label>&nbsp;
	            <input type="radio" class="form-check-input" name="taste" id="get-mild" value="mild">
	            <label for="get-mild" class="form-check-label">순한맛</label>
	        </div>
	        <br />
	        <input type="submit" class="btn btn-block btn-outline-success btn-send" value="전송" >
	    </form>
    </div>
    <div class="result" id="menuTypeTaste-result"></div>
    <script>
    document.menuTypeTasteFrm.addEventListener('submit', (e)=>{
    	e.preventDefault();
    	
    	const type = e.target.type.value;
    	const taste = e.target.taste.value;
    	if(!type || !taste) return;
    	$.ajax({
    		url : `${pageContext.request.contextPath}/menu/type/\${type}/taste/\${taste}`,
    		success(response){
    			console.log(response);
    			renderTable(response, "#menuTypeTaste-result");
    		},
    		error(xhr, statusText, err){
    			if(xhr.status === 404){
    				alert("해당하는 조건의 메뉴가 존재하지 않습니다.");
    			}
    			else{
    				console.log(xhr, statusText, err);
    			}
    		}
    		
    	});
    });
    </script>
    
    
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>

