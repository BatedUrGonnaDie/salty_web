$(function() {
    $(".text-approve-button").click(function() {
        var text_type = $(this).data("type");
        var text_id = $(this).data("id");
        var user = $(this).data("user");

        $.ajax({
            url: "/api/users/" + encodeURIComponent(user) + "/" + encodeURIComponent(text_type) + "/" + encodeURIComponent(text_id),
            type: "PUT",
            data: "reviewed=1",
            success: function() {
                $("#approve-" + text_id).replaceWith("<div class='approve-check'>\u2713</div>")
            },
            error: function(response) {
                alert("Creation of util failed with response: " + JSON.stringify(response));
            }
        });
    })
})
