// 검색폼 enter key submit
$(function() {
//    $('#searchForm').each(function() {
//        $(this).find('input[type="text"]').keypress(function(e) {
//            // Enter pressed?
//            if(e.which == 10 || e.which == 13) {
//                this.form.submit();
//            }
//        });
//    });
    
    $('input[type="text"]').keypress(function(e) {
            // Enter pressed?
            if(e.which == 10 || e.which == 13) {
              $(this.form).submit();
            }
    });
});
$.validator.addMethod(
		"regex",
		function(value, element, regexp){
			//var re = new RegExp();
			return this.optional(element) || regexp.test(value);
		}, "Please check your input"
);
