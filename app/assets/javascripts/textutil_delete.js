$(function() {
    window.delete_textutil = function(util) {
        $.ajax({
            url: "/api/user/" + util["user"] + "/" + util["type"] + "/" + util["id"],
            type: "DELETE",
            success: function() {
                $("#" + util["type"] + "-" + util["id"]).fadeOut(200, function() { this.remove(); });
            },
            error: function(response) {
                console.log("Creatoin of util failed with response: " + JSON.stringify(response));
            }
        });
    };
});
