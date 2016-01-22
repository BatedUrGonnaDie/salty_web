$(function() {
    $(".text-delete-button").click(function() {
        var text_type = $(this).data("type");
        var text_id = $(this).data("id");
        var user = $(this).data("user");

        $.ajax({
            url: "/api/users/" + user + "/" + text_type + "/" + text_id,
            type: "DELETE",
            success: function() {
                $("#" + text_type + "-" + text_id).fadeOut(200, function() { this.remove(); });
                $('input[type="hidden"][value="' + text_id + '"]').remove();
            },
            error: function(response) {
                alert("Deletion of util failed with response: " + JSON.stringify(response));
            }
        });
    })
})
