$('.w-dyn-item .ingredient-list-test').each(

  function(index, element) {

    var _this = $(element);

    var text = _this.text();

   // console.log(_this.parent().parent().parent());

     //var select = text.indexOf(' ') == -1 ? text.length : text.indexOf(' '); 

  //  var className = text.substr(0, select);

  var className =  text.toLowerCase().split(',');

    for (var i = className.length - 1; i >= 0; i--) {

      className[i] = className[i].replace(/\s/g, ''); 
    };


  console.log(className.join(' '));
       
    _this.parent().parent().parent().addClass(className);
   
  }
);


$('.w-form-label').each(
  function() {
    var catName = $(this).text();

      $(this).parent().children().attr('value', catName.toLowerCase());
   
});



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

      //console.log($(this).find('input'));

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
   //console.log(self.outputArray); 
var countChecked = function(checkedList) {


//var checkedList =  checkedList;

/*
 $( "input:checked" ).each(

  function() {

   checkedList.push($(this).attr('value'));

});
*/

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


   //console.log(checkedList)
   //console.log(ingredientList)

   var sort = Number(result.length/ingredientList.length)

   $(this).parent().parent().parent().attr('value', sort);


  // console.log(result.length + '/' + ingredientList.length)
   //console.log($(this).parent().parent().parent().attr('value'));

   //console.log(result.length + '/' + ingredientList.length)

});
  };

//countChecked(self.outputArray);
 
//( "input[type=checkbox]" ).on( "change", countChecked(self.outputArray) );

/*
};
 // If the output string is empty, show all rather than none:

    //console.log(self.outputArray);

*/

          //self.$container.mixItUp('setOptions',options);

    // ^ we can check the console here to take a look at the filter string that is produced
    // Send the output string to MixItUp via the 'filter' method:
    if(self.$container.mixItUp('isLoaded')){

     // console.log(self.$container.mixItUp("getOption")); 

          countChecked(self.outputArray)


         // console.log(self.$container.mixItUp("getState"));

         self.$container.mixItUp('filter',self.outputString);

         var items = self.$container.find(".mix");

         var sortArray = []

         console.log(items);
           for (var i of items) {

            sortArray.push(i);

          }
            
       sortArray =  sortArray.sort(function(a,b){return Number(a.attributes.value.value) > Number(b.attributes.value.value) }).reverse();

        for (var i of sortArray) {

            console.log( Number(i.attributes.value.value) )

          }

          self.$container.mixItUp('sort',sortArray);

           //console.log(itemsArray.sort(function(a,b){return Number(a.attributes.value.value) > Number(b.attributes.value.value) })) 


/*
                   var items = self.$container.mixItUp("getState")["$show"].sort(function(a,b){return Number(a.attributes.value.value) > Number(b.attributes.value.value) });

         //console.log(items)

        

         

           for (var i in items) {

            console.log(i)

           }

*/      
     // self.$container.mixItUp('remix', 'all', true); 
      //,'sort','value:desc'
    }
  }
};

