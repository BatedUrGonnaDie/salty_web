$(function() {
    window.approve_textutil = function(util) {
        $.ajax({
            url: "/api/users/" + util["user"] + "/" + util["type"] + "/" + util["id"],
            type: "PUT",
            data: "&reviewed=1",
            success: function() {
                $("#approve-" + util["id"]).replaceWith("<div class='approve-check'>\u2713</div>")
            },
            error: function(response) {
                console.log("Creation of util failed with response: " + JSON.stringify(response));
            }
        });
    };
});
