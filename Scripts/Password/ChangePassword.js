var isKeyUp = false;
$(document).ready(function () {
    var rules;

    $(".password-fields-user-profile-edit").bind("keypress", function (e) {
        if (e.keyCode == 13) {
            e.preventDefault();
            onChangePasswordClick();
            this.blur();
            return false;
        }
    });
    $("#new-password").bind("keyup", function () {
        if ($("#new-password").val() == $("#confirm-password").val()) {
            $("#confirm-password").closest('div').removeClass('has-error');
            $("#confirm-password").closest('div').find('span:last-child').html("");
        }
        else if ($("#confirm-password").val() != '') {
            $("#confirm-password").closest('div').addClass("has-error");
            $("#confirm-password").closest('div').next("div").find("span").html("[[[Passwords mismatch.]]]").css("display", "block");
        }
        createPasswordPolicyRules();
    });

    $('.change-password-form').validate({
        errorElement: 'span',
        onkeyup: function (element, event) {
            $("#success-message").html("");
            if (event.keyCode != 9) {
                isKeyUp = true;
                $(element).valid();
                isKeyUp = false;
            } else true;
        },
        onfocusout: function (element) { $(element).valid(); $("#success-message").html(""); },
        rules: {
            "old-password": {
                required: true
            },
            "new-password": {
                required: true,
                isValidPassword: true
            },
            "confirm-password": {
                required: true,
                equalTo: "#new-password"
            }
        },
        highlight: function (element) {
            passwordBoxHightlight(element)
        },
        unhighlight: function (element) {
            passwordBoxUnhightlight(element)
        },
        errorPlacement: function (error, element) {
            $(element).closest('div').find(".password-validate-holder").html(error.html());
        },
        messages: {
            "old-password": {
                required: "[[[Please enter your old password.]]]"
            },
            "new-password": {
                required: "[[[Please enter your new password.]]]",
            },
            "confirm-password": {
                required: "[[[Please confirm your new password.]]]",
                equalTo: "[[[Passwords mismatch.]]]"
            }
        }
    });
});

$('#new-password').on("change", function () {
    createPasswordPolicyRules();
    $("#new-password").valid();
});

function onChangePasswordClick() {
    $(".password-validate-holder").html("");
    $("#new-password-validate, #confirm-password-validate").closest("div").prev("div").removeClass("has-error");
    var isValid = true;
    isValid = $('.change-password-form').valid();

    if (isValid && $("#new-password").val() != $("#confirm-password").val()) {
        $("#confirm-password-validate").html("[[[Passwords mismatch]]]");
        $("#confirm-password-validate").closest("div").prev("div").addClass("has-error");
        isValid = false;
    }

    if (isValid == false) {
        return;
    }

    ShowWaitingProgress("#content-area", "show");
    doAjaxPost('POST', updatepasswordUrl, { oldpassword: $("#old-password").val(), newpassword: $("#new-password").val(), confirmpassword: $("#confirm-password").val() },
                 function (result) {
                     $("input[type='password']").val("");
                     ShowWaitingProgress("#content-area", "hide");
                     $("#password_policy_rules").remove();
                     $("#confirm-password-section").removeAttr("style");
                     $("#change-password-btn").css("margin-top", "0px");
                     if (!result.Data.status && result.Data.key == "password") {
                         $("#old-password-validate").html(result.Data.value);
                         $("#old-password-validate").closest("div").prev("div").addClass("has-error");
                        }
                     else {
                         SuccessAlert("[[[Update Password]]]", "[[[Password has been updated successfully.]]]", 7000);
                     }
                 }
            );
}