$(function () {
    window.new_osu_key = function(user) {
        if (confirm("This will invalid your old key. Continue?")) {
            $.ajax({
                url: "/api/users/" + user + "/songs/key",
                type: "PUT",
                success: function(response) {
                    alert("Your new key is: " + response["new_key"] + "\nRefresh to update the modal.")
                },
                error: function(response) {
                    alert("There was an error creating a new key, make sure you are logged in.")
                }
            });
        };
    };
});
