$(function() {
    window.delete_textutil = function(util) {
        $.ajax({
            url: "/api/user/" + util["user"] + "/" + util["type"] + "/" + util["id"],
            type: "DELETE",
            data: "user_id=" + encodeURIComponent(util["user"]),
            error: function(response) {
                console.log("Creatoin of util failed with response: " + JSON.stringify(response));
            }
        });
    };
});
