$(document).ready(function () {
    $("#body").ejWaitingPopup();
    if ($("#user-settings-container").is(":visible")) {
        if (location.hash != null && location.hash != "" && $("#user-settings-container .panel-title a").attr("href") != location.hash) {
            $("a[href= '" + location.hash + "']").trigger("click");
        }
    }

    $(document).on("click", ".css-radio", function () {
        $(this).siblings("label").removeClass("notransition");
    });
});

$(document).on("change", "input[name='activation']", function () {
    var checkedVal = $("input[name='activation']:checked").val().toLowerCase();
    var emailValidationMsg = $(".email-settings-validation");

    if (checkedVal === "emailactivation") {
        $.ajax({
            type: "POST",
            url: window.checkMailSettingUrl,
            success: function (result) {
                if (result.result === "success") {
                    emailValidationMsg.addClass("hide");
                }
                else if (result.result === "failure" && result.isAdmin === true) {
                    emailValidationMsg.html("[[[Activation emails cannot be sent until the email settings are configured. You can select Automatic Activation to activate the user without configuring email settings.]]]").removeClass("hide");
                }
            }
        });
    }
    else {
        emailValidationMsg.addClass("hide");
    }
});

$(document).on("click", "#update-user-settings", function () {
    $(".confirmationMessage").html("");

    var userSettings = {
        ActivationType: $("input:radio[name=activation]:checked").val()
    };
    $("#body").ejWaitingPopup("show");
    $.ajax({
        type: "POST",
        url: window.saveUserSettingsUrl,
        data: { userSettingsData: userSettings },
        success: function (result) {
            if (result.status) {
                SuccessAlert("[[[User Settings]]]", "[[[Settings have been updated successfully.]]]", 7000);
            } else {
                WarningAlert("[[[User Settings]]]", "[[[Error while updating settings.]]]", 7000);
            }
            $("#body").ejWaitingPopup("hide");
        }
    });
});

$(document).ready(function () {
    $("#body").ejWaitingPopup();
    $("#min-len").ejNumericTextbox({ name: "numeric", minValue: 6, maxValue: 255, width: "65px", height: "34px" });
});

$(document).on("click", "#update-password-settings", function () { 
    var upperCase = $("#upper-case").prop("checked");
    var lowerCase = $("#lower-case").prop("checked");
    var number = $("#numeric").prop("checked");
    var specialCharacters = $("#special-characters").prop("checked");
    var substring = $("#substring").prop("checked");
    var minLength = $("#min-len").val();
    $("#body").ejWaitingPopup("show");
    $.ajax({
        type: "POST",
        url: userPasswordSettingUrl,
        data: { lowerCase: lowerCase, upperCase: upperCase, number: number, specialCharacter: specialCharacters, substring: substring, minLen: minLength },
        success: function (data) {
            if (data.result) {
                SuccessAlert("[[[Password Settings]]]", "[[[Settings have been updated successfully.]]]", 7000);
            } else {
                WarningAlert("[[[Password Settings]]]", "[[[Error while updating settings.]]]", 7000);
            }
            $("#body").ejWaitingPopup("hide");
        },
        error: function () {
            WarningAlert("[[[Password Settings]]]", "[[[Error while updating settings.]]]", 7000);
            $("#body").ejWaitingPopup("hide");
        }
    });
});