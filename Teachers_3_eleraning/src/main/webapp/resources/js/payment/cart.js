//전체 선택, 전체 취소
function toggleCheckAll() {
	//모든 체크박스가 체크되어있는지 확인
	const isAllChecked = $('.select-btn:checked').length === $('.select-btn').length;
	//전체 체크박스 상태 변경
	$('.select-btn').prop('checked', !isAllChecked);
	
	//체크 상태 변경 후, 전체 금액 계산 실행
	calculateTotalPrice();
}

//장바구니 리스트의 회색 박스 영역 클릭 시, 해당 상품의 상세 페이지로 이동
$('.list-container').click(function(e) {
	if (!$(e.target).is('.select-btn')) {
		const postNo = $(this).data('post-no');
		location.assign(`${path}/post/viewpost?postNo=`+postNo);
	}	
})

//선택된 상품의 총 금액 자동 계산
function calculateTotalPrice() {
	let totalPrice = 0;
	let totalDeliveryFee = 0;
	
	$("#purchase").parent().find("input").remove();
	
	//체크된 상품들만 계산
	$('.select-btn:checked').each(function() {
		const container = $(this).closest('.list-container');
		const productType = container.data('product-type');
		
		//상품 가격 계산
		if(productType == 1) {
			const price = parseInt(container.data('product-price')) || 0;
			const deliveryFee = parseInt(container.data('delivery-fee')) || 0;
			
			totalPrice += price;
			totalDeliveryFee += deliveryFee;
		} else if (productType == 2) {
			const filePrice = parseInt(container.data('file-price')) || 0;
			
			totalPrice += filePrice;
		}
	})
	
	console.log(totalPrice);
	console.log(totalDeliveryFee);
	
	//천 단위 콤마 포맷팅
	$('#total-product-price').text(totalPrice.toLocaleString());
	$('#total-delivery-fee').text(totalDeliveryFee.toLocaleString());
	$('#total-price').text((totalPrice + totalDeliveryFee).toLocaleString());
	
	$('#purchaseForm').append('<input type="hidden" name="totalProductPrice" value=' + totalPrice + '>');
	$('#purchaseForm').append('<input type="hidden" name="totalDeliveryFee" value=' + totalDeliveryFee + '>');
	$('#purchaseForm').append('<input type="hidden" name="totalPrice" value=' + (totalPrice+totalDeliveryFee) + '>');
}

//체크박스 변경 시, 가격 다시 계산
$(document).on('change', '.select-btn', calculateTotalPrice);

//페이지 로드 시, 초기 계산
$(document).ready(function() {
	calculateTotalPrice();
});