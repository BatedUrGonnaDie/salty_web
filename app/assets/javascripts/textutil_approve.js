$(function() {
    window.approve_textutil = function(util) {
        $.ajax({
            url: "/api/user/" + util["user"] + "/" + util["type"] + "/" + util["id"],
            type: "PUT",
            data: "user_id=" + encodeURIComponent(util["user"]) + "&reviewed=1",
            error: function(response) {
                console.log("Creatoin of util failed with response: " + JSON.stringify(response));
            }
        });
    };
});
