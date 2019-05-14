function checkUserImported(t) {
    var ejGrid = $("#user_import_grid").data("ejGrid");
    var gridRows = ejGrid.getRows();
    if (gridRows.length > 0) {
        messageBox("su-user-1", "[[[Import Users from CSV]]]", "[[[User import incomplete. Do you want to continue?]]]", "error", function () {
            parent.onCloseMessageBox();
            window.location.href = $(t).attr("href");
        }, function () {
            parent.onCloseMessageBox();
            return false;
        });
        return false;
    } else {
        return true;
    }
}

function SaveUserListFromCSV() {
    showWaitingPopup("server-app-container");
    $(".user-import-validation").hide();
    $("#grid-validation").css("display", "none");
    var allUserList = $("#all-user-list").val();
    var userNames = "";
    var emailIds = "";
    var gridObj = $("#user_import_grid").data("ejGrid");
    userNames = gridObj.model.dataSource[0].Username;
    emailIds = gridObj.model.dataSource[0].Email;
    for (var i = 1; i < gridObj.model.dataSource.length; i++) {
        userNames = userNames + "," + gridObj.model.dataSource[i].Username;
        emailIds = emailIds + "," + gridObj.model.dataSource[i].Email;
    }

    $.ajax({
        type: "POST",
        url: saveSelectedCSVUserUrl,
        data: "&userNames=" + userNames + "&emailIds=" + emailIds + "&AllUSerList=" + allUserList,
        success: function (result) {
            if (result.Status.toString().toLowerCase() == "true") {
                if ($.type(result) == "object" && result.Data.length != 0) {
                    var gridObj = $("#user_import_grid").data("ejGrid");
                    gridObj.showColumns("Error");
                    gridObj.dataSource(result.Data);
                    $('[data-toggle="tooltip"]').tooltip();
                    hideWaitingPopup("server-app-container");
                    messageBox("su-user-1", "[[[Import Users from CSV]]]", "[[[Duplicate or invalid data is found. Please change the data accordingly and re-upload the file.]]]", "success", function () {
                        parent.onCloseMessageBox();
                    });
                    $("#import-button").attr("disabled", "disabled");
                } else {
                    $(".import-file #user-import-validation-msg").css("display", "none");
                    $("#user_import_grid").ejGrid("option", { dataSource: [] });
                    var messageText = result.activation == 0 ? " [[[User(s) has been added and activated successfully.]]]" : " [[[User(s) has been added successfully.]]]";
                    messageBox("su-user-1", "[[[Import Users from CSV]]]", result.Count + messageText, "success", function () {
                        parent.onCloseMessageBox();
                        window.location.href = userPageUrl;
                    });
                    $("#import-button").attr("disabled", "disabled");
                    hideWaitingPopup("server-app-container");
                }
            } else {
                $(".message-content").css("margin-top", "19px");
                messageBox("su-user-1", "[[[Import Users from CSV]]]", result.Message, "success", function () {
                    parent.onCloseMessageBox();
                });
                hideWaitingPopup("server-app-container");
            }
        }
    });
}

$(document).on("click", "#trigger-file,#filename", function () {
    $("#filename").trigger("focus");
    $("#grid-validation-messages span").css("display", "none");
    $("#csvfile").trigger("click");
});

$(document).on("change", "#csvfile", function (e) {
    var value = $(this).val();
    if ($(this).val().substring($(this).val().lastIndexOf(".") + 1) != "csv") {
        $("#csv-upload").attr("disabled", true);
        $("#filename").val("[[[Please upload a valid csv file.]]]").css("color", "#c94442");
        $("#filename,#trigger-file").addClass("error-file-upload");
    } else {
        $("#csv-upload").attr("disabled", false);
        $("#filename,#trigger-file").removeClass("error-file-upload");
        $("#filename").val(value).css("color", "#333");
        $("#csvfile").attr("title", value);
    }
});
