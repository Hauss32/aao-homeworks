const request = require('xhr-request');
const Posting = require("./posting");

const url = "https://api.lever.co/v0/postings/goguardian?group=team&mode=json";

async function getAndSavePostings(connection) {
    const reqPromise = new Promise( (resolve) => {

        request(url, null, (err, data, response) => {
            if (response.statusCode == 200) {
                resolve(data);
            } else {
                resolve( err );
            }
        } );
    });

    const data = await reqPromise;

    if (data) {
        await parseData(data, connection);
    }
}

async function parseData(json, connection) {
    const data = JSON.parse(json);
    const insertionPromises = [];
    data.forEach( department => {
        department.postings.forEach( posting => {
            const newPosting = new Posting(posting);
            insertionPromises.push( newPosting.save(connection) );
        })
    })

    if ( insertionPromises.length === 0 ) {
        console.log('No new or removed jobs.');
        return;
    } else {
        await Promise.all( insertionPromises );
    }
}

module.exports = getAndSavePostings;