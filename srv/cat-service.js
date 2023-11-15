const cds = require('@sap/cds');
class CatalogService extends cds.ApplicationService {
    init() {

        const { Books, Authors } = this.entities;

        this.before('CREATE', 'Books', async (req) => {
            const { maxID } = await SELECT.one`max(bookNumber) as maxID`.from(Books);
            if (!req.data.title) {
                throw req.reject(400, 'Please provide book title.');
            } else if (!req.data.stock) {
                throw req.reject(400, 'Please provide book stock details.');
            } else if(!req.data.author_ID) {
                throw req.reject(400, 'Please provide author details.');
            } else if(req.data.categories.length === 0) {
                throw req.reject(400, 'Please provide category details.');
            } else {
                req.data.bookNumber = maxID + 1;
            }
        });

        return super.init();
    }
}
module.exports = { CatalogService };