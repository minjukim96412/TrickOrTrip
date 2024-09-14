package totreviews.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import totreviews.domain.CommentVO;
import totreviews.domain.ReportVO;

@Repository
public class CommentDAOImpl implements CommentDAO {

	@Autowired
	private SqlSession sqlSession;

	private static final String NAMESPACE = "totreviews.mapper.CommentMapper";

	@Override
	public List<CommentVO> getCommentsByReviewId(int trevid) {
		return sqlSession.selectList(NAMESPACE + ".getCommentsByReviewId", trevid);
	}

	@Override
	public CommentVO getCommentById(int commentId) {
		return sqlSession.selectOne(NAMESPACE + ".getCommentById", commentId);
	}

	@Override
	public void insertComment(CommentVO commentVO) {
		sqlSession.insert(NAMESPACE + ".insertComment", commentVO);
	}

	@Override
	public void updateTopParentId(int commentId) {
		sqlSession.update(NAMESPACE + ".updateTopParentId", commentId);
	}

	@Override
	public void editComment(int commentId, String content) {
		Map<String, Object> params = new HashMap<>();
		params.put("commentId", commentId);
		params.put("content", content);

		sqlSession.update(NAMESPACE + ".editComment", params);
	}

	@Override
	public void deleteComment(int commentId) {
		sqlSession.update(NAMESPACE + ".deleteComment", commentId);
	}

	@Override
	public void updateCommentStatus(int commentId) {
		sqlSession.update(NAMESPACE + ".updateCommentStatus", commentId);
	}

	@Override
	public void insertReportComment(ReportVO reportVO) {
		sqlSession.update(NAMESPACE + ".insertReportComment", reportVO);
	}

	@Override
	public String getUpdateDate(int commentId) {
		return sqlSession.selectOne(NAMESPACE + ".getUpdateDate", commentId);
	}

}
