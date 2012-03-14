/*
 *  Script to make classifying easier by making hotkeys
 */

$(document).keydown(function(e){
	var highlightAndSubmit = function ( selector ) {
		var $el = $(selector);
		$el.find('input[type=submit]').css('box-shadow','0 0 5px rgba(82,168,236,.6), 0 0 10px rgba(82,168,236,.6)').prop('disabled',true);
		setTimeout(function(){ $el.submit() },250);
	}

	if ( e.keyCode == 188 ){
		highlightAndSubmit('form.edit_tweet.positive')
	} 
	else if ( e.keyCode == 190 ) {
		highlightAndSubmit('form.edit_tweet.negative');
	}
	else if ( e.keyCode == 191 ) {
		highlightAndSubmit('form.edit_tweet.unsure');
	}
});
