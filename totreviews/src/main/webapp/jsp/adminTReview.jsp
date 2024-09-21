<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="totreviews.domain.MemberVO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/global.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/review.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/adminReview.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/adminTReview.js"></script>
    <title>게시물 관리</title>
</head>
<body>
    <div class="mainDiv">
        <div class="reviewTitleDiv">
            <div class="bigTitle">게시물 관리</div>
        </div>
        <div class="reviewIntroDiv">
            <div>이 페이지는 작성된 여행 후기를 관리하는 곳입니다. 작성된 후기를 조회하고, 수정, 삭제하거나 상태를 변경할 수 있습니다.</div>
            <div>상단의 검색 및 필터 옵션을 사용해 제목, 작성자, 작성 날짜별로 쉽게 후기를 찾아보세요.</div>
			<div>후기는 '승인', '대기', '비공개' 상태로 나뉩니다. 각 상태에 따라 후기를 관리하고, 부적절한 내용이 포함된 후기는 삭제하거나 수정하세요.</div>
			<div>정기적으로 후기를 검토하여 커뮤니티의 품질을 유지하세요.</div>
        </div>
        
        <div class="searchAndWriteDiv">
        	<!-- 여행 후기 검색 및 정렬 폼 -->
        	<form id="searchForm" action="${pageContext.request.contextPath}/admin/review/1" method="get">
	            <div class="searchDiv">
	            	<!-- 여행 후기 정렬  -->
	            	<select name="sortType" aria-label="sortType select" class="select">
			            <option value="LATEST" ${page.sortType == 'LATEST' ? 'selected' : ''}>최신순</option>
			            <option value="OLDEST" ${page.sortType == 'OLDEST' ? 'selected' : ''}>오래된순</option>
			            <option value="VIEWS" ${page.sortType == 'VIEWS' ? 'selected' : ''}>조회순</option>
			            <option value="RATING" ${page.sortType == 'RATING' ? 'selected' : ''}>평점순</option>
			        </select>
	            	<!-- 여행 후기 정렬 끝 -->
	            	<!-- 여행 후기 검색 -->
	                <select name="searchType" aria-label="searchType select" class="select">
	                    <option value="ALL" ${page.searchType == 'ALL' ? 'selected' : ''}>전체</option>
	                    <option value="TITLE" ${page.searchType == 'TITLE' ? 'selected' : ''}>제목</option>
	                    <option value="CONTENT" ${page.searchType == 'CONTENT' ? 'selected' : ''}>내용</option>
                	</select>
	                <input name="search" class="searchInput" value="${page.search}" type="text" placeholder="검색어를 입력하세요.">
	                <!-- 여행 후기 검색 끝 -->
	                <button type="submit" class="initButton2">검색</button>
	            </div>
	        </form>
	        <!-- 여행 후기 검색 및 정렬 폼 끝 -->
        </div>

        <!-- 게시물 테이블 시작 -->
        <div class="table-responsive">
            <table class="adminTable">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>작성일</th>
                        <th>수정일</th>
                        <th>상태</th>
                        <th>조회수</th>
                        <th>평점</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="review" items="${pagination.postList}">
					    <tr>
					        <td>${review.trevId}</td>
					        <td><a href="${pageContext.request.contextPath}/review/all/detail/${review.trevId}">${review.trevTitle}</a></td>
					        <td>${review.memId}</td>
					        <td>${review.trevRegdate}</td>
					        <td>${review.trevUpdate}</td>
					        <td>
                                <c:choose>
                                    <c:when test="${review.trevStatus == 'CMT001'}">정상</c:when>
                                    <c:when test="${review.trevStatus == 'CMT002'}">삭제</c:when>
                                    <c:when test="${review.trevStatus == 'CMT003'}">신고</c:when>
                                    <c:when test="${review.trevStatus == 'CMT004'}">제재</c:when>
                                    <c:when test="${review.trevStatus == 'CMT005'}">수정</c:when>
                                    <c:otherwise>알 수 없음</c:otherwise>
                                </c:choose>
                            </td>
					        <td>${review.trevCount}</td>
					        <td>
					            <c:forEach var="i" begin="1" end="5">
					                <c:choose>
					                    <c:when test="${i <= review.trevRating}">
					                        <span class="star filled">⭐</span>
					                    </c:when>
					                    <c:otherwise>
					                        <span class="star">☆</span>
					                    </c:otherwise>
					                </c:choose>
					            </c:forEach>
					        </td>
					        <td>
					            <a href="${pageContext.request.contextPath}/review/edit/${review.trevId}" class="editButton">수정</a>
					        	<a href="${pageContext.request.contextPath}/review/delete/${review.trevId}" class="deleteButton" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
					        </td>
					    </tr>
					</c:forEach>
                </tbody>
            </table>
        </div>
        <!-- 게시물 테이블 끝 -->

        <!-- 페이징 버튼 -->
		<nav class="paginationNav">
		    <ul class="paginationList">
		        <!-- 처음 페이지로 이동하는 버튼 -->
	            <li class="paginationItem">
	                <a href="${pageContext.request.contextPath}/admin/review/${pagination.startBlockPage}" class="paginationLink">&laquo;</a>
	            </li>
		
		        <!-- 이전 페이지 버튼 -->
		        <c:if test="${pagination.isPrev}">
		            <li class="paginationItem">
		                <a href="${pageContext.request.contextPath}/admin/review/${pagination.currentPage - 1}" class="paginationLink">이전</a>
		            </li>
		        </c:if>
		
		        <!-- 페이지 번호 출력 -->
		        <c:forEach begin="${pagination.startBlockPage}" end="${pagination.endBlockPage}" var="pageNum">
		            <c:choose>
		                <c:when test="${pagination.currentPage == pageNum}">
		                    <li class="paginationItem active">
		                        <span class="paginationLink">${pageNum}</span>
		                    </li>
		                </c:when>
		                <c:otherwise>
		                    <li class="paginationItem">
		                        <a href="${pageContext.request.contextPath}/admin/review/${pageNum}" class="paginationLink">${pageNum}</a>
		                    </li>
		                </c:otherwise>
		            </c:choose>
		        </c:forEach>
		
		        <!-- 다음 페이지 버튼 -->
		        <c:if test="${pagination.isNext}">
		            <li class="paginationItem">
		                <a href="${pageContext.request.contextPath}/admin/review/${pagination.currentPage + 1}" class="paginationLink">다음</a>
		            </li>
		        </c:if>
		
		        <!-- 맨 끝으로 버튼 -->
	            <li class="paginationItem">
	                <a href="${pageContext.request.contextPath}/admin/review/${pagination.endBlockPage}" class="paginationLink">&raquo;</a>
	            </li>
		    </ul>
		</nav>
		<!-- 페이징 버튼 끝 -->
    </div>
</body>
</html>
