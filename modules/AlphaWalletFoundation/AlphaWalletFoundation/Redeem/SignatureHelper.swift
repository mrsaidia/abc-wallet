//
//  SignatureHelper.swift
//  Alpha-Wallet
//
//  Created by Oguzhan Gungor on 3/8/18.
//  Copyright © 2018 Alpha-Wallet. All rights reserved.
//

import Foundation
import BigInt

public class SignatureHelper {
    class func signatureAsHex(for message: String, account: AlphaWallet.Address, keystore: Keystore, prompt: String) async throws -> String? {
        let signature = await keystore.signMessageData(message.data(using: String.Encoding.utf8), for: account, prompt: prompt)
        let signatureHex = try? signature.get().hex(options: .upperCase)
        guard let data = signatureHex else {
            return nil
        }
        return data
    }

    public class func signatureAsDecimal(for message: String, account: AlphaWallet.Address, keystore: Keystore, prompt: String) async throws -> String? {
        guard let signatureHex = try await signatureAsHex(for: message, account: account, keystore: keystore, prompt: prompt) else { return nil }
        guard let signatureDecimalString = BigInt(signatureHex, radix: 16)?.description else { return nil }
        return signatureDecimalString
    }
}
