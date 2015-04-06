$(function() {
    window.delete_textutil = function(util) {
        $.ajax({
            url: "/api/users/" + util["user"] + "/" + util["type"] + "/" + util["id"],
            type: "DELETE",
            success: function() {
                $("#" + util["type"] + "-" + util["id"]).fadeOut(200, function() { this.remove(); });
                $('input[type="hidden"][value="' + util["id"] + '"]').remove();
            },
            error: function(response) {
                console.log("Creatoin of util failed with response: " + JSON.stringify(response));
            }
        });
    };
});
