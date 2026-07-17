sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"rama/poanalytics/poanalytics/test/integration/pages/PurchaseAnalyticsList.gen",
	"rama/poanalytics/poanalytics/test/integration/pages/PurchaseAnalyticsObjectPage.gen"
], function (JourneyRunner, PurchaseAnalyticsListGenerated, PurchaseAnalyticsObjectPageGenerated) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('rama/poanalytics/poanalytics') + '/test/flp.html#app-preview',
        pages: {
			onThePurchaseAnalyticsListGenerated: PurchaseAnalyticsListGenerated,
			onThePurchaseAnalyticsObjectPageGenerated: PurchaseAnalyticsObjectPageGenerated
        },
        async: true
    });

    return runner;
});

