var trackingClick = false;
var targetElement = null;
var touchStartX = 0;
var touchStartY = 0;
var touchBoundary = 10;

target.addEventListener('touchstart', function(event) {

    trackingClick = true;
    targetElement = event.target;
    touchStartX = event.targetTouches[0].pageX;
    touchStartY = event.targetTouches[0].pageY;

    return true;
});

target.addEventListener('touchend', function(event) {

    trackingClick = false;

    //handle click event
    ...

    return false;
});

target.addEventListener('touchmove', function(event) {
    if (!trackingClick) {
        return true;
    }

    // If the touch has moved, cancel the click tracking
    if (targetElement !== event.target 
        || (Math.abs(event.changedTouches[0].pageX - touchStartX) > touchBoundary 
        || (Math.abs(event.changedTouches[0].pageY - touchStartY) > touchBoundary)) {
        trackingClick = false;
        targetElement = null;
    }

    return true;
});

target.addEventListener('touchcancel', function() {
    trackingClick = false;
    targetElement = null;
});

$('.button').on('touchstart click', function(e) {    
    e.stopPropagation(); //stops propagation
    if(e.type == "touchstart") {
        // Handle touchstart event.
    } else if(e.type == "click") {
        // Handle click event.
    }
});
