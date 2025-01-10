class GraphqlQuery {
  static String postRetrieveConstantData() => '''
      query Intros {
  mobileAppConfig(where: {id: "clgag94j13sm50bo96b3r80f7"}) {
    introPageInfo {
      subtitle
      title
      type
      asset {
        url
        fileName
      }
    }
    appVersions
    appUpdateMessage
    fdRoi
    kycStatusMapping
    netWorthCertificateMessage
    referralMessage
    roiSourceMessage
    savingRoi
    showSip
    ifaData
    splashPageMedia {
      subtitle
      title
      asset {
        url
        fileName
      }
    }
    investBanner {
      fileName
      url
    }
    loginPageInfo {
      title
      subtitle
      asset {
        fileName
        url
      }
    }
    signAgreementTnc
    paymentGateways {
      title
      gatewayId
      logo {
        fileName
        url
      }
    }
    transactionTabs {
      title
      tabHeader
    }
    dashboardActions {
      title
      subtitle
      corouselItems {
        title
        subtitle
        imageLink
        type
        data
        image {
          fileName
          url
        }
      }
    }
    appIfaId
    skipSchemes
    actionWidgets {
      description
      deeplink
      logo {
        fileName
        url
      }
      title
      widgetScreen
      backgroundColor {
        hex
      }
    }
  }
}
    ''';
}
