$(document).on('click', ".reply img", function () {
  var focus_comment_box = $("#comment_content").focus();
  var mention = $(this).data('mention');
  var current_content = $("#comment_content").val();
  var new_current = '';
  if (current_content.length > 0)
    new_current = current_content + "\n" + mention + '';
  else
    new_current = mention + '';
  focus_comment_box.val(new_current);
});


$(document).on('click', ".markdown_link", function () {
  var ele = document.getElementById("markdown_examples").style;
  var display = ele.display;
  if (display == "none")
    ele.display = "";
  else
    ele.display = "none";
});
