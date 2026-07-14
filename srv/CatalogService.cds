//consume reference of my DB tables
using {
    ramdas.db.master,
    ramdas.db.transaction
} from '../db/datamodel';

//'requires: 'authenticated-user'' this will authenticate the user before accessing the service.
//Will username and password be required to access the service
service CatalogService @(
    path    : 'CatalogService',
    requires: 'authenticated-user' //Session 14
) {

    //Entity  - representation of an end point of data to perform CRUDQ tasks
    entity EmployeeSet
                      //SOM-Session 14:
                      @(restrict: [
        {
            grant: ['READ'],
            to   : 'Display',
            //row level security
            where: 'bankName = $user.spiderman'
        },
        {
            grant: [
                'WRITE',
                'DELETE'
            ],
            to   : 'Edit'
        }
    ]) //EOM-Session 14:
                              as projection on master.employee;

    // @readonly  // This annotation will hide the 'Delete' button from the First screen
    // @Capabilities: {Deletable: false}   // This annotation will hide the 'Delete' button from the First screen
    entity StatusCode         as projection on master.StatusCode; //Defined entityset as StatusCode or expose in the projection view

    //'@(odata.draft.enabled: true)' make the Business Object Draft enabled.
    entity PurchaseOrderSet @(

        //SOM-Session 14:
        restrict                    : [
            {
                grant: ['READ'],
                to   : 'Display'
            },
            {
                grant: [
                    'WRITE',
                    'DELETE'
                ],
                to   : 'Edit'
            }
        ],
        //EOM-Session 14

        odata.draft.enabled         : true,
        Common.DefaultValuesFunction: 'getDeafultValue'
    )                         as
        projection on transaction.purchaseorder {
            *,
            //CDS Expression language
            case
                OVERALL_STATUS
                when 'P'
                     then 'Pending'
                when 'A'
                     then 'Approved'
                when 'X'
                     then 'Rejected'
                when 'D'
                     then 'Delivered'
                else 'Unknown'
            end as OverallStatus : String(10),

            //OVERALL_STATUS with color coding
            case
                OVERALL_STATUS
                when 'P'
                     then 2
                when 'A'
                     then 3
                when 'X'
                     then 1
                when 'D'
                     then 3
                else 'Unknown'
            end as Spiderman     : Integer
        }

        ///Defined action for 'boost', 'boost' button defination:
        actions {
            ///Side effect - a trigger to my action leads to a change of a field value in data
            //this force framework to make a GET call after action is triggred to load data
            //_anubhav is  variable that will contain the updated data coming from BE
            @cds.odata.bindingparameter.name: '_ramdas'
            @Common.SideEffects             : {TargetProperties: [
                '_ramdas/grossAmount',
                '_ramdas/OVERALL_STATUS'
            ]}

            //the system will pass the PO primary key - NODE_KEY automatically to input
            // action 'boost()' implemented in the 'CatalogService.js' file
            action boost() returns PurchaseOrderSet
        };

    entity PurchaseItemsSet   as projection on transaction.poitems;

    entity AddressSet         as projection on master.address;
    entity ProductSet         as projection on master.product;
    entity BusinessPartnerSet as projection on master.businesspartner;

    //non instance bound because they are not connected to any entity
    function getLargestOrder() returns array of PurchaseOrderSet;
    function getDeafultValue() returns PurchaseOrderSet;

}
