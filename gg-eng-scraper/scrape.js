const curl = require("curl");
const Posting = require("./posting");

const url = "https://api.lever.co/v0/postings/goguardian?group=team&mode=json";

curl.get(url, null, (err, resp, body) => {
    if (resp.statusCode == 200) {
        parseData(body);
    }
    else {
        console.log(`Failed to get data from ${url}`);
    }
});

function parseData(json) {
    const data = JSON.parse(json);
    data.forEach( department => {
        department.postings.forEach( posting => {
            const newPosting = new Posting(posting);
            console.log(newPosting);
        })
    })
}