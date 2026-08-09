sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"rama/capm/poanalytics02/test/integration/pages/PurchaseAnalyticsList.gen",
	"rama/capm/poanalytics02/test/integration/pages/PurchaseAnalyticsObjectPage.gen"
], function (JourneyRunner, PurchaseAnalyticsListGenerated, PurchaseAnalyticsObjectPageGenerated) {
    'use strict';

    const runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('rama/capm/poanalytics02') + '/test/flp.html#app-preview',
        pages: {
			onThePurchaseAnalyticsListGenerated: PurchaseAnalyticsListGenerated,
			onThePurchaseAnalyticsObjectPageGenerated: PurchaseAnalyticsObjectPageGenerated
        },
        async: true
    });

    return runner;
});

