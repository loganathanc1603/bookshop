using CatalogService as service from '../../srv/cat-service';
using from '../../srv/cat-service-ui';
using from '@sap/cds/common';
using from '@sap/cds/common';



annotate service.Books with @(
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GENERALINFO',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneralInformation',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'AUTHORFACET',
            Label : 'Author Information',
            Target : '@UI.FieldGroup#AuthorInformation',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'ADMINFACET',
            Label : 'Administrative Information',
            Target : '@UI.FieldGroup#AdminInformation',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'CATEGORYFACET',
            Label : 'Category Information',
            Target : 'categories/@UI.LineItem#Category',
        },
    ]
);
annotate service.Books with @(
    UI.Identification : [
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'CatalogService.setStatus',
            Label : '{i18n>SET_STATUS}',
        },
        {
            $Type : 'UI.DataField',
            Value : author.Country.name,
        },
        {
            $Type : 'UI.DataField',
            Value : author.Country.descr,
        },
        {
            $Type : 'UI.DataField',
            Value : author.Country.code,
        },
    ]
);
annotate service.Books with @(
    UI.FieldGroup #GeneralInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : bookNumber,
            },
            {
                $Type : 'UI.DataField',
                Value : title,
            },
            {
                $Type : 'UI.DataField',
                Value : description,
            },
            {
                $Type : 'UI.DataField',
                Value : stock,
            },
            {
                $Type : 'UI.DataField',
                Value : price,
            },
            {
                $Type : 'UI.DataField',
                Value : status_code,
            },
            {
                $Type : 'UI.DataFieldWithUrl',
                Url : bookLink,
                Value : bookLink,
            },
        ],
    }
);
