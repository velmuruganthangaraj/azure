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
        url: updatePasswordSettingUrl,
        data: { lowerCase: lowerCase, upperCase: upperCase, number: number, specialCharacter: specialCharacters, substring: substring, minLen: minLength},
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