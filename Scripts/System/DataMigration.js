var isNewUms = "";
var clientData;
var usernames = [];
var emails = [];

$(document).ready(function () {
    $(".startup-page-conatiner").ejWaitingPopup({ text: " " });
    $(".e-text").find(".configuration-status").remove();
    $(".e-text").append('<span class="configuration-status"></span>');
    $(".startup-page-conatiner").ejWaitingPopup();
    $(".startup-page-conatiner").ejWaitingPopup("show");

    isNewUms = $("#is-new-ums").val().toLowerCase() === "true";
    $.ajax({
        type: "POST",
        url: getClientDataUrl,
        data: { isNewUms: isNewUms },
        success: function (result) {
            $("#client-data").val(result.ClientData);
            clientData = result.ClientData;
            if (result.ShowSettingsPage) {
                renderSettingsPage(clientData);
                $(".startup-page-conatiner").ejWaitingPopup("hide");
            } else {
                callCopyClientDataMethod();
            }
        }
    });

    $.validator.addMethod("isRequired", function (value, element) {
        return !isEmptyOrWhitespace(value);
    }, "[[[Enter the username]]]");

    $.validator.addMethod("isValidUserName", function (value, element) {
        return isValidUserName(value)
    }, "[[[Invalid username.]]]");

    $("#mailsettings, #adsettings, #azuresettings, #dbsettings, #ssosettings, #timesettings").on("change", function () {
        if (isSafari) {
            $(this).find("label").toggleClass("check");
        }

        if ($(this).prop("checked")) {
            $(this).parent().parent().parent().next().val("true");
        } else {
            $(this).parent().parent().parent().next().val("false");
        }
    });

    $('#users-duplication-form').on('keyup keypress', function (e) {
        var keyCode = e.keyCode || e.which;
        if (keyCode === 13) {
            e.preventDefault();
            return false;
        }
    });

    $(document).on("change", ".global-action-email-duplicates #email-action-all", function (e) {
        var changedValue = e.target.value;
        $(".email-resolve-table select:not(#email-action-all)").next(".bootstrap-select.email-action:visible").each(function (event) {
            $(this).prev().val(changedValue).trigger("change").selectpicker("refresh");
        });
    });

    $(document).on("change", "#username-action-all", function (e) {
        var changedValue = e.target.value;
        $(".username-resolve-table select:not(#username-action-all)").next(".bootstrap-select.username-action:visible").each(function (event) {
            if ($(this).prev().find("option[value='" + changedValue + "']:disabled").length <= 0) {
                $(this).prev().val(changedValue).trigger("change").selectpicker("refresh");
            }
        });
    });

    $(document).on("click", ".panel-heading", function (e) {
        if ($(this).hasClass("collapsed"))
        {
            $(this).removeClass("uparrow").addClass("downarrow");
        }
        else {
            $(this).removeClass("downarrow").addClass("uparrow");
        }
    });
});

function renderSettingsPage(clientData) {
    $("#overwrite-settings-container").css("display", "block");
    if (clientData.IsClientMailSettingsExists) {
        if (clientData.IsUmsMailSettingsExists) {
            $("#mailsettings-div").css("display", "block");
        } else {
            $("#copy-mail-settings").val("true");
        }
    }

    if (clientData.IsClientAdSettingsExists) {
        if (clientData.IsUmsAdSettingsExists) {
            $("#adsettings-div").css("display", "block");
        } else {
            $("#copy-ad-settings").val("true");
        }
    }

    if (clientData.IsClientAzureAdSettingsExists) {
        if (clientData.IsUmsAzureAdSettingsExists) {
            $("#azuresettings-div").css("display", "block");
        } else {
            $("#copy-azure-settings").val("true");
        }
    }

    if (clientData.IsClientDbSettingsExists) {
        if (clientData.IsUmsDbSettingsExists) {
            $("#dbsettings-div").css("display", "block");
        } else {
            $("#copy-db-settings").val("true");
        }
    }

    if (clientData.IsClientSamlSettingsExists) {
        if (clientData.IsUmsSamlSettingsExists) {
            $("#ssosettings-div").css("display", "block");
        } else {
            $("#copy-sso-settings").val("true");
        }
    }

    if (!clientData.IsSameTimeZone) {
        $("#timesettings-div").css("display", "block");
    }

    $("#submit-button").addClass("settings-submit");
}

$(document).on("click", ".settings-submit", function () {
    $(".startup-page-conatiner").ejWaitingPopup("show");
    $("#overwrite-settings-container").css("display", "none");
    var isAdconflictExists = isReportServerApplication && clientData.IsClientAdSettingsExists && clientData.IsUmsAdSettingsExists;
    var isAzureAdConflictExists = isReportServerApplication && clientData.IsClientAzureAdSettingsExists && clientData.IsUmsAzureAdSettingsExists;
    var isDbConflictExists = isReportServerApplication && clientData.IsClientDbSettingsExists && clientData.IsUmsDbSettingsExists;
    var adSettingsSelectedValue = $("#ad-settings-options").val();
    var azureAdSettingsSelectedValue = $("#azure-settings-options").val();
    var dbSettingsSelectedValue = $("#db-settings-options").val();
    var data =
        {
            "overwritingData.CopyMailSettings": $('#copy-mail-settings').val().toLowerCase() === "true",
            "overwritingData.KeepBothAdSettings": isAdconflictExists ? adSettingsSelectedValue === "KeepBoth" ? true : false : false,
            "overwritingData.CopyAdSettings": isAdconflictExists ? (adSettingsSelectedValue !== "KeepBoth" ? adSettingsSelectedValue === "Overwrite" ? true : false : false) : $('#copy-ad-settings').val().toLowerCase() === "true",
            "overwritingData.KeepBothAzureAdSettings": isAzureAdConflictExists ? azureAdSettingsSelectedValue === "KeepBoth" ? true : false : false,
            "overwritingData.CopyAzureAdSettings": isAzureAdConflictExists ? (azureAdSettingsSelectedValue !== "KeepBoth" ? azureAdSettingsSelectedValue === "Overwrite" ? true : false : false) : $('#copy-azure-settings').val().toLowerCase() === "true",
            "overwritingData.CopySamlSettings": $('#copy-sso-settings').val().toLowerCase() === "true",
            "overwritingData.CopyTimeSettings": $('#copy-time-settings').val().toLowerCase() === "true",
            "overwritingData.KeepBothDbSettings": isDbConflictExists ? dbSettingsSelectedValue === "KeepBoth" ? true : false : false,
            "overwritingData.CopyDbSettings": isDbConflictExists ? (dbSettingsSelectedValue !== "KeepBoth" ? dbSettingsSelectedValue === "Overwrite" ? true : false : false) : $('#copy-db-settings').val().toLowerCase() === "true",
        };

    $.ajax({
        type: "POST",
        data: JSON.stringify(data),
        url: replaceOverwritingDataUrl,
        contentType: "application/json; charset=utf-8",
        success: function () {
            callCopyClientDataMethod();
        }
    });
});

function callCopyClientDataMethod() {
    $.ajax({
        type: "POST",
        url: copyClientDataUrl,
        data: { isNewUms: isNewUms },
        success: function (result) {
            if (result.HasDuplicates) {
                usernames = result.UsernameDuplicates;
                emails = result.EmailDuplicates;
                renderDuplicatesPage();

                if (emails.length > 0 || usernames.length > 0) {
                    if ($(".email-resolve-table select:not(#email-action-all)").next(".bootstrap-select.email-action:visible").length <= 0 && $(".username-resolve-table select:not(#username-action-all)").next(".bootstrap-select.username-action:visible").length <= 0) {
                        $("#system-settings-general").hide();
                        resolvedUsersSubmit();
                    }
                    else {
                        $("#duplicate-user-count").text(emails.length + usernames.length);
                        $(".startup-page-conatiner").ejWaitingPopup("hide");
                    }
                }
                else {
                    $("#duplicate-user-count").text(emails.length + usernames.length);
                    $(".startup-page-conatiner").ejWaitingPopup("hide");
                }
            } else {
                window.location = redirectionUrl;
            }
        }
    });
}

function renderDuplicatesPage() {
    $("#resolve-duplicates-container").css("display", "block");
    $("#system-settings-general").css("width", "70%");
    $("#email-action-all, #username-action-all").selectpicker("hide");
    if (emails.length > 0) {
        $("#duplicate-email-accordion, #email-label, .email-resolve-table").css("display", "block");
        for (var i = 0; i < emails.length; i++) {
            var maxLen = usernames.length > 0 ? 4 : 6;
            if (i === maxLen) {
                $(".email-data-div").css("max-height", $(".email-data-div").height()).addClass("scroll-class");
            }
            $(".email-data-div").append("<div id='email-data-row-" + i + "' class='email-data-row col-xs-12'><input type='hidden' id='email-dup-value-" + i + "' value='" + emails[i].DuplicateValue + "'/><div id='ums-email-div-" + i + "' class='ums-email-div col-xs-3'><div class='col-xs-12 data-row-display-name'>" + emails[i].UmsUser.DisplayName + "</div><div class='col-xs-12'>" + emails[i].UmsUser.UserName + "</div><div class='col-xs-12 data-row-display-email'>" + emails[i].UmsUser.Email + "</div></div><div class='col-xs-1 divider'><div class='divider-line'></div></div><div id='client-email-div-" + i + "' class='client-email-div col-xs-4'><div class='col-xs-12 data-row-display-name'>" + emails[i].ClientUser.DisplayName + "</div><div class='col-xs-12'>" + emails[i].ClientUser.UserName + "</div><div class='col-xs-12 data-row-display-email'>" + emails[i].ClientUser.Email + "</div></div><div id='email-action-div-" + i + "' class='email-action-div col-xs-4'>" + getActionElemet(i, true) + "</div></div>");
            $(".selectpicker").selectpicker("refresh");
            if (!(emails[i].IsEditableUms && emails[i].IsEditableClient)) {
                $("#email-action-" + i).next(".bootstrap-select").css("display", "none");
                $("#email-data-row-" + i).hide();
            }
        }

        if ($(".email-resolve-table select:not(#email-action-all)").next(".bootstrap-select.email-action:visible").length > 0) {
            $("#email-action-all").selectpicker("show");
        }
        else {
            $("#duplicate-email-accordion, #email-label, .email-resolve-table").css("display", "none");
        }
    }

    if (usernames.length > 0) {
        $("#duplicate-username-accordion, #username-label, .username-resolve-table").css("display", "block");
        for (var i = 0; i < usernames.length; i++) {
            var maxLen = emails.length > 0 ? 4 : 6;
            if (i === maxLen) {
                $(".username-data-div").css("max-height", $(".username-data-div").height()).addClass("scroll-class");
            }
            $(".username-data-div").append("<div id='username-data-row-" + i + "' class='username-data-row col-xs-12'> <input type='hidden' id='username-dup-value-" + i + "' value='" + usernames[i].DuplicateValue + "'/> <div id='username-ums-div-" + i + "' class='ums-username-div col-xs-3'><div class='col-xs-12 data-row-display-name'>" + usernames[i].UmsUser.DisplayName + "</div><div id='ums-username-field-" + i + "' class='col-xs-12'>" + usernames[i].UmsUser.UserName + "</div><div class='col-xs-12'>" + usernames[i].UmsUser.Email + "</div></div><div class='col-xs-1 divider'><div class='divider-line'></div></div><div id='username-client-div-" + i + "' class='client-username-div col-xs-4'><div class='col-xs-12 data-row-display-name'>" + usernames[i].ClientUser.DisplayName + "</div><div id='client-username-field-" + i + "' class='col-xs-12'>" + usernames[i].ClientUser.UserName + "</div><div class='col-xs-12'>" + usernames[i].ClientUser.Email + "</div></div> <div id='username-action-div-" + i + "' class='username-action-div col-xs-4'> " + getActionElemet(i, false) + " </div> </div>");
            addChangeFunctionToUsernameAction(i);
            $(".selectpicker").selectpicker("refresh");
            if (!usernames[i].IsEditableUms && !usernames[i].IsEditableClient) {
                $("#username-action-" + i).next(".bootstrap-select").css("display", "none");
                $("#username-data-row-" + i).hide();
            }
        }

        if ($(".username-resolve-table select:not(#username-action-all)").next(".bootstrap-select.username-action:visible").length > 0) {
            $("#username-action-all").selectpicker("show");
        }
        else {
            $("#duplicate-username-accordion, #username-label, .username-resolve-table").css("display", "none");
        }
    }

    $("#submit-button").removeClass("settings-submit").addClass("users-submit");
}

function getActionElemet(i, isEmail) {
    var element = "";
    if (isEmail) {
        element = "<select id='email-action-" +
            i +
            "' class='selectpicker email-action' data-width='40%'> <option class='no-margin-dropdown-ul' value='Ignore'>[[[Use UMS]]]</option> <option class='no-margin-dropdown-ul' value='Merge' " +
            ((emails[i].IsEditableUms && !emails[i].IsEditableClient) ? "selected='true'" : "") +
            ">[[[Use client]]]</option> </select>";

        if (!emails[i].IsEditableUms) {
            element = element + "[[[UMS user will be mapped to client.]]]";
        } else {
            if (!emails[i].IsEditableClient) {
                element = element + "[[[Client user will replace UMS user.]]]";
            }
        }
    } else {
        element = "<select id='username-action-" +
            i +
            "' class='selectpicker username-action' data-width='40%'> <option class='no-margin-dropdown-ul' value='Ignore'>[[[Ignore client]]]</option> <option class='no-margin-dropdown-ul' value='EditUms' " +
            ((usernames[i].IsEditableUms) ? "" : "disabled='true'") +
            ">[[[Edit UMS]]]</option> <option class='no-margin-dropdown-ul' value='EditClient' " +
            (usernames[i].IsEditableClient ? "" : "disabled='true'") +
            ">[[[Edit client]]]</option><option class='no-margin-dropdown-ul' value='KeepBoth' " +
            (usernames[i].IsEditableClient ? "" : "disabled='true'") +
            ">[[[Keep both]]]</option></select>";

        if (!usernames[i].IsEditableUms && !usernames[i].IsEditableClient) {
            element = element + "[[[Client user will be ignored.]]]";
        }
    }

    return element;
}

function addChangeFunctionToUsernameAction(id) {
    $("#username-action-" + id).on("change", function () {
        var id = $(this)[0].id.replace("username-action-", "");
        if ($(this).val() === "EditUms") {
            $("#ums-username-field-" + id).html("<input type='text' id='edit-val-" + id + "' class='form-control edit-val' value='" + $("#username-dup-value-" + id).val() + "'/><span class='edit-val-validation'></span>");
            $("#client-username-field-" + id).html($("#username-dup-value-" + id).val());
            validateDialogbox("#edit-val-" + id);
            $("#edit-val-" + id).parent().css("padding-right", "10px");
        }
        else if ($(this).val() === "EditClient" || $(this).val() === "KeepBoth") {
            $("#client-username-field-" + id).html("<input type='text' id='edit-val-" + id + "' class='form-control edit-val' value='" + $("#username-dup-value-" + id).val() + ($(this).val() === "KeepBoth" ? (Math.floor(Math.random() * 90000) + 10000) : "") + "'/><span class='edit-val-validation'></span>");
            $("#ums-username-field-" + id).html($("#username-dup-value-" + id).val());
            validateDialogbox("#edit-val-" + id);
            $("#edit-val-" + id).parent().css("padding-right", "10px");
        } else {
            $("#ums-username-field-" + id + ", #client-username-field-" + id).html($("#username-dup-value-" + id).val());
            $("#ums-username-field-" + id + ", #client-username-field-" + id).css("padding-right", "");
        }
    });
}

$(document).on("click", ".users-submit", function () {
    resolvedUsersSubmit();
});

function resolvedUsersSubmit() {
    $(".startup-page-conatiner").ejWaitingPopup("show");
    var users = [];
    for (var i = 0; i < usernames.length; i++) {
        var data =
            {
                "DuplicateType": "Username",
                "DuplicateValue": $("#username-dup-value-" + i).val(),
                "Action": $("#username-action-" + i).val(),
                "EditedValue": $("#edit-val-" + i).val()
            };
        users[i] = data;
    }
    var usersLength = users.length;
    for (var i = 0; i < emails.length; i++) {
        var data =
            {
                "DuplicateType": "Email",
                "DuplicateValue": $("#email-dup-value-" + i).val(),
                "Action": $("#email-action-" + i).val()
            };
        users[usersLength + i] = data;
    }

    $.ajax({
        type: "POST",
        data: JSON.stringify(users),
        url: updateResolvedUsersUrl,
        async: true,
        crossDomain: true,
        contentType: "application/json; charset=utf-8",
        success: function (result) {
            if (result.HasDuplicates) {
                $(".startup-page-conatiner").ejWaitingPopup("hide");
                var errIds = result.ErrorIdList;
                for (var i = 0; i < errIds.length; i++) {
                    $("#edit-val-" + errIds[i]).addClass("has-error");
                    $("#edit-val-" + errIds[i]).next("span.edit-val-validation").html("[[[Duplicate Username.]]]");
                }
            } else {
                window.location = redirectionUrl;
            }
        }
    });
}

function validateDialogbox(id) {
    $("#users-duplication-form").validate({
        errorElement: "div",
        onkeyup: function (element, event) {
            if (event.keyCode != 9) {
                isKeyUp = true;
                $(element).valid();
                isKeyUp = false;
            }
            else
                true;
        },

        onfocusout: function (element) { $(element).valid(); },

        highlight: function (element) {
            $(element).addClass("has-error");
        },

        unhighlight: function (element) {
            $(element).removeClass("has-error");
            $(element).next("span.edit-val-validation").html("");
        },

        errorPlacement: function (error, element) {
            $(element).next("span.edit-val-validation").html(error.html());
        }
    });

    $(id).rules("add", {
        isRequired: true,
        isValidUserName: true,
        messages: {
            isRequired: "[[[Please enter username.]]]"
        }
    });
}

function isValidUserName(userName) {
    var filter = /^[A-Za-z0-9][A-Za-z0-9]*([._-][A-Za-z0-9]+){0,3}$/;
    return filter.test(userName);
}