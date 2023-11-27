const cds = require('@sap/cds');
class CatalogService extends cds.ApplicationService {
    init() {

        const { Books, Authors } = this.entities;

        // this.before('*', req =>
        //   req.user.is('authenticated') || req.reject(403)
        // );

        this.before('CREATE', 'Books', async (req) => {
            const { maxID } = await SELECT.one`max(bookNumber) as maxID`.from(Books);
            if (!req.data.title) {
                throw req.reject(400, 'Please provide book title.');
            } else if (!req.data.stock) {
                throw req.reject(400, 'Please provide book stock details.');
            } else if (!req.data.author_ID) {
                throw req.reject(400, 'Please provide author details.');
            } else if (req.data.categories.length === 0) {
                throw req.reject(400, 'Please provide category details.');
            } else {
                req.data.bookNumber = maxID + 1;
            }
        });

        // ----------------------#### Custom Action & Function Implementation #####------------ //
        this.on('setStatus', Books, async req => {
            await cds.update(Books, req._params[0].ID).set({ status_code: 'P' });
        });

        this.on('setStatus1', async (req) => {
            let ID = req._params[0].ID;
            const query = SELECT.from(Books)
                .columns
                `{ID, bookNumber, title, description, author_ID, stock, price, status_code}`
                .where
                `ID = ${ID}`;
            const result = await cds.run(SELECT.from(query));

            if (result[0].status_code === "N") {
                await UPDATE(req.target)
                    .where`ID = ${ID}`
                    .with({ status_code: 'P' });
            } else {
                let msg = "This (" + result[0].bookNumber + ") was already published."
                throw req.info(msg);
            }
            return result;
        });

        this.on('MyAction', async (req) => {
            var f1 = req.data.input["field1"],
                f2 = req.data.input["field2"],
                op = req.data.input["operator"];

            req.data.input["result"] = eval(f1 + op + f2);
            return req.data.input;
        });

        this.on('MyFunction', async (req) => {
            let iBookNo = req.data.bookNumber;
            const query = SELECT.from(Books)
                .columns
                `{bookNumber, title, description}`
                .where
                `bookNumber = ${iBookNo}`;
            const queryOutput = await query;
            return queryOutput;
        });

        this.on('AddString', async (req) => {
            let { firstName, lastName } = req.data;
            return firstName.concat(" " + lastName);
        });
        // ----------------------#### Custom Action & Function Implementation #####------------ //
        return super.init();
    }
}
module.exports = { CatalogService };