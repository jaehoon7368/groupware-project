$(document).foundation()

$('[data-app-dashboard-toggle-shrink]').on('click', function(e) {
  e.preventDefault();
  $(this).parents('.app-dashboard').toggleClass('shrink-medium').toggleClass('shrink-large');
});
  
$("p.title").on('click',function(){
  $(this).next(".con").slideToggle(100);
});
