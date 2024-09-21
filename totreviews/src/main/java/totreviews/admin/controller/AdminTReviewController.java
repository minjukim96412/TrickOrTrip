package totreviews.admin.controller;

import static totreviews.common.Constants.PAGE_ADMIN_TREVIEW;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import totreviews.admin.service.AdminTReviewService;
import totreviews.common.page.PageReqDTO;
import totreviews.common.page.PageResDTO;
import totreviews.domain.TReviewResDTO;

@Controller
@RequestMapping("/admin/review")
public class AdminTReviewController {

	@Autowired
	private AdminTReviewService adminTreviewService;

	@GetMapping("/{page}")
	public String showAdminTReview(@ModelAttribute PageReqDTO pageReqDTO, Model model) {
		PageResDTO<TReviewResDTO> pagination = adminTreviewService.findTReviewListWithPaging(pageReqDTO, "all");

		model.addAttribute("pagination", pagination);

		return PAGE_ADMIN_TREVIEW;
	}

}
