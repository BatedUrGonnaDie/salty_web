$(function () {
    window.create_custom_command = function(command) {
        if (command["trigger"] != "") {
            $.ajax({
                url: "/api/users/" + encodeURIComponent(command["user"]) + "/custom_commands",
                type: "POST",
                data: command,
                success: function(response) {
                    $('#new-trigger').val("");
                    $('#new-admin').prop('checked', false);
                    $('#new-limit').val("");
                    $('#new-output').val("");
                    $('#new-help-text').val("");
                },
                error: function(response) {
                    console.log("Creation of command failed with response: " + JSON.stringify(response));
                }
            });
        };
    };
});
