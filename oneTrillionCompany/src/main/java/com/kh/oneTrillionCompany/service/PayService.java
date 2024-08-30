package com.kh.oneTrillionCompany.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.oneTrillionCompany.dao.ItemDao;
import com.kh.oneTrillionCompany.dao.MemberDao;
import com.kh.oneTrillionCompany.dao.OrderDetailDao;
import com.kh.oneTrillionCompany.dao.OrdersDao;
import com.kh.oneTrillionCompany.dto.OrderDetailDto;
import com.kh.oneTrillionCompany.exception.TargetNotFoundException;
import com.kh.oneTrillionCompany.vo.OrderVO;

import jakarta.servlet.http.HttpSession;

@Transactional
@Service
public class PayService {
	@Autowired
	private OrdersDao ordersDao;
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private OrderDetailDao orderDetailDao;
	@Autowired
	private ItemDao itemDao;
	
	public String pay(List<OrderVO> list,  int orderNo,
			HttpSession session)  throws Exception  {
		int payment=ordersDao.selectOne(orderNo).getOrderPrice();
		String memberId=(String) session.getAttribute("createdUser");
		boolean sessionVaild=list.get(0).getBuyer().equals(memberId); //세션 유효성 검사
		if(list.size()==0&&!sessionVaild) 
			throw new TargetNotFoundException("장바구니를 확인해주세요");
		//결제
		memberDao.payment(memberId, payment);
		//주문서 생성(detail)
		List<OrderDetailDto> detailList= orderDetailDao.selectListByOrderDetail(memberId,orderNo);
		List<Integer> detailNoList=new ArrayList<>();
		for(int i=0; i<detailList.size(); i++) {
			detailNoList.add(detailList.get(i).getOrderDetailNo());
			//재고 차감
			itemDao.deductItem(detailList.get(i).getOrderDetailCnt(),detailList.get(i).getOrderDetailItemNo());
		}
		orderDetailDao.payCompleteStatus(detailNoList);
		return "redirect:payFinish?orderNo="+orderNo;
	}
}
