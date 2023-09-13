package com.example.demo.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.example.demo.dto.PageInfo;
import com.example.demo.entity.Faq;
import com.example.demo.entity.Inquiry;
import com.example.demo.entity.InquiryAnswer;
import com.example.demo.entity.Notice;
import com.example.demo.repository.FaqRepo;
import com.example.demo.repository.InquiryAnswerRepo;
import com.example.demo.repository.InquiryRepo;
import com.example.demo.repository.NoticeRepo;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CustomerSvc {
	private final NoticeRepo noticeRepo;
	private final FaqRepo faqRepo;
	private final InquiryRepo inquiryRepo;
	private final InquiryAnswerRepo inquiryAnswerRepo;
	
	public List<Notice> getNoticeList(String ctgr, String key, Pageable pageable, PageInfo pageInfo) {
		Page<Notice> noticePage = noticeRepo.findByCtgrContainingAndTitleContaining(ctgr, key, pageable);
		pageInfo.setPage(noticePage);
		return noticePage.getContent();
	}
	
	public Notice getNotice(int idx) {
		return noticeRepo.findByIdx(idx);
	}
	
	public void noticeRegister(String ctgr, String title, String content) {
		Notice n = Notice.builder()
				.title(title)
				.ctgr(ctgr)
				.content(content)
				.date(LocalDateTime.now())
				.build();
		noticeRepo.save(n);
	}
	
	public void noticeUpdate(int idx, String ctgr, String title, String content) {
		Notice n = noticeRepo.findByIdx(idx);
		n.setCtgr(ctgr);
		n.setTitle(title);
		n.setContent(content);
		noticeRepo.save(n);
	}
	
	public List<Faq> getFaqList(String ctgr, String key, Pageable pageable, PageInfo pageInfo) {
		Page<Faq> faqPage = faqRepo.findByCtgrContainingAndTitleContaining(ctgr, key, pageable);
		pageInfo.setPage(faqPage);
		return faqPage.getContent();
	}
	
	public Faq getFaq(int idx) {
		return faqRepo.findByIdx(idx);
	}
	
	public void faqInsert(String ctgr, String title, String content) {
		Faq f = Faq.builder()
				.ctgr(ctgr)
				.title(title)
				.answer(content)
				.date(LocalDateTime.now())
				.build();
		faqRepo.save(f);
	}
	
	public void faqUpdate(int idx, String ctgr, String title, String content) {
		Faq f = faqRepo.findByIdx(idx);
		f.setCtgr(ctgr);
		f.setTitle(title);
		f.setAnswer(content);
		faqRepo.save(f);
	}
	
	public void inquiryProcIn(String miid, String ctgr, String title, String content) {
		Inquiry iq = Inquiry.builder()
				.miid(miid)
				.ctgr(ctgr)
				.title(title.trim())
				.content(content.trim())
				.date(LocalDateTime.now())
				.build();
		inquiryRepo.save(iq);
	}
	
	public List<Inquiry> getInquiryList(String ctgr, String title, Pageable pageable, PageInfo pageInfo) {
		Page<Inquiry> inquiryPage = inquiryRepo.findByCtgrContainsAndTitleContains(ctgr, title, pageable);
		pageInfo.setPage(inquiryPage);
		return inquiryPage.getContent();
	}
	
	public Inquiry getInquiry(int idx) {
		return inquiryRepo.findByIdx(idx);
	}
	
	public List<InquiryAnswer> getInquiryAnswer(int idx){
		return inquiryAnswerRepo.findByBm(idx);
	}
	
	public void inquiryProcAnswer(int idx, String answer) {
		Inquiry i = inquiryRepo.findByIdx(idx);
		i.setIsend("y");
		inquiryRepo.save(i);
		InquiryAnswer ia = InquiryAnswer.builder()
				.bm(idx)
				.comment(answer)
				.date(LocalDateTime.now())
				.build();
		inquiryAnswerRepo.save(ia);
	}
}
