//consume reference of my DB tables
using {ramdas.cds} from '../db/CDSViews';

service CDSService @(path: 'CDSService') {

    entity ProductSet as
        projection on cds.CDSViews.ProductView {
            *,
            //VIRTUAL ELEMENT: Never e persisted in the Database table
            virtual itemSoldCount : Int16
        };

    entity ItemsSet   as projection on cds.CDSViews.ItemView;

}
