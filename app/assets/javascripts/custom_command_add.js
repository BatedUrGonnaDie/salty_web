$(function () {
    window.create_custom_command = function(command) {
        if (command["trigger"] != "") {
            $.ajax({
                url: "/api/users/" + command["user"] + "/custom_commands",
                type: "POST",
                data: command,
                success: function(response) {
                    // do stuff here to put in the dom
                },
                error: function(response) {
                    console.log("Creation of command failed with response: " + JSON.stringify(response));
                }
            });
        };
    };
});
