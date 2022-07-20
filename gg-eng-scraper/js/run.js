const getAndSavePostings = require("./scrape");
const PostingConnection = require("../database/posting_connection");

const connection = new PostingConnection();

async function getYesterdaysPostings() {
    queryStr = 'SELECT * FROM postings WHERE created_at::date = (CURRENT_DATE - 1)';
    const results = await connection.query(queryStr);
    
    return results.rows;
}

async function getTodaysPostings() {
    queryStr = 'SELECT * FROM postings WHERE created_at::date = CURRENT_DATE';
    const results = await connection.query(queryStr);
    
    return results.rows;
}

async function findNewAndRemovedPostings() {
    const yesterdaysPostings = await getYesterdaysPostings();
    const yesterdaysJobIDs = yesterdaysPostings.map( posting => posting.job_id );
    const todaysPostings = await getTodaysPostings();
    const todaysJobIDs = todaysPostings.map(posting => posting.job_id);
    const newJobIDs = todaysJobIDs.filter( jobID => !yesterdaysJobIDs.includes(jobID) );
    const removedJobIDs = yesterdaysJobIDs.filter( jobID => !todaysJobIDs.includes(jobID) );

    const newAndRemovedJobs = {
        newJobs: todaysPostings.filter( posting => newJobIDs.includes(posting.job_id) ),
        removedJobs: yesterdaysPostings.filter( posting => removedJobIDs.includes(posting.job_id) )
    };

    return newAndRemovedJobs;
}

async function fetchAndDiffRecords() {
    await getAndSavePostings(connection);
    const newAndRemovedJobs = await findNewAndRemovedPostings();

    if (newAndRemovedJobs.newJobs.length == 0 && newAndRemovedJobs.removedJobs.length) {
        console.log('No new or removed jobs today!');
        return;
    } else {
        newAndRemovedJobs.newJobs.forEach(job => {
            console.log(`New Job: ${job.title}`);
        });

        newAndRemovedJobs.removedJobs.forEach(job => {
            console.log(`Removed Job: ${job.title}`);
        });
    }
}

fetchAndDiffRecords().then( () => {
    connection.end();
});

