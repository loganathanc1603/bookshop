sap.ui.define(["sap/m/MessageBox"], function (MessageBox) {
    "use strict";

    return {
        handleCustomButton: function (oBindingContext) {
            if (oBindingContext) {
                MessageBox.show(oBindingContext.getSource().getBindingContext().getObject("title"), {
                    icon: MessageBox.Icon.INFORMATION,
                    title: "Custom column button triggered!"
                });

            }
        },
        enabledForCompletedOnly: function (oBindingContext, aSelectedContexts) {
            if (aSelectedContexts && aSelectedContexts.length === 1) {
                return true;
            }

            return false;
        },
        handleCustomAction: function (oBindingContext, aSelectedContexts) {
            if (aSelectedContexts && aSelectedContexts.length > 0) {
                MessageBox.show(aSelectedContexts[0].getObject("title"), {
                    icon: MessageBox.Icon.INFORMATION,
                    title: "Custom action triggered!"
                });

            }
        }
    };
});