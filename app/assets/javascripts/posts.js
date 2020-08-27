document.addEventListener("turbolinks:load", function(){
  $(function(){
    $(".like").on("click", function(){
      $.ajax({
        url: $(this).attr("action"),
        type: "get"
      }).done(function(json){
        $(`#post${json.post}`).text(`♡${json.like}`);
        if(json.liked == "like"){
          $(`#post${json.post}`).addClass("active");
        }else{
          $(`#post${json.post}`).removeClass("active");
        }
      })
    })
  })
})

