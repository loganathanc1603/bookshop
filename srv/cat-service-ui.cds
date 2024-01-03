using CatalogService as Service from './cat-service';

annotate Service.Books with @odata.draft.enabled;
annotate Service.Authors with @(readonly : true);


annotate Service.Books with @(
    UI     : {
        //UpdateHidden : {$edmJson : {$Eq : [{$Path : 'status_code'},'P']}},
        LineItem                       : [
            {
                $Type  : 'UI.DataFieldForAction',
                Action : 'CatalogService.setStatus',
                Label  : '{i18n>SET_STATUS}'
            },
            {
                $Type : 'UI.DataField',
                Value : bookNumber
            },
            {
                $Type : 'UI.DataField',
                Value : title
            },
            {
                $Type : 'UI.DataField',
                Value : author.name
            },
            {
                $Type : 'UI.DataField',
                Value : stock
            },
            {
                $Type                 : 'UI.DataField',
                Value                 : price,
                ![@UI.Importance]     : #High,
                ![@HTML5.CssDefaults] : {width : '150px'}
            },
            {
                $Type                 : 'UI.DataField',
                Value                 : status_code,
                Criticality           : status.criticality,
                ![@UI.Importance]     : #High,
                ![@HTML5.CssDefaults] : {width : '150px'}
            }
        ],
        Identification                 : [{
            $Type  : 'UI.DataFieldForAction',
            Action : 'CatalogService.setStatus',
            Label  : '{i18n>SET_STATUS}'
        //![@UI.Hidden] : {$edmJson : {$Ne : [{$Path : 'status_code'}, 'N']}}
        }],
        SelectionFields                : [
            bookNumber,
            title,
            author_ID,
            Currency_code,
            status_code
        ],
        HeaderInfo                     : {
            $Type          : 'UI.HeaderInfoType',
            TypeName       : 'Book',
            TypeNamePlural : 'Books',
            TypeImageUrl   : 'sap-icon://education',
            Title          : {
                $Type : 'UI.DataField',
                Value : bookNumber
            },
            Description    : {
                $Type : 'UI.DataField',
                Value : description
            }
        },
        FieldGroup #GeneralInformation : {
            $Type : 'UI.FieldGroupType',
            Data  : [
                {
                    $Type : 'UI.DataField',
                    Value : bookNumber
                },
                {
                    $Type : 'UI.DataField',
                    Value : title
                },
                {
                    $Type : 'UI.DataField',
                    Value : description
                },
                {
                    $Type : 'UI.DataField',
                    Value : stock
                },
                {
                    $Type : 'UI.DataField',
                    Value : price
                },
                {
                    $Type : 'UI.DataField',
                    Value : status_code
                },
                {
                    $Type : 'UI.DataFieldWithUrl',
                    Url : bookLink,
                    Value : bookLink
                    
                }
            ]
        },
        FieldGroup #AuthorInformation  : {
            $Type : 'UI.FieldGroupType',
            Data  : [
                {
                    $Type : 'UI.DataField',
                    Value : author_ID
                },
                {
                    $Type : 'UI.DataField',
                    Value : author.name
                },
                {
                    $Type : 'UI.DataField',
                    Value : author.dateOfBirth
                },
                {
                    $Type : 'UI.DataField',
                    Value : author.placeOfBirth
                },
                {
                    $Type : 'UI.DataField',
                    Value : author.Country.code
                }
            ]
        },
        FieldGroup #AdminInformation   : {
            $Type : 'UI.FieldGroupType',
            Data  : [
                {
                    $Type : 'UI.DataField',
                    Value : createdAt
                },
                {
                    $Type : 'UI.DataField',
                    Value : createdBy
                },
                {
                    $Type : 'UI.DataField',
                    Value : modifiedAt
                },
                {
                    $Type : 'UI.DataField',
                    Value : modifiedBy
                }
            ]
        },
        Facets                         : [
            {
                $Type  : 'UI.ReferenceFacet',
                ID     : 'GENERALINFO',
                Label  : 'General Information',
                Target : '@UI.FieldGroup#GeneralInformation',
            },
            {
                $Type  : 'UI.ReferenceFacet',
                ID     : 'AUTHORFACET',
                Label  : 'Author Information',
                Target : '@UI.FieldGroup#AuthorInformation',
            },
            {
                $Type  : 'UI.ReferenceFacet',
                ID     : 'ADMINFACET',
                Label  : 'Administrative Information',
                Target : '@UI.FieldGroup#AdminInformation',
            },
            {
                $Type  : 'UI.ReferenceFacet',
                ID     : 'CATEGORYFACET',
                Label  : 'Category Information',
                Target : 'categories/@UI.LineItem#Category',
            }
        ]
    },
    Common : {SideEffects #AuthorChanged : {
        $Type            : 'Common.SideEffectsType',
        SourceProperties : ['author_ID'],
        TargetEntities   : [author]
    }}
) {
    bookNumber  @(title : '{i18n>BOOK_NUMBER}');
    title       @(title : '{i18n>BOOK_TITLE}');
    description @(title : '{i18n>BOOK_DESC}')  @UI.MultiLineText : true;
    stock       @(title : '{i18n>STOCK}');
    price       @(title : '{i18n>PRICE}')  @(Measures.ISOCurrency : Currency_code);
    bookLink    @(title : '{i18n>BOOK_LINK}');
    status
                @(
        title  : '{i18n>BOOKSTATUS}',
        Common : {
            Text            : status.description,
            TextArrangement : #TextFirst,
            ValueListWithFixedValues,
            ValueList       : {
                $Type          : 'Common.ValueListType',
                Label          : 'Status',
                CollectionPath : 'BookStatus',
                Parameters     : [
                    {
                        $Type             : 'Common.ValueListParameterInOut',
                        LocalDataProperty : status_code,
                        ValueListProperty : 'code'
                    },
                    {
                        $Type             : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'description'
                    }
                ]
            }
        }
    );
    author      @(
        title  : '{i18n>AUTHOR}',
        Common : {
            Text            : author.name,
            TextArrangement : #TextFirst,
            ValueList       : {
                $Type          : 'Common.ValueListType',
                Label          : 'Author',
                CollectionPath : 'Authors',
                Parameters     : [
                    {
                        $Type             : 'Common.ValueListParameterInOut',
                        LocalDataProperty : author_ID,
                        ValueListProperty : 'ID'
                    },
                    {
                        $Type             : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'name'
                    },
                    {
                        $Type             : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'dateOfBirth'
                    },
                    {
                        $Type             : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'placeOfBirth'
                    },
                    {
                        $Type             : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'Country_code'
                    }
                ]
            },
        }
    );
};

annotate Service.Authors with {
    ID           @title : '{i18n>AUTHOR_ID}'  @Common.Text : name;
    name         @(title : '{i18n>AUTHOR_NAME}');
    dateOfBirth  @(title : '{i18n>DATE_OF_BIRTH}');
    placeOfBirth @(title : '{i18n>PLACE_OF_BIRTH}');
};

annotate Service.Categories with @(UI : {LineItem #Category : [
    {
        $Type : 'UI.DataField',
        Value : categoryTitle
    },
    {
        $Type : 'UI.DataField',
        Value : categoryDescription
    }
]}) {
    ID                  @(title : '{i18n>CATEGORY_ID}');
    categoryTitle       @(title : '{i18n>CATEGORY_TITLE}');
    categoryDescription @(title : '{i18n>CATEGORY_DESC}');
};

annotate Service.BookStatus {
    code        @title : '{i18n>BOOKSTATUS_CODE}'  @Common.Text : description;
    description @title : '{i18n>BOOKSTATUS_DESC}';
};
