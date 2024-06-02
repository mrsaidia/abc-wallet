// Copyright © 2023 Stormbird PTE. LTD.

import Foundation

public protocol HardwareWalletFactory {
    func createWallet() -> HardwareWallet
}