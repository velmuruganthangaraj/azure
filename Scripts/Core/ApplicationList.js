var myApplicationList;
var applicationListRequest = false;
var appData = {};

$(document).on("click", ".application-navigation", function () {
    myApplicationList = "";
    if (!applicationListRequest) {
        $.ajax({
            type: "POST",
            url: window.myapplicationlistUrl,
            data: "",
            success: function (data) {
                appData = data;
                for (var i = 0; i < data.length ; i++) {
                    if (data[i].IsSelected) {
                        myApplicationList += '<li data-app-selected="' + data[i].IsSelected + '">' + '<a href= "' + data[i].Url + '" title= "' + data[i].Name + '<br/>' + data[i].Url + '" data-html="true" data-toggle="tooltip" data-container="body" data-placement="top"><img alt="Application Logo" class="app-icon" src="' + (getDefaultApplicationLogoUrl + "?applicationtype=10001") + '"><span class="app-name">' + data[i].Name + '</span></a>' + '</li>';
                    }
                    else {
                        if (data[i].Url.indexOf(',') != -1) {
                            myApplicationList += '<li data-app-selected="' + data[i].IsSelected + '"><a class="popover-link" title= "' + data[i].Name + '"role="button" data-html="true" data-toggle="popover" data-placement="right" data-content="' + getAnchorUrls(data[i].Url) + '"><img alt="Application Logo" class="app-icon" src="' + (getApplicationLogoUrl + '?id=' + data[i].ClientId) + '"><span class="app-name">' + data[i].Name + '</span></a>' + '</li>';
                        } else {
                            myApplicationList += '<li data-app-selected="' + data[i].IsSelected + '">' + '<a href= "' + data[i].Url + '" target="_blank" title= "' + data[i].Name + '<br/>' + data[i].Url + '" data-html="true" data-toggle="tooltip" data-container="body" data-placement="top"><img alt="Application Logo" class="app-icon" src="' + (getApplicationLogoUrl + '?id=' + data[i].ClientId) + '"><span class="app-name">' + data[i].Name + '</span></a>' + '</li>';
                        }
                    }
                }
                $(".app-loading-text").addClass("hidden");
                $("#application-list").html(myApplicationList);
                $("#app-list").show();
                var windowHeight = window.innerHeight;
                var headerAreaHeight = $("#header-area").height();
                $("#application-list").css('max-height', windowHeight - headerAreaHeight);
                if ($("#application-list").innerHeight() >= windowHeight - headerAreaHeight) {
                    $("#application-list").css('max-width', 340);
                }
                applicationListRequest = true;
                myApplicationList = '';
                for (var i = 0; i < data.length; i++) {
                    if (data[i].IsSelected) {
                        myApplicationList += '<li data-app-selected="' + data[i].IsSelected + '">' + '<a href= "' + data[i].Url + '" title= "' + data[i].Name + '<br/>' + data[i].Url + '" data-html="true" data-toggle="tooltip" data-container="body" data-placement=' + ($(".app-icon").parent()[i].offsetTop === $(".app-icon").parent()[0].offsetTop ? "bottom" : "top") + '><img alt="Application Logo" class="app-icon" src="' + (getDefaultApplicationLogoUrl + "?applicationtype=10001") + '"><span class="app-name">' + data[i].Name + '</span></a>' + '</li>';
                    }
                    else {
                        if (data[i].Url.indexOf(',') != -1) {
                            myApplicationList += '<li data-app-selected="' + data[i].IsSelected + '"><a class="popover-link" title= "' + data[i].Name + '" role="button" data-html="true" data-toggle="popover" data-placement="right" data-content="' + getAnchorUrls(data[i].Url) + '"><img alt="Application Logo" class="app-icon" src="' + (getApplicationLogoUrl+'?id='+data[i].ClientId) + '"><span class="app-name">' + data[i].Name + '</span></a>' + '</li>';
                        } else {
                            myApplicationList += '<li data-app-selected="' + data[i].IsSelected + '">' + '<a href= "' + data[i].Url + '" target="_blank" title= "' + data[i].Name + '<br/>' + data[i].Url + '" data-html="true" data-toggle="tooltip" data-container="body" data-placement=' + ($(".app-icon").parent()[i].offsetTop === $(".app-icon").parent()[0].offsetTop ? "bottom" : "top") + '><img alt="Application Logo" class="app-icon" src="' + (getApplicationLogoUrl + '?id=' + data[i].ClientId) + '"><span class="app-name">' + data[i].Name + '</span></a>' + '</li>';
                        }
                    }
                }
                $("#application-list").html(myApplicationList);
                $('[data-toggle="tooltip"]').tooltip();
                $('[data-toggle="popover"]').popover({ html: true });
            }
        });
    }
});

$(window).resize(function () {
    myApplicationList = '';
    for (var i = 0; i < appData.length ; i++) {
        if (appData[i].IsSelected) {
            myApplicationList += '<li data-app-selected="' + appData[i].IsSelected + '">' + '<a href= "' + appData[i].Url + '" title= "' + appData[i].Name + '<br/>' + appData[i].Url + '" data-html="true" data-toggle="tooltip" data-container="body" data-placement="top"><img alt="Application Logo" class="app-icon" src="' + (getDefaultApplicationLogoUrl + "?applicationtype=10001") + '"><span class="app-name">' + appData[i].Name + '</span></a>' + '</li>';
        }
        else {
            if (appData[i].Url.indexOf(',') != -1) {
                myApplicationList += '<li data-app-selected="' + appData[i].IsSelected + '"><a class="popover-link" title= "' + appData[i].Name + '"role="button" data-html="true" data-toggle="popover" data-placement="right" data-content="' + getAnchorUrls(appData[i].Url) + '"><img alt="Application Logo" class="app-icon" src="' + (getApplicationLogoUrl + '?id=' + appData[i].ClientId) + '"><span class="app-name">' + appData[i].Name + '</span></a>' + '</li>';
            } else {
                myApplicationList += '<li data-app-selected="' + appData[i].IsSelected + '">' + '<a href= "' + appData[i].Url + '" target="_blank" title= "' + appData[i].Name + '<br/>' + appData[i].Url + '" data-html="true" data-toggle="tooltip" data-container="body" data-placement="top"><img alt="Application Logo" class="app-icon" src="' + (getApplicationLogoUrl + '?id=' + appData[i].ClientId) + '"><span class="app-name">' + appData[i].Name + '</span></a>' + '</li>';
            }
        }
    }
    $(".app-loading-text").addClass("hidden");
    $("#application-list").html(myApplicationList);
    
    var windowHeight = window.innerHeight;
    var headerAreaHeight = $("#header-area").height();
    $("#application-list").css('max-height', windowHeight - headerAreaHeight);
    if ($("#application-list").innerHeight() >= windowHeight - headerAreaHeight) {
        $("#application-list").css('max-width', 340);
    }
    
    myApplicationList = '';
    for (var i = 0; i < appData.length; i++) {
        if (appData[i].IsSelected) {
            myApplicationList += '<li data-app-selected="' + appData[i].IsSelected + '">' + '<a href= "' + appData[i].Url + '" title= "' + appData[i].Name + '<br/>' + appData[i].Url + '" data-html="true" data-toggle="tooltip" data-container="body" data-placement=' + ($(".app-icon").parent()[i].offsetTop === $(".app-icon").parent()[0].offsetTop ? "bottom" : "top") + '><img alt="Application Logo" class="app-icon" src="' + (getDefaultApplicationLogoUrl + "?applicationtype=10001") + '"><span class="app-name">' + appData[i].Name + '</span></a>' + '</li>';
        }
        else {
            if (appData[i].Url.indexOf(',') != -1) {
                myApplicationList += '<li data-app-selected="' + appData[i].IsSelected + '"><a class="popover-link" title= "' + appData[i].Name + '" role="button" data-html="true" data-toggle="popover" data-placement="right" data-content="' + getAnchorUrls(appData[i].Url) + '"><img alt="Application Logo" class="app-icon" src="' + (getApplicationLogoUrl + '?id=' + appData[i].ClientId) + '"><span class="app-name">' + appData[i].Name + '</span></a>' + '</li>';
            } else {
                myApplicationList += '<li data-app-selected="' + appData[i].IsSelected + '">' + '<a href= "' + appData[i].Url + '" target="_blank" title= "' + appData[i].Name + '<br/>' + appData[i].Url + '" data-html="true" data-toggle="tooltip" data-container="body" data-placement=' + ($(".app-icon").parent()[i].offsetTop === $(".app-icon").parent()[0].offsetTop ? "bottom" : "top") + '><img alt="Application Logo" class="app-icon" src="' + (getApplicationLogoUrl + '?id=' + appData[i].ClientId) + '"><span class="app-name">' + appData[i].Name + '</span></a>' + '</li>';
            }
        }
    }
    $("#application-list").html(myApplicationList);
    $('[data-toggle="tooltip"]').tooltip();
    $('[data-toggle="popover"]').popover({ html: true });
});

function getAnchorUrls(url) {
    var urlList = getUrlList(url);
    var htmlUrl = '';
    for (var i = 0; i < urlList.length; i++) {
        htmlUrl += '<a href= \'' + urlList[i] + '\' target=\'_blank\' title= \'' + urlList[i] + '\' data-html=\'true\' data-toggle=\'tooltip\' data-container=\'body\' data-placement= \'top\'>' + urlList[i] + '</a>';
    }

    return htmlUrl;
}

$(document).on('click', function (e) {
    if ($("#app-list").length > 0 && $("#app-list").css("display") !== "none") {
        if (($('.popover').has(e.target).length == 0) || $(e.target).is('.close')) {
            $('.popover').popover('hide');
        }

        if (e.target.className !== "popover-link" && e.target.className !== "app-icon" && e.target.className !== "app-name" && e.target.className !== "application-navigation" && e.target.className !== "su su-apps-menu application-navigation-logo") {
            $("#app-list").css("display", "none");
        }
    }
});

$(document).on('click', "li a", function (e) {
    if ($("#app-list").length > 0 && $("#app-list").css("display") !== "none") {
        e.stopPropagation();
        $('.popover').not($(this).next(".popover")).popover('hide');
        $('[data-toggle="tooltip"]').tooltip();
    }
});

$(document).on('click', ".application-navigation-logo", function (e) {
    if ($("#app-list").css("display") === "none") {
        $("#app-list").css("display", "block");     
       
    } else {
        $("#app-list").css("display", "none");      
    }
});

$(document).on("click", ".popover a", function() {
    $('.tooltip').css('display', 'none');
});