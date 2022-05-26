// First, set a simple timeout for 5000 ms(use window.setTimeout).Pass in a 
// callback function that calls alert('HAMMERTIME')
window.setTimeout( () => {
    alert('HAMMERTIME')
}, 5 * 1000);

// Next, we are going to write a function hammerTime that takes in one argument - time.
// When the function is run, it should set a timeout on the window.Pass a callback 
// to the timeout that creates an alert ${ time } is hammertime!
function hammerTime(time) {
    window.setTimeout( () => {
        alert(`${time} is hammertime!`)
    }, 2 * 1000)
}