const { Client } = require('pg');
const clientOptions = {
    user: 'dbuser',
    host: 'localhost',
    password: null,
    port: 5432
}

const client = new Client(clientOptions);

const databaseSetup = async () => {
    try {
        await client.connect();                            // gets connection
        await client.query('CREATE DATABASE IF NOT EXISTS gg_postings'); // sends queries
        await client.query(`
            CREATE TABLE IF NOT EXISTS postings (
                id SERIAL PRIMARY KEY,
                commitment TEXT,
                department TEXT,
                location TEXT,
                team TEXT,
                created_at TIMESTAMP,
                description TEXT,
                job_id TEXT,
                job_specifics TEXT,
                title TEXT
            )`);
        return true;
    } catch (error) {
        console.error(error.stack);
        return false;
    } finally {
        client.end();
    }
};


databaseSetup().then((result) => {
    if (result) {
        console.log('Database and table created successfully!');
    } else {
        console.log('Database and table creation failed.');
    }
});