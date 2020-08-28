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
    $("#follow").on("click", function(){
      $.ajax({
        url: $(this).attr("action"),
        type: "get"
      }).done(function(json){
        console.log("テスト")
        if(json.follow == "follow"){
          $("#follow").text("フォロー中");
          $("#follower").text(`フォロワー数:${json.follower}`);
          json.followers.forEach(function(follower){
            $("#follower").append(`
              <a href="${follower.link}">${follower.name}</a>
            `);
          })
        }else{
          $("#follow").text("フォローする");
          $("#follower").text(`フォロワー数:${json.follower}`);
          json.followers.forEach(function(follower){
            $("#follower").append(`
            <a href="${follower.link}">${follower.name}</a>
            `);
          })
        }
      })
    })
  })
})

