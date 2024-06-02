// Copyright © 2018 Stormbird PTE. LTD.

import UIKit
import WebKit
import AlphaWalletFoundation

protocol ClearDappBrowserCacheCoordinatorDelegate: AnyObject {
    func done(in coordinator: ClearDappBrowserCacheCoordinator)
    func didCancel(in coordinator: ClearDappBrowserCacheCoordinator)
}

class ClearDappBrowserCacheCoordinator: Coordinator {
    private let viewController: UIViewController
    private let analytics: AnalyticsLogger

    var coordinators: [Coordinator] = []
    weak var delegate: ClearDappBrowserCacheCoordinatorDelegate?

    init(viewController: UIViewController, analytics: AnalyticsLogger) {
        self.viewController = viewController
        self.analytics = analytics
    }

    func start() {
        UIAlertController.alert(title: "\(R.string.localizable.aSettingsContentsClearDappBrowserCache())?",
                message: nil,
                alertButtonTitles: [R.string.localizable.oK(), R.string.localizable.cancel()],
                alertButtonStyles: [.destructive, .cancel],
                viewController: viewController,
                completion: { choice in
                    guard choice == 0 else {
                        self.delegate?.didCancel(in: self)
                        return
                    }
                    self.logUse()
                    WKWebView.clearCache()
                    self.delegate?.done(in: self)
                })
    }
}

// MARK: Analytics
extension ClearDappBrowserCacheCoordinator {
    private func logUse() {
        analytics.log(action: Analytics.Action.clearBrowserCache)
    }
}
