const { Client } = require('pg');

class PostingConnection {
    constructor() {
        this.client = new Client({
            user: 'db_user',
            host: 'localhost',
            database: 'gg_postings',
            password: null,
            port: 5432
        });

        this.client.connect();
    }

        end() {
            this.client.end();
        }

        query(queryObj) {
            return this.client.query(queryObj);
        }
}

module.exports = PostingConnection;