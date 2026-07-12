sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"rama/mngpo/ui/managepocapm/test/integration/pages/PurchaseOrderSetList",
	"rama/mngpo/ui/managepocapm/test/integration/pages/PurchaseOrderSetObjectPage",
	"rama/mngpo/ui/managepocapm/test/integration/pages/PurchaseItemsSetObjectPage"
], function (JourneyRunner, PurchaseOrderSetList, PurchaseOrderSetObjectPage, PurchaseItemsSetObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('rama/mngpo/ui/managepocapm') + '/test/flp.html#app-preview',
        pages: {
			onThePurchaseOrderSetList: PurchaseOrderSetList,
			onThePurchaseOrderSetObjectPage: PurchaseOrderSetObjectPage,
			onThePurchaseItemsSetObjectPage: PurchaseItemsSetObjectPage
        },
        async: true
    });

    return runner;
});

