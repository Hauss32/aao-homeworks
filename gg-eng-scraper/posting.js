class Posting {
    constructor(postingData) {
        this.attributes = {};
    }

    parseData(data) {

    }

    parseCategories(data) {
        this.attributes.commitment = data.categories.commitment
        this.attributes.department = data.categories.department
        this.attributes.location = data.categories.location
        this.attributes.team = data.categories.team
    }

    parseCreatedAt(data) {
        const createdAtRaw = data.createdAt;
        const createdDateUTC = new Date(createdAtRaw);

        this.createdAt = createdDateUTC;
    }

    parseDesc(data) {
        this.description = data.descriptionPlain;
    }

    parseId(data) {
        this.job_id = data.id;
    }

    parseLists(data) {
        // array of job specifics (responsibilities, requirements, etc.)
    }
}