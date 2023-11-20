using {sap.capire.bookshop as my} from '../db/schema';

service CatalogService @(path: '/browse') {
    entity Books      as projection on my.Books actions {
        action StatusChange();
    };

    entity Authors    as projection on my.Authors;
    entity Categories as projection on my.Categories;
}
