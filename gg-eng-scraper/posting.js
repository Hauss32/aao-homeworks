class Posting {
    constructor(postingData) {
        this.data = postingData;
        this.attributes = {};

        this.parseData();
    }

    parseData() {
        this.parseCategories();
        this.parseCreatedAt();
        this.parseDesc();
        this.parseId();
        this.parseLists();
        this.parseTitle();
    }

    parseCategories() {
        this.attributes.commitment = this.data.categories.commitment
        this.attributes.department = this.data.categories.department
        this.attributes.location = this.data.categories.location
        this.attributes.team = this.data.categories.team
    }

    parseCreatedAt() {
        const createdAtRaw = this.data.createdAt;
        const createdDateUTC = new Date(createdAtRaw);

        this.attributes.posted_at = createdDateUTC;
    }

    parseDesc() {
        this.attributes.description = this.data.descriptionPlain;
    }

    parseId() {
        this.attributes.job_id = this.data.id;
    }

    parseLists() {
        // array of job specifics (responsibilities, requirements, etc.)
        const jobDetails = this.data.lists;

        jobDetails.forEach( jobItem => {
            this.attributes.job_details ||= '';

            const heading = jobItem.text;
            const contentRaw = jobItem.content; //html raw
            const contentStr = contentRaw.replace(/<[^>]*>?/gm, '');
            const contentFormatted = contentStr.replace(/\s{2,}/gm, ' ');

            this.attributes.job_details += `${heading}: ${contentFormatted} \n`;
        })
    }

    parseTitle() {
        this.attributes.title = this.data.text;
    }

    async save(connection) {
        this.attributes.created_at = new Date(); //record posting insertion time

        const colArr = Object.keys( this.attributes );
        const values = Object.values(this.attributes);
        const valuesParamArr = values.map( (val, idx) => `$${idx + 1}`);
        const queryStr = `
            INSERT INTO postings(${colArr.join()}) VALUES(${valuesParamArr.join()})
        `;

        const query = {
            text: queryStr,
            values: values
        }

        try {
            return connection.query(query);
        } catch (error) {
            console.log(error);
        }
    }
}

module.exports = Posting;