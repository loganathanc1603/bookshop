using {sap.capire.bookshop as my} from '../db/schema';

service CatalogService @(path: '/browse') {
    @requires: 'authenticated-user'
    entity Books      as projection on my.Books actions {
         @( 
            Core.OperationAvailable : {$edmJson: { $Ne: [{ $Path: 'status/status_code'}, 'P']}},
            cds.odata.bindingparameter.name : 'status',
            Common.SideEffects              : {TargetProperties : ['status/status_code']}   )
        action setStatus();
    };
    entity Authors    as projection on my.Authors;

    @readonly
    entity BookStatus    as projection on my.BookStatus;

    entity Categories as projection on my.Categories excluding {
        createdAt,
        createdBy,
        modifiedBy
    };

    type MyActionReturnObject {
        field1   : Integer;
        field2   : Integer;
        operator : String(1);
        result   : Integer;
    };

    type MyFunctionReturnObject {
        bookNumber  : Integer;
        title       : String(111);
        description : String;
    }

    action   MyAction(input : MyActionReturnObject)           returns MyActionReturnObject;
    function MyFunction(bookNumber : Integer)                 returns MyFunctionReturnObject;
    function AddString(firstName : String, lastName : String) returns String;
}
