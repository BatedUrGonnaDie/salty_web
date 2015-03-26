$(function() {
    window.delete_textutil = function(util) {
        $.ajax({
            url: "/api/user/" + util["user"] + "/" + util["type"] + "/" + util["id"],
            type: "DELETE",
            error: function(response) {
                console.log("Creatoin of util failed with response: " + JSON.stringify(response));
            }
        });
    };
});
