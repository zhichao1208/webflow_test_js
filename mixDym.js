$('.w-dyn-item .categ').each(

  function(index, element) {
    var _this = $(element);
    var text = _this.text();
    var select = text.indexOf(' ') == -1 ? text.length : text.indexOf(' '); 
    var className = text.substr(0, select);
    _this.parent().addClass(className.toLowerCase());
  }
);
//Here we use class of that text field with the category name (reference field). Don't forget to change '.categ' if you used different class name.

//- Adding data-filter attributes for dynamic filters (for the categories)

$('#dyn-filter-menu > div').each(
	function() {

		var catName = "." + $(this).children('a').text();

    $(this).attr('data-filter', catName.toLowerCase());
});
// Here we used ID of dynamic list "Categories". Don't forget to change '#dyn-filter-menu' if you used different ID.

//- Initializing MixItUp plugin when page is loading

  $(document).ready(function() {
		$(function(){

			$('#container').mixItUp(); 
      
    });
  });
// Don't forget to change #container if your will use another ID.
