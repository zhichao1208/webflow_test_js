
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

$('.w-form-label').each(
  function() {
    var catName = $(this).text();
     console.log(catName)
      $(this).parent().children().attr('value', catName.toLowerCase());
   // $(this).attr('data-filter', catName.toLowerCase());
   
});

// To keep our code clean and modular, all custom functionality 
//will be contained inside a single object literal called "checkboxFilter".
//  
// On document ready, initialise our code.
//
$(document).ready(function($){
  // Initialize checkboxFilter code
  checkboxFilter.init();
  // Instantiate MixItUp
  $('#container').mixItUp();
  controls: {
    toggleFilterButtons: true
  }
});


var checkboxFilter = {
  
  // Declare any variables we will need as properties of the object
  
  $filters: null,
  $reset: null,
  groups: [],
  outputArray: [],
  outputString: '',
  
  // The "init" method will run on document ready and cache 

  any jQuery objects we will need.
  
  init: function(){
    var self = this; // As a best practice, in each method we will asign "this" to the variable "self" so that it remains scope-agnostic. We will use it to refer to the parent "checkboxFilter" object so that we can share methods and properties between all parts of the object.
    
    self.$filters = $('#filterform');
    self.$reset = $('#reset');
    self.$container = $('#container');
    
    self.$filters.find('.cd-filter-block').each(function(){
      self.groups.push({
        $inputs: $(this).find('input'),
        active: [],
		    tracker: false
      });
    });
    
    self.bindHandlers();
  },
  
  // The "bindHandlers" method will listen for whenever a form value changes. 
  
  bindHandlers: function(){
    var self = this;
    
    self.$filters.on('change', function(){
      self.parseFilters();
    });
    
    self.$reset.on('click', function(e){
      e.preventDefault();
      self.$filters[0].reset();
      self.parseFilters();
    });
  },
  
  // The parseFilters method checks which filters are active in each group:
  
  parseFilters: function(){
    var self = this;
 
    // loop through each filter group and add active filters to arrays
    
    for(var i = 0, group; group = self.groups[i]; i++){
      group.active = []; // reset arrays
      group.$inputs.each(function(){ 
        $(this).is(':checked') && group.active.push(this.value);
      });
	    group.active.length && (group.tracker = 0);
    }
    
    self.concatenate();
  },


  // The "concatenate" method will crawl through each group, concatenating filters as desired:
  
  concatenate: function(){
    var self = this,
		  cache = '',
		  crawled = false,

combiClassName= function(){

      // Will remove all falsy values: undefined, null, 0, false, NaN and "" (empty string)
function cleanArray(actual) {
  var newArray = new Array();
  for (var i = 0; i < actual.length; i++) {
    if (actual[i]) {
      newArray.push(actual[i]);
    }
  }
  return newArray;
}
      var picks = self.outputArray

      var result = []

  var f = function(prefix, chars) {

    for (var i = 0; i < chars.length; i++) {

      result.push(prefix +',' +chars[i]);

      f(prefix  +','+chars[i], chars.slice(i + 1));

    }
  }

      f('', picks);

    //console.log("result",result)

     var  allCombis = []

     for (var i = 0; i < result.length; i++) {

      var food = cleanArray(result[i].split(','))

     food.unshift ('.mix.')  
     food.push('x')
     food.push('x')
     food.push('x')
     food.push('x')
     food.push('x')

     food = food.slice(0,6)

      //console.log(food.join(''))

      allCombis.push(food.join(''))

     }

     // console.log("allCombis",allCombis)

      return self.outputArray = allCombis;

  },

		  checkTrackers = function(){
        var done = 0;
        
        for(var i = 0, group; group = self.groups[i]; i++){
          (group.tracker === false) && done++;
        }

        return (done < self.groups.length);
      },
      crawl = function(){
        for(var i = 0, group; group = self.groups[i]; i++){
          group.active[group.tracker] && (cache += group.active[group.tracker]);

          if(i === self.groups.length - 1){
            self.outputArray.push(cache);
            cache = '';
            updateTrackers();
          }
        }
      },
      updateTrackers = function(){
        for(var i = self.groups.length - 1; i > -1; i--){
          var group = self.groups[i];

          if(group.active[group.tracker + 1]){
            group.tracker++; 
            break;
          } else if(i > 0){
            group.tracker && (group.tracker = 0);
          } else {
            crawled = true;
          }
        }
      };
    
    self.outputArray = []; // reset output array

	  do{
		  crawl();
	  }
	  while(!crawled && checkTrackers());


    combiClassName()

    self.outputString = self.outputArray.join();
    
    // If the output string is empty, show all rather than none:
    
    !self.outputString.length && (self.outputString = 'all'); 
    
        console.log("self.outputString",self.outputString); 

    // ^ we can check the console here to take a look at the filter string that is produced
    
    // Send the output string to MixItUp via the 'filter' method:
    
	  if(self.$container.mixItUp('isLoaded')){
    	self.$container.mixItUp('filter', self.outputString);
	  }
  }
};