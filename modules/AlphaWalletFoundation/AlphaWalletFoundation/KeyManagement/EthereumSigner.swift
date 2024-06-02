// Copyright © 2019 Stormbird PTE. LTD.

import Foundation
import TrustKeystore

public struct EthereumSigner {
    //https://github.com/AlphaWallet/alpha-wallet-ios/issues/1369
    public static var vitaliklizeConstant: UInt8 {
        return 27
    }
    public init() { }

    public func sign(hash: Data, withPrivateKey key: Data) throws -> Data {
        return try Secp256k1.shared.sign(hash: hash, privateKey: key)
    }

    public func signHashes(_ hashes: [Data], withPrivateKey key: Data) throws -> [Data] {
        return try hashes.map { try sign(hash: $0, withPrivateKey: key) }
    }
}
