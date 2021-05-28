$(function() {
    window.delete_custom_command = function(command) {
        $.ajax({
            url: "/api/users/" + encodeURIComponent(command["user"]) + "/custom_commands/" + encodeURIComponent(command["trigger"]),
            type: "DELETE",
            success: function() {
                $("#ccustom-" + command["id"]).fadeOut(200, function() { this.remove(); });
                $('input[type="hidden"][value="' + command["id"] + '"]').remove();
            },
            error: function(response) {
                console.log("Deletion of command failed with response: " + JSON.stringify(response));
            }
        });
    };
});
