namespace sap.capire.bookshop;

using {
    Currency,
    managed,
    sap,
    cuid,
    Country
} from '@sap/cds/common';

entity Books : managed, cuid {
    bookNumber  : Integer @readonly;
    title       : String(111);
    description : String;
    author      : Association to one Authors;
    stock       : Integer;
    bookLink    : String;
    price       : Decimal(9, 2);
    Currency    : Currency;
    status      : Association to BookStatus;
    categories  : Composition of many Categories
                      on categories.Books = $self;
    //attachments : Comp
}

entity Authors : cuid {
    name         : String(111);
    dateOfBirth  : Date;
    placeOfBirth : String;
    Country      : Country
}

entity BookStatus {
    key code         : String enum {
            New       = 'N';
            Published = 'P';
        } default 'N'; //> will be used for foreign keys as well
        description  : String;
        criticality  : Integer; //  2: yellow colour,  3: green colour, 0: unknown
        fieldControl : Integer @odata.Type: 'Edm.Byte'; // 1: #ReadOnly, 7: #Mandatory
}

entity Categories : managed, cuid {
    categoryTitle       : String(100);
    categoryDescription : String;
    Books               : Association to one Books;
}

entity Attachments : cuid, managed {
    book      : Association to Books;
    content   : LargeBinary  @Core.MediaType: mediaType  @Core.ContentDisposition.Filename: fileName  @Core.ContentDisposition.Type: 'inline';
    mediaType : String       @Core.IsMediaType;
    fileName  : String;
}
