namespace ramdas.common;

//Refering Currency from standard SAP.
using {Currency} from '@sap/cds/common';

//Similar to Data Element in ABAP Dictionary.
type Guid        : String(32);

// 'enum' enumeration type, which is similar to domain in ABAP Dictionary.
type Gender      : String(1) enum {
    male = 'M';
    female = 'F';
    transgender = 'T';
};

//Reference to the Currency type and Qantity type
//@ - annotation that having a speacial significance in the CAPM.
type AmountT     : Decimal(15, 2) @(semantics.amount.currencyCode: 'Currency_code'
                                                                                  //sap.unit: 'Currency_code'
                                                                   );

//custom structure (aspects)
//when we refer a field type that refer to another entity. THat entity will be created as a foreign key table in the database.
//in this example currency has key name code
//The colum name of this structure will be column_key = currency
aspect Amount {
    grossAmount : AmountT @(title: '{i18n>grossAmount}');
    currency: Currency @(title: '{i18n>currency}');
    NET_AMOUNT: AmountT @(title: '{i18n>NET_AMOUNT}');
    TAX_AMOUNT: AmountT @(title: '{i18n>TAX_AMOUNT}');   
}

type PhoneNumber : String(30) @assert.format: '^[6-9]\d{9}$';
type Email       : String(250) @assert.format: '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
