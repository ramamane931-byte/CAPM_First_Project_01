using CatalogService as service from '../../srv/CatalogService';

annotate service.PurchaseOrderSet with @(

    //Defining default Setting: Add fields to the screen for filtering the data
    UI.SelectionFields      : [
        PO_ID,
        PARTNER_GUID.COMPANY_NAME,
        PARTNER_GUID.ADDRESS_GUID.COUNTRY,
        grossAmount,
        OVERALL_STATUS
    ],

    //Add the columns to the table data
    UI.LineItem             : [
        {
            $Type         : 'UI.DataField',
            Value         : PO_ID,
            @UI.Importance: #High,
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID.COMPANY_NAME,
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID.ADDRESS_GUID.COUNTRY,
        },
        {
            $Type: 'UI.DataField',
            Value: grossAmount,
        },

        /// Button action 'boost' defined under the 'CatalogService.cds' file
        {
            $Type : 'UI.DataFieldForAction',
            Action: 'CatalogService.boost',
            Label : 'Boost',
            Inline: true,
        },
        {
            $Type      : 'UI.DataField',
            Value      : OVERALL_STATUS,
            Criticality: Spiderman /// Criticalit to change the color of the status value.
        },
    ],

    //HEADER INFORMATION ON THE FIRST PAGE
    UI.HeaderInfo           : {
        //Title of the list report table on the FIRST SCREEN, Where, Count of records will automaticall shown by framework.
        TypeName      : 'Purchase Order',
        TypeNamePlural: 'Purchase Orders',
        //Dislay in the Title section on the SECOND SCREEN
        Title         : {Value: PO_ID},
        Description   : {Value: PARTNER_GUID.COMPANY_NAME},
        ImageUrl      : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWVYXq3pq6f6GOSTTx-TntYslRgHyhotws9GkPSFveBA&s=10'
    },

    //Add tab strip in second page (Facets) - Object Page
    UI.Facets               : [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'General Information',
            //First Tab T1 = General Information
            Facets: [
                {
                    Label : 'Basic Info',
                    // T1 - Block 1
                    $Type : 'UI.ReferenceFacet',
                    Target: '@UI.Identification',
                },
                {
                    Label : 'Pricing Details',
                    // T1 - Block 2
                    $Type : 'UI.ReferenceFacet',
                    Target: '@UI.FieldGroup#Spiderman',
                },
                {
                    Label : 'Additional Data',
                    // T1 - Block 3
                    $Type : 'UI.ReferenceFacet',
                    Target: '@UI.FieldGroup#Superman',
                },
            ],
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Items',
            //Second Tab T2 = Items
            Target: 'Items/@UI.LineItem'
        }
    ],

    //default block which is always and always ONE - Identification: Block 1 - 'Basic Info' - Under - 'General Information'
    //contains the group of fields
    UI.Identification       : [
        {
            $Type: 'UI.DataField',
            Value: PO_ID,
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID_NODE_KEY,
        },
        {
            $Type: 'UI.DataField',
            Value: NOTE
        },
    ],

    //FieldGroup block that can be multiple and have many fields inside: Block 2 - 'Pricing Details' - Under - 'General Information'
    UI.FieldGroup #Spiderman: {Data: [
        {
            $Type: 'UI.DataField',
            Value: grossAmount,
        },
        {
            $Type: 'UI.DataField',
            Value: NET_AMOUNT,
        },
        {
            $Type: 'UI.DataField',
            Value: TAX_AMOUNT,
        },
    ], },

    //Field Group for status data
    //To avoid system getting confused with duplicate annotations we use identifier: Block 3 - 'Additional Data' - Under - 'General Information'
    UI.FieldGroup #Superman : {Data: [
        {
            $Type: 'UI.DataField',
            Value: currency_code,
        },
        {
            $Type: 'UI.DataField',
            Value: OVERALL_STATUS,
        },
        {
            $Type: 'UI.DataField',
            Value: LIFECYCLE_STATUS,
        }
    ]}

);


annotate service.PurchaseItemsSet with @(

    //HEADER INFORMATION ON THE PO Item's SECOND PAGE
    UI.HeaderInfo    : {
        TypeName      : 'PO Item',
        TypeNamePlural: 'Purchase Order Items',
        Title         : {Value: PO_ITEM_POS},
        Description   : {Value: PRODUCT_GUID_NODE_KEY} //PRODUCT_GUID.DESCRIPTION}
    },


    //Second Tab T2 = Items
    UI.LineItem      : [
        {
            $Type: 'UI.DataField',
            Value: PO_ITEM_POS,
        },
        {
            $Type: 'UI.DataField',
            Value: PRODUCT_GUID_NODE_KEY,
        },
        {
            $Type: 'UI.DataField',
            Value: grossAmount,
        },
        {
            $Type: 'UI.DataField',
            Value: NET_AMOUNT,
        },
        {
            $Type: 'UI.DataField',
            Value: TAX_AMOUNT,
        },
    ],

    //Second Tab T2 = Items, Object page / Second screen
    UI.Facets        : [{
        $Type : 'UI.ReferenceFacet',
        Label : 'Item Details',
        Target: '@UI.Identification',
    }, ],
    UI.Identification: [
        {
            $Type: 'UI.DataField',
            Value: PO_ITEM_POS,
        },
        {
            $Type: 'UI.DataField',
            Value: PRODUCT_GUID_NODE_KEY,
        },
        {
            $Type: 'UI.DataField',
            Value: grossAmount,
        },
        {
            $Type: 'UI.DataField',
            Value: NET_AMOUNT,
        },
        {
            $Type: 'UI.DataField',
            Value: TAX_AMOUNT,
        },
        {
            $Type: 'UI.DataField',
            Value: currency_code,
        },

    ]

);

//annotate a field to get its meaningful text
annotate service.PurchaseOrderSet with {
    @(
        Common.Text                    : OverallStatus,
        Common.ValueList               : {
            $Type                       : 'Common.ValueListType',
            CollectionPath              : 'StatusCode',
            Parameters                  : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: OVERALL_STATUS,
                ValueListProperty: 'code',
            }, ],
            Label                       : 'Status',
            PresentationVariantQualifier: 'vh_PurchaseOrderSet_OVERALL_STATUS',
        },
        Common.ValueListWithFixedValues: true,
    ) //// for eg: 'Pending(P)'
    OVERALL_STATUS;
    @Common.Text: NOTE //// for eg: '<NOTE>(<PO_ID>)'
    PO_ID;
    @Common.Text     : PARTNER_GUID.COMPANY_NAME /// For eg: '<COMPANY_NAME>(PARNER_GUID)'
    @ValueList.entity: service.BusinessPartnerSet
    // @UI.Hidden: true   /// This will hide the entire PARTNER_KEY
    // @Common : { TextArrangement : #TextOnly } /// Display only <COMPANY_NAME>
    PARTNER_GUID;
};

//annotate a field to get its meaningful text
annotate service.PurchaseItemsSet with {
    @Common.Text     : PRODUCT_GUID.DESCRIPTION
    // @UI.Hidden: true
    // @Common : { TextArrangement : #TextOnly }
    @ValueList.entity: service.ProductSet
    PRODUCT_GUID; /// This will only display the field value without Text/Description
};

//Design Value help in CAPM for Partner Guid and Product Guid
@cds.odata.valuelist
annotate service.BusinessPartnerSet with @(UI.Identification: [{
    $Type: 'UI.DataField',
    Value: COMPANY_NAME,
}, ]);

@cds.odata.valuelist
annotate service.ProductSet with @(UI.Identification: [{
    $Type: 'UI.DataField',
    Value: DESCRIPTION,
}, ]);

//Exposed the EntitySet StatusCode in the Metadata extension annotated entity
// annotate service.PurchaseOrderSet with {
//     OVERALL_STATUS @(
//         Common.ValueList : {
//             $Type : 'Common.ValueListType',
//             CollectionPath : 'StatusCode',
//             Parameters : [
//                 {
//                     $Type : 'Common.ValueListParameterInOut',
//                     LocalDataProperty : OVERALL_STATUS,
//                     ValueListProperty : 'code',
//                 },
//             ],
//             Label : 'Status',
//         },
//         Common.ValueListWithFixedValues : true,
// )};

// annotate service.StatusCode with {
//     code @Common.Text : value
// };

//Below code has been auto generated by adding field property as Dropdown for 'Status' field
annotate service.StatusCode with @(UI.PresentationVariant #vh_PurchaseOrderSet_OVERALL_STATUS: {
    $Type    : 'UI.PresentationVariantType',
    SortOrder: [{
        $Type     : 'Common.SortOrderType',
        Property  : code,
        Descending: false,
    }, ],
});

//Below code has been auto generated by adding field property as Dropdown for 'Status' field
annotate service.StatusCode with {
    code @Common.Text: value
};
