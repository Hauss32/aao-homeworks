export default function getJobs(city) {
    return new Promise( (resolve, reject) => {
        let url = `https://79vzv34gc4.execute-api.us-west-1.amazonaws.com/default/jobListings?location=${city}`;
        url = encodeURI(url);

        const req = new XMLHttpRequest();

        req.open('GET', url, true);
        req.send();

        req.onload = function () {
            if (req.status === 200 || req.status == 201) {
                resolve(req.response);
            } else {
                console.error('Error fetching jobs.');
                reject(req.response);
            }
        }
    });
}