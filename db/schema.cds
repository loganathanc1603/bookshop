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
    price       : Decimal(9, 2);
    Currency    : Currency;
    status      : Association to one BookStatus;
    categories  : Composition of many Categories
                      on categories.Books = $self;
}

entity Authors : cuid {
    name         : String(111);
    dateOfBirth  : Date;
    placeOfBirth : String;
    Country      : Country
}

entity BookStatus  {
    key code        : String(2);
        description : String
}

entity Categories : managed, cuid {
    categoryTitle       : String(100);
    categoryDescription : String;
    Books               : Association to one Books;
}
