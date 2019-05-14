$(document).ready(function () {
    if ($("#saml-container").is(":visible")) {
        if (location.hash != null && location.hash != "" && $("#saml-container .panel-title a").attr("href") != location.hash) {
            $("a[href= '" + location.hash + "']").trigger("click");
        }
    }

    $(document).on("click", "#update-window-enable", function () {
        var windowsAuth = $("#enable-window").is(":checked");

        $.ajax({
            type: "POST",
            url: windowsSettingsUrl,
            data: { enableWindowsAuthentication: windowsAuth },
            success: function (result) {
                if (result.status) {
                    SuccessAlert("[[[Windows Authentication Settings]]]", "[[[Settings has been updated successfully.]]]", 7000);
                } else {
                    WarningAlert("[[[Windows Authentication Settings]]]", "[[[Error while updating settings.]]]", 7000);
                }
                $("#body").ejWaitingPopup("hide");
            }
        });
    });
});