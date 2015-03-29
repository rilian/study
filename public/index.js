$(document).ready(function() {
  $("input[type='checkbox']").click(function(){
    $.ajax({
      type: "PATCH",
      url: "/records/" + $(this).data("record-id"),
      dataType: "json",
      data: {
        "seen": $(this).prop("checked")
      }
    });
  });
});
