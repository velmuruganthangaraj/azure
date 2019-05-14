var validateUserpassword = {
    p_policy_uppercase: function (userpassword) {
        this.name = "p_policy_uppercase";
        var re = /^(?=.*[A-Z]).+$/;
        if (re.test(userpassword))
            return "p_policy_uppercase"
    },
    p_policy_lowercase: function (userpassword) {
        this.name = "p_policy_lowercase";
        var re = /^(?=.*[a-z]).+$/;
        if (re.test(userpassword))
            return "p_policy_lowercase";
    },
    p_policy_number: function (userpassword) {
        this.name = "p_policy_number";
        var re = /^(?=.*\d).+$/;
        if (re.test(userpassword))
            return "p_policy_number"
    },
    p_policy_specialcharacter: function (userpassword) {
        this.name = "p_policy_specialcharacter";
        var re = /^(?=.*(_|[^\w])).+$/;
        if (re.test(userpassword))
            return "p_policy_specialcharacter"
    },
    p_policy_length: function (userpassword) {
        this.name = "p_policy_length";
        if (userpassword.length >= $("#ums-password-policy").attr("data-policy-minimumlength"))
           return "p_policy_length"
    },
    p_policy_partofusername: function (userpassword) {
        userpassword = userpassword.toLowerCase();
        this.name = "p_policy_partofusername";
        var userName = $("input#username").val() != undefined ? $("input#username").val().trim().toLowerCase() || undefined : undefined;
        var edit_userName = $("#user-details").attr("data-username").trim().toLowerCase() || undefined;
        var edit_name = $("#user-details").attr("data-displayname").trim().toLowerCase() || undefined;
        var edit_email = $("#user-details").attr("data-email").trim().toLowerCase() || undefined;
        if (userName != undefined)
        {
            var name = (($("input#firstname").val().trim().toLowerCase() || "") + " " + ($("input#lastname").val().trim().toLowerCase() || "")).trim() || undefined;
            var email = $("input#mailid").val().trim().toLowerCase() || undefined;
            if (userpassword.indexOf(userName) == -1 && userpassword.indexOf(name) == -1 && userpassword.indexOf(email) == -1) {
                return "p_policy_partofusername"
            }
        }
        else if (userpassword.indexOf(edit_userName) == -1 && userpassword.indexOf(edit_name) == -1 && userpassword.indexOf(edit_email) == -1)
        {
            return "p_policy_partofusername"
        }
    }
};

$.validator.addMethod("isValidPassword", function (value, element) {
    var validateMethods = new Array();
    validateMethods.push(validateUserpassword.p_policy_uppercase);
    validateMethods.push(validateUserpassword.p_policy_lowercase);
    validateMethods.push(validateUserpassword.p_policy_number);
    validateMethods.push(validateUserpassword.p_policy_specialcharacter);
    validateMethods.push(validateUserpassword.p_policy_length);
    validateMethods.push(validateUserpassword.p_policy_partofusername);
    for (var n = 0; n < validateMethods.length ; n++) {
        var currentMethodName = validateMethods[n];
        if (currentMethodName(value) != "" && currentMethodName(value) != undefined) {
            ruleName = currentMethodName(value);
            if ($('#password_policy_rules').find('li#' + ruleName + ' span').attr("class") != "su-tick") {
                $('#password_policy_rules').find('li#' + ruleName + ' span').addClass("su su-tick").removeClass("su su-close");
                $('#password_policy_rules').find('li#' + ruleName).addClass("clear-error");
                ruleName = ""
            }
        }
        else {
            ruleName = name;
            $(element).closest('div').addClass("has-error");
            if ($('#password_policy_rules').find('li#' + ruleName + ' span').attr("class") == "su-tick") {
                $('#password_policy_rules').find('li#' + ruleName + ' span').addClass("su su-close").removeClass("su-tick");
                $('#password_policy_rules').find('li#' + ruleName).removeClass("clear-error");
                ruleName = "";
            }
        }
    }
    if ($('#password_policy_rules li>span.su-tick').length == $('#password_policy_rules').find('li>span').length)
        return true;
}, "");

function passwordBoxHightlight(element) {
    var rules = "";
    $(element).closest('div').addClass("has-error");
    if ($(element).attr('id') == "new-password") {
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
}

function passwordBoxUnhightlight(element) {
    var rules = "";
    $(element).closest('div').removeClass('has-error');
    if ($(element).attr('id') == "new-password") {
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
    }
    $(element).closest('div').find(".password-validate-holder").html("");
}

function createPasswordPolicyRules() {
    if ($("#new-password").val() != '' && $("#new-password").next("ul").length == 0) {
        $("#new-password").after("<ul id='password_policy_rules'></ul>");
        $("#password_policy_rules").append("<li id='p_policy_heading'>[[[Password must meet the following requirements:]]]</li>")
        $("#ums-password-policy").attr("data-policy-minimumlength") != "" ? $("#password_policy_rules").append("<li id='p_policy_length'><span class='su su-close'></span>[[[At least ]]]" + $("#ums-password-policy").attr("data-policy-minimumlength") + "[[[ characters.]]]</li>") : ""
        $("#ums-password-policy").attr("data-policy-uppercase").toLowerCase() == "true" ? $("#password_policy_rules").append("<li id='p_policy_uppercase'><span class='su su-close'></span>[[[One uppercase.]]]</li>") : ""
        $("#ums-password-policy").attr("data-policy-lowercase").toLowerCase() == "true" ? $("#password_policy_rules").append("<li id='p_policy_lowercase'><span class='su su-close'></span>[[[One lowercase.]]]</li>") : ""
        $("#ums-password-policy").attr("data-policy-number").toLowerCase() == "true" ? $("#password_policy_rules").append("<li id='p_policy_number'><span class='su su-close'></span>[[[One numeric.]]]</li>") : ""
        $("#ums-password-policy").attr("data-policy-specialcharacter").toLowerCase() == "true" ? $("#password_policy_rules").append("<li id='p_policy_specialcharacter'><span class='su su-close'></span>[[[One special character.]]]</li>") : ""
        $("#ums-password-policy").attr("data-policy-partofusername").toLowerCase() == "true" ? $("#password_policy_rules").append("<li id='p_policy_partofusername'><span class='su su-close'></span>[[[Not contain part of name, user name or email address.]]]</li>") : ""
    }
    if ($("#new-password").val() == '' && $("#new-password").next("ul").length != 0) {
        $("#new-password").next("ul").remove();
    }
}