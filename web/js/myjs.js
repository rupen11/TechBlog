function doLike(pid, uid){
    const data = {
        pid: pid,
        uid: uid,
        operation: "Like"
    };
    
//    like request
    $.ajax({
        url: "LikeServlet",
        data: data,
        success: function (data, textStatus, jqXHR) {
            if(data.trim()=="true"){
                let count = $(".like-counter").html();
                count++;
                $(".like-counter").html(count); 
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(data);
        }
    })
};

