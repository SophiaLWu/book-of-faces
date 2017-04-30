$(document).ready(function() {
  $(".edit-post").on("click", function() {
    console.log("here");
    var postId = $(this).data("post-id");
    $.ajax({
      url: "/posts/" + postId + "/edit",
      type: "GET",
      dataType: "html",
      success: function(response) {
        $("body").append(response);
        var xOffset = -parseInt($(".edit-container").css("width"), 10) / 2;
        var yOffset = -parseInt($(".edit-container").css("height"), 10) / 2;
        $(".edit-container").css({  "margin-top": yOffset + "px",
                                   "margin-left": xOffset + "px" });
      },
      error: function() {
        alert("Error occured. Please try again.");
      }
    });
  });

  $(".edit-comment").on("click", function() {
    console.log("here");
    var commentId = $(this).data("comment-id");
    var postId = $(this).data("post-id");
    $.ajax({
      url: "/posts/" + postId + "/comments/" + commentId + "/edit",
      type: "GET",
      dataType: "html",
      success: function(response) {
        $("body").append(response);
        var xOffset = -parseInt($(".edit-container").css("width"), 10) / 2;
        var yOffset = -parseInt($(".edit-container").css("height"), 10) / 2;
        $(".edit-container").css({  "margin-top": yOffset + "px",
                                   "margin-left": xOffset + "px" });
      },
      error: function() {
        alert("Error occured. Please try again.");
      }
    });
  });

});