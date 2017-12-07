
  var options  = {
    load: {
        filter: 'none'
    }
}

  $('#container').mixItUp('setOptions',options)

var checkboxFilter = {
  // Declare any variables we will need as properties of the object
  $filters: null,
  $reset: null,
  groups: [],
  outputArray: [],
  outputString: '',
  // The "init" method will run on document ready and cache 
  // any jQuery objects we will need.
  init: function(){
    var self = this; 
    // As a best practice, in each method we will
    // asign "this" to the variable "self" so that 
    // it remains scope-agnostic. We will use it 
    // to refer to the parent "checkboxFilter" 
    // object so that we can share methods and 
    // properties between all parts of the object.
    self.$filters = $('#filterform_top');
    self.$reset = $('#reset');
    self.$container = $('#container');

    self.$filters.each(function(){

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


    for(var i=0; i < self.outputArray.length; i++) {

       var item = self.outputArray[i];
       self.outputArray[i] = '.'+item

    }

           self.outputString = self.outputArray.join();
          if (self.outputString === '.') 
        { 
            self.outputString = ''; 

        }


var countChecked = function(checkedList) {

 for(var i=0; i < checkedList.length; i++) {

       var item = checkedList[i];
       checkedList[i] = checkedList[i].substr(1);

    }

  $('.ingredient-list-test').each(

  function() {

   var ingredientList =  $(this).text().split(',');

   for (var i = ingredientList.length - 1; i >= 0; i--) {

     ingredientList[i] = ingredientList[i].toLowerCase();

   };

    var result = ingredientList.filter(function(val) {
  return checkedList.indexOf(val) != -1;
});
    var other = ingredientList.filter(function(val) {
  return checkedList.indexOf(val) === -1;
});

   var sort = Number(result.length/ingredientList.length)

   $(this).parent().parent().parent().attr('value', sort);

   $(this).parent().parent().parent().attr('result', result);

    $(this).parent().parent().parent().attr('other', other);

$('.w-dyn-item .ingredient-list-show').each(

  function(index, element) {

    var _this = $(element);

    var text = _this.text();

     var result = _this.parent().parent().parent().attr('result') ;
     var other = _this.parent().parent().parent().attr('other') ;

    _this.text(result + "\n"  + other);

  }
);
});
  };


    // ^ we can check the console here to take a look at the filter string that is produced
    // Send the output string to MixItUp via the 'filter' method:
    if(self.$container.mixItUp('isLoaded')){

          countChecked(self.outputArray)

         var items = self.$container.find(".mix");

         var sortArray = []

           for (var i of items) {

            if (i.attributes.value.value > 0.45) { 

            sortArray.push(i);

          }
            
       sortArray =  sortArray.sort(function(a,b){return Number(a.attributes.value.value) > Number(b.attributes.value.value) }).reverse();

          self.$container.mixItUp('sort',sortArray);
          self.$container.mixItUp('filter',self.outputString);

    }
  }
};

