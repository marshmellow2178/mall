/**
 * 
 */
function chkId(value){
	$.ajax({
		type : "POST", 
		url : "chkID", 
		contentType: 'application/json; charset=utf-8',
		dataType: "text",
		data : value,
		success : function(chkRs) {
			if (chkRs=='true') {	//boolean 이지만 string으로 받아옴
				$('#idMsg').text("이미 사용중인 아이디입니다");
			}else{
				$('#idMsg').text("사용가능한 아이디입니다");
			}
		}
	});
}

$(window).on("load", function(){
	$('.ctgr').each(function(index, item){
		if($(item).attr('href')==$(location).attr('pathname').substr(1)){
			$(item).addClass('active');
		}
	});
});

