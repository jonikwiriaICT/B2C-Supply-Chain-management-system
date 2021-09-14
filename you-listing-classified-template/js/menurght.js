$(document).ready(function(){
    $("#sidebarToggle").click(function(){
        $("#foo").toggle();
    });
});

$(document).ready(function(){
    $("#sidebarToggle").click(function(){
        $("#foo1").toggle();
    });
});

$(document).ready(function(){
    $("#sidebarToggle").click(function(){
        $("#foo2").toggle();
    });
});
$(document).ready(function(){
    $("#sidebarToggle").click(function(){
        $("#foo3").toggle();
    });
});
$(document).ready(function(){
    $("#sidebarToggle").click(function(){
        $("#foo4").toggle();
    });
});
$(document).ready(function(){
    $("#sidebarToggle").click(function(){
        $("#foo5").toggle();
    });
});
$(document).ready(function(){
    $("#sidebarToggle").click(function(){
        $("#foo6").toggle();
    });
});
$(document).ready(function(){
    $("#sidebarToggle").click(function(){
        $("#foo7").toggle();
    });
});
$(document).ready(function(){
    $("#sidebarToggle").click(function(){
        $("#foo8").toggle();
    });
});
$(document).ready(function(){
    $("#sidebarToggle").click(function(){
        $("#foo9").toggle();
    });
});
$(document).ready(function(){
    $("#sidebarToggle").click(function(){
        $("#foo10").toggle();
    });
});
/***Menu Sticky***/
/****/
$(window).scroll(function(){
    if ($(window).scrollTop() >= 50) {
        $('nav').addClass('fixed-header');
        $('nav div').addClass('visible-title');
    }
    else {
        $('nav').removeClass('fixed-header');
        $('nav div').removeClass('visible-title');
    }
});