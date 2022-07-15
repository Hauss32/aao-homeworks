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

        this.attributes.createdAt = createdDateUTC;
    }

    parseDesc() {
        this.attributes.description = this.data.descriptionPlain;
    }

    parseId() {
        this.attributes.job_id = this.data.id;
    }

    parseLists() {
        // array of job specifics (responsibilities, requirements, etc.)
        const jobSpecifics = this.data.lists;

        jobSpecifics.forEach( jobItem => {
            this.attributes.jobSpecifics ||= '';

            const heading = jobItem.text;
            const contentRaw = jobItem.content; //html raw
            const contentStr = contentRaw.replace(/<[^>]*>?/gm, '');
            const contentFormatted = contentStr.replace(/\s{2,}/gm, ' ');

            this.attributes.jobSpecifics += `${heading}: ${contentFormatted} \n`;
        })
    }

    parseTitle() {
        this.attributes.title = this.data.text;
    }
}

module.exports = Posting;