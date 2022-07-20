const curl = require("curl");
const PostingConnection = require("./database/posting_connection");
const Posting = require("./posting");

const connection = new PostingConnection();
const url = "https://api.lever.co/v0/postings/goguardian?group=team&mode=json";

curl.get(url, null, (err, resp, body) => {
    if (resp.statusCode == 200) {
        parseData(body).then( () => {
            connection.end();
            console.log('Postings scrape completed!');
        })
    }
    else {
        console.log(`Failed to get data from ${url}`);
    }
});

async function parseData(json) {
    const data = JSON.parse(json);
    const insertionPromises = [];
    data.forEach( department => {
        department.postings.forEach( posting => {
            const newPosting = new Posting(posting);
            insertionPromises.push( newPosting.save(connection) );
        })
    })

    await Promise.all( insertionPromises );
    console.log( 'Inserted postings!' );
}