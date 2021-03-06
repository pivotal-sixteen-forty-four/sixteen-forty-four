window.UNFLIP_TIMEOUT_MS = 15000;
window.WINK_INTERVAL_MS = 20000;

var flipTimeouts = {};
var winkInterval;

function flip(el) {
    el.classList.toggle("card-flipper--flipped");
    if (el.classList.contains("card-flipper--flipped")) {
        mixpanel.track("Flip " + el.parentElement.id);
    } else {
        mixpanel.track("Unflip " + el.parentElement.id);
    }
    clearTimeout(flipTimeouts[el.parentElement.id]);
    clearInterval(winkInterval);
    flipTimeouts[el.parentElement.id] = setTimeout(function () {
        if (el.classList.contains("card-flipper--flipped")) {
            el.classList.toggle("card-flipper--flipped");
        }
    }, UNFLIP_TIMEOUT_MS);
    wink();
}

function _wink($card) {
    setTimeout(function () {
        _.first($card).classList.toggle("card-flipper--flipped");
        if ($card.length > 1) {
            _wink(_.tail($card));
        }
    }, 200)
}

function wink() {
    winkInterval = setInterval(function () {
        var $card = $('.card-flipper');
        _wink($card);
        setTimeout(function () {
            var $card = $('.card-flipper');
            _wink($card);
        }, $card.length * 250);
    }, WINK_INTERVAL_MS);
}

wink();