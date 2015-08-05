$(document).ready(function() {
  $('.gallery img').wrap(function() {
    var path = $(this).attr('src');
    return "<a href='" + path + "'></a>";
  });
});
