var flipTimeouts = {};

function flip(el) {
    el.classList.toggle("card-flipper--flipped");
    clearTimeout(flipTimeouts[el.parentElement.id]);
    flipTimeouts[el.parentElement.id] = setTimeout(function() {
        if (el.classList.contains("card-flipper--flipped")) {
            console.log('unflipping');
            el.classList.toggle("card-flipper--flipped");
        }
    }, 2000);
}