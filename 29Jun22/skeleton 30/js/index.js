console.log("Hello from the JavaScript console!");

// Your AJAX request here
$( () => {
    const promise = $.ajax( {
        method: 'GET',
        url: 'http://api.openweathermap.org/data/2.5/weather?q=new%20york,US&appid=bcb83c4b54aee8418983c2aff3073b3b'
    } );

    const handleSuccess = (data) => {
        console.log(data);
    };

    const handleError = (req, status, error) => {
            console.log(`Request failed with status: ${status}. Error: ${error}`);
    };

    promise.then( handleSuccess, handleError );

    console.log('End of file.');
})
