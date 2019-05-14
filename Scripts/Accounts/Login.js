var userAgent = navigator.userAgent;
var regexIe8 = new RegExp("Trident(\/4.0)|(Trident\/5.0)");
var isSafari = navigator.userAgent.indexOf('Safari') != -1 && navigator.userAgent.indexOf('Chrome') == -1;
var isFirefox = navigator.userAgent.toLowerCase().indexOf('firefox') != -1;
var ruleName, rules, needMargin = true;
var containerAdjusted;

$(document).ready(function () {
    $("body").ejWaitingPopup();
    $("body").ejWaitingPopup("show");
    $("body").ejWaitingPopup("hide");
    removePlaceholder();
    addPlacehoder("body");
    $("#re-password,#new-password").bind("keyup", function (event) {
        if ($(this).attr('id').match($("#new-password"))) {
            if ($("#re-password").val() != '' && $("#new-password").val() == $("#re-password").val()) {
                $("#re-password").closest('div').removeClass("has-error");
                $("#re-password").closest('div').find(">.validation-messages").html("");
            }
            else if ($("#re-password").val() != '') {
                $("#re-password").closest('div').addClass("has-error");
                $("#re-password").closest('div').find(">.validation-messages").html("[[[Passwords mismatch]]]");
            }
            createPasswordPolicyRules();
        }

        if (event.keyCode == 13) {
            $("#save-activate").click();
            this.blur();
            return false;
        }
        if ($("#save-activate").length > 0) {
            $(".succes-tick").css("left", "0").css("top", "9px");
        }
    });

    $("#login-username, #login-password").bind("keyup", function (event) {
        if (regexIe8.test(userAgent) && needMargin) {
            $(".login-fields").css("margin-top", "40px");
        }
    });

    if (i_am_ie9) {
        $(".login-container").addClass("height-adjust");
    }
    else {
        $(".login-container").removeClass("height-adjust");
    }

    $("#save-activate").on('click', function () {
        if ($("#update-password-form").valid() && $("#new-password").val() != '' && $("#re-password").val() != '') {
            $("body").ejWaitingPopup("show");
            $.ajax({
                type: "POST",
                url: passwordActivateUrl,
                data: { UserId: $("#userid").val(), Password: $("#new-password").val() },
                success: function (data, result) {
                    if (data != 'Failure') {
                        $('#account-activation').remove();
                        $(".account-activation-title").css("display", "block");
                        $(".float-center").css("display", "none");
                    } else {
                        $("#new-password, #re-password").val("");
                    }
                    $("body").ejWaitingPopup("hide");
                }
            });
        }
    });

    $.validator.addMethod("additionalSpecialCharValidation", function (value, element) {
        if (/^[a-zA-Z_0-9`~!\$\^()=\-\.\{\} ]+$/.test(value) || value === "") {
            return true;
        }
    }, "[[[Please avoid special characters.]]]");

    $("#update-password-form").validate({
        onkeyup: function (element, event) {
            if (event.keyCode != 9) {
                isKeyUp = true;
                $(element).valid();
                isKeyUp = false;
            }
            else true;
        },
        onfocusout: function (element) { $(element).valid(); },
        rules: {
            "password": {
                required: true,
                isValidPassword: true
            },
            "re-password": {
                required: true,
                equalTo: "#new-password"
            }
        },
        messages: {
            "password": {
                required: "[[[Please enter new password.]]]"
            },
            "re-password": {
                required: "[[[Please confirm new password.]]]",
                equalTo: "[[[Passwords mismatch.]]]"
            }
        },
        highlight: function (element) {
            passwordBoxHightlight(element);
        },
        unhighlight: function (element) {
            passwordBoxUnhightlight(element);
            $(element).closest('div').next("div").find("span").html("");
        },
        errorElement: 'span',
        errorPlacement: function (error, element) {
            $(element).closest('div').next("div").find("span").html(error.html());
            $("body").ejWaitingPopup("hide");
        }
    });

    $('#new-password').on("change", function () {
        createPasswordPolicyRules();
        $("#new-password").valid();
    });

    $("#forgot-password-form").validate({
        errorElement: "span",
        onkeyup: function (element, event) {
            if (event.keyCode != 9) $(element).valid();
            else true;
        },
        onfocusout: function (element) { $(element).valid(); },
        rules: {
            "key": {
                required: true
            }
        },
        highlight: function (element) {
            $(element).closest(".forgot-form-input-field").addClass("has-error");
        },
        unhighlight: function (element) {
            $(element).closest(".forgot-form-input-field").removeClass("has-error");
            $(element).parent().find("p.validation-holder").html("");
        },
        errorPlacement: function (error, element) {
            $(element).parent().find("p.validation-holder").html(error);
        },
        messages: {
            "key": {
                required: "[[[Please enter username or email address.]]]"
            }
        }
    });

    $('#forgot-password-form').validate({
        onkeyup: function (element) {
            $("#username-validation").addClass("hide");
        }
    });
    if (regexIe8.test(userAgent)) {
        $("#drop-down").css("margin-top", "-10px");
        if (window.innerWidth > 1400) {
            if ($("#windows-login").length > 0) {
                $(".login-form").css("margin-bottom", "-80px");
                $("#login-button").css("margin-top", "10px");
            }
            else {
                $(".login-form").css("margin-bottom", "-50px");
                $("#login-button").css("margin-top", "10px");
            }
        }
        else {
            if ($("#windows-login").length > 0) {
                $(".login-form").css("margin-bottom", "-80px");
                $("#login-button").css("margin-top", "10px");
            }
            else {
                $(".login-form").css("margin-bottom", "-50px");
            }
        }
        $(".pwd-success").parent().css("margin-bottom", "25px");
    }
    else {
        if ($("#windows-login").length > 0) {
            if (window.innerWidth < 1400) {
                $(".login-form").css("margin-bottom", "0px");
            }
        }
        else {
            $(".login-form").css("margin-bottom", "0px");
        }
    }

    if ($(".submit-button").length > 0) {
        if (window.innerWidth < 1400) {
            $(".login-form").css("margin-bottom", "-40px");
        }
        else {
            $(".login-form").css("margin-bottom", "-50px");
        }
    }

    $("#remember-me").on("click", function () {
        if (isSafari) {
            $(this).find("label").toggleClass("check");
        }
    });

    $(document).on("click", ".submit-button, .forgot-pwd-link, #mail-resend, .redirect-login", function () {
        $("body").ejWaitingPopup("show");
    });

    $("#new-password").bind("keyup", function () {
        if ($("#re-password").val() != '' && $("#new-password").val() == $("#re-password").val()) {
            $("#re-password").closest('div').removeClass('has-error');
            $("#re-password").closest('div').next("div").find("span").html("");
        }
        else if ($("#re-password").val() != '') {
            $("#re-password").closest('div').addClass("has-error");
            $("#re-password").closest('div').next("div").find("span").html("[[[Passwords mismatch.]]]");
        }
        createPasswordPolicyRules();
        setTimeout(function () {
            if (window.IsChangePasswordPage) {
                refreshChangePasswordFooter();
            }
            else if (window.AccountActivationPage) {
                refreshActivationPageFooter();
            }
        }, 500);
        if ($("#re-password").val() != "" && $("#new-password").val() != "" && !$("#re-password").closest('div').hasClass("has-error") && !$("#new-password").closest('div').hasClass("has-error")) {
            $(".update-button").prop('disabled', false);
            $(".update-button").prop("title", "");
        }
        else {
            $(".update-button").prop("disabled", true);
            $(".update-button").prop("title", "[[[Please enter the password]]]");
        }
    });

    $("#re-password").bind("keyup", function () {
        if ($("#re-password").val() != "" && $("#new-password").val() != "" && !$("#re-password").closest('div').hasClass("has-error") && !$("#new-password").closest('div').hasClass("has-error")) {
            $(".update-button").prop('disabled', false);
            $(".update-button").prop("title", "");
        }
        else {
            $(".update-button").prop("disabled", true);
            $(".update-button").prop("title", "[[[Please enter the password]]]");
        }
    });
});

$('#login-username, #login-password').on('change', function () {
    if ($(this).val() != '') {
        $(this).next(".placeholder").removeClass("show").addClass("hide");
    }
});

function FormValidate() {
    if ($("#login-form").valid()) {
        $("body").ejWaitingPopup("show");
    }
    $("#access-denied").html("<span class='su su-login-error'></span> [[[Access is denied]]]");
    $("#access-denied, #validate-azure-user, #validate-ad-user").css("display", "none");
    return $("#login-form").valid();
}

$(document).on("click", "#login-button-windows", function () {
    $(this).attr("disabled", true);
    $("#access-denied").html("<span class='su su-login-error'></span> [[[Access is denied]]]");
    $("#access-denied, #validate-azure-user, #validate-ad-user").css("display", "none");
    var redirectUrl = rootUrl + (window.location.href.search("authorization") === -1
        ? "/windowsauthentication/account/login"
        : "/windowsauthentication/account/oauthlogin?client_id=" + $("#client-id-windows-auth").val());
    $.ajax({
        type: "GET",
        url: redirectUrl,
        data: {},
        cache: false,
        contentType: "application/json; charset=utf-8",
        statusCode: {
            401: function () {
                $("body").ejWaitingPopup("hide");
                $("#access-denied").css("display", "block");
            },
            503: function () {
                $("body").ejWaitingPopup("hide");
                $("#access-denied").html("<span class='su su-login-error'></span> [[[Service UnAvailable]]]");
                $("#access-denied").css("display", "block");
            },
            500: function () {
                $("body").ejWaitingPopup("hide");
                $("#access-denied").css("display", "block");
            },
            404: function () {
                $("body").ejWaitingPopup("hide");
                $("#access-denied").css("display", "block");
            },
            200: function (result) {
                $("body").ejWaitingPopup("hide");
                if (result.Data.Status.toString().toLowerCase() == "true") {
                    if (window.location.href.search("authorization") === -1) {
                        window.location.href = getParameterByName("ReturnUrl");
                    } else {
                        window.location.reload();
                    }
                } else {
                    $("body").ejWaitingPopup("hide");
                    if (result.Data.Data == null || result.Data.Data == "") {
                        $("#access-denied").css("display", "block");
                    } else {
                        $("#validate-ad-user").html(result.Data.Data.replace(/[''\[\]\/]/gi, ''));
                        $("#validate-ad-user").css("display", "block");
                    }
                }
            },
            304: function (result) {
                $("body").ejWaitingPopup("hide");
                if (result.responseText.toLowerCase() == "true") {
                    window.location.href = "/dashboards";
                } else {
                    $("body").ejWaitingPopup("hide");
                    ("#access-denied").html("<span class='su su-login-error'></span> [[[Service UnAvailable]]]");
                    $("#access-denied").css("display", "block");
                }
            }
        },
        complete: function (result) {
            $("#login-button-windows").attr("disabled", false);
        },
        dataType: "json",
        success: function (result) { }
    });
    return false;
});

$(window).load(function () {
    var previousQuery = window.location.search;
    var decodedQuery = decodeURIComponent(previousQuery);
    var splitedUrl = decodedQuery.split('&')[2] != undefined ? decodeURIComponent(decodedQuery.split('&')[2]) : null;
    var redirectUri = $(".forgot-pwd-link").attr("href") + (splitedUrl != null ? "?" + splitedUrl : "");
    if ($("#login-username").val() != "" && $("#login-username").val() != undefined) {
        redirectUri = redirectUri + (splitedUrl != null ? "&" : "?") + "username=" + $("#login-username").val();
    }
    $(".forgot-pwd-link").attr("href", redirectUri);
    var docWidth = window.innerWidth;
    if (docWidth < 480) {
        $(".ad-text").css('width', '80%');
    }
    if ($("#email-settings-msg").length > 0) {
        if (window.innerWidth <= 1400) {
        }
        else {
            $(".lower-divider").css("top", "40px");
            $(".forgot-password-caption").css("top", "55px");
        }
    }
    });

function textboxHighlight(element) {
    for (var i = 0; i < $('#password_policy_rules').find('li>span').length; i++) {
        if ($($('#password_policy_rules').find('li>span')[i]).attr('class') == "su-tick")
            $(element).closest('div').removeClass("has-error");
        else
            rules = "unsatisfied-rule";
    }
    if (rules != "" && rules != undefined) {
        $(element).closest('div').addClass("has-error");
        rules = "";
    }
}

function textboxUnhighlight(element) {
    for (var i = 0; i < $('#password_policy_rules').find('li>span').length; i++) {
        if ($($('#password_policy_rules').find('li>span')[i]).attr('class') != "su-tick")
            rules = "unsatisfied-rule";
        if ($($('#password_policy_rules').find('li>span')[i]).attr('class') == "su-tick")
            $(element).closest('div').removeClass("has-error");
    }
    if (rules != "" && rules != undefined) {
        $(element).closest('div').addClass("has-error");
        rules = "";
    }
    $(element).closest('div').next("div").find("span").html("");
}

function changePasswordValidation() {
    $("body").ejWaitingPopup("show");
    return $("#update-password-form").valid() && $("#new-password").val() != '' && $("#re-password").val() != '';
}

function ForgotValidate() {
    return $('#forgot-password-form').valid();
}

$(window).resize(function () {
    var docHeight = window.innerHeight;
    var docWidth = window.innerWidth;
    if (docWidth < 550) {
        $(".ad-text").css('margin-left', '10%');
    }
    else {
        $(".ad-text").css('margin-left', '0');
    }
    if ($("#password_policy_rules").length > 0) {
        if (isSafari) {
            $("#password_policy_rules").css("top", "50px");
        }
        else {
            if (window.innerWidth < 990) {
                $("#password_policy_rules").css("top", "40px");
            }
            else if (window.innerWidth < 1400) {
                $("#password_policy_rules").css("top", "70px");
            }
            else {
                $("#password_policy_rules").css("top", "80px");
            }
        }
    }
});

function IsValidUserNameOrEmail(inputString) {
    var regex = new RegExp(/[#\%\&\*\|\:\"\'\<\>\?\[\]\\\/\+]/);
    return !regex.test(inputString);
}

//IE9 placeholder support function
function addPlacehoder(object) {
    if (regexIe8.test(userAgent)) {
        $(object).find("input[type=text],input[type=password]").each(function () {
            if ($(this).val() === "") {
                $($("<div>", { "class": "placeholder", text: $(this).attr("placeholder") })).insertAfter(this).show();
            }
            else {
                $($("<div>", { "class": "placeholder", text: $(this).attr("placeholder") })).insertAfter(this).hide();
            }
        });
    }
}

$(document).on("focus", "input[type=text],input[type=password]", function () {
    if (regexIe8.test(userAgent)) {
        $(this).next(".placeholder").removeClass("show").addClass("hide");
    }
});
$(document).on("focusout", "input[type=text],input[type=password]", function () {
    if (regexIe8.test(userAgent) && $(this).val() === "") {
        $(this).next(".placeholder").removeClass("hide").addClass("show");
    }
});
$(document).on("focus", ".placeholder", function () {
    $(this).prev("input").focus();
});

function removePlaceholder() {
    if ($("#hidden-username").val() != '') {
        $("#login-username").val($("#hidden-username").val());
    }

    if ($("#forgot-username").val() != '') {
        $("#key-input").val($("#forgot-username").val());
    }
}

$("#login-form").validate({
    errorElement: "span",
    onkeyup: function (element, event) {
        if (event.keyCode != 9) $(element).valid();
        else true;
    },
    onfocusout: function (element) { $(element).valid(); },
    rules: {
        "username": {
            required: true
        },
        "password": {
            required: true
        }
    },
    highlight: function (element) {
        $(element).closest(".input-field-form").addClass("has-error");
        $("#error-username").css("display", "none");
    },
    unhighlight: function (element) {
        $(element).closest(".input-field-form").removeClass("has-error");
        $(element).parent().find("span.validation-holder").html("");
    },
    errorPlacement: function (error, element) {
        $(element).parent().find("span.validation-holder").html(error);
        $("#error-password").css("display", "none");
    },
    messages: {
        "username": {
            required: "[[[Please enter username or email address]]]"
        },
        "password": {
            required: "[[[Please enter password]]]"
        }
    }
});

function getParameterByName(name) {
    var match = RegExp('[?&]' + name + '=([^&]*)').exec(window.location.search);
    var urlValue = match && decodeURIComponent(match[1].replace(/\+/g, ' '));
    if (urlValue == null)
        urlValue = homeUrl;
    return urlValue;
}