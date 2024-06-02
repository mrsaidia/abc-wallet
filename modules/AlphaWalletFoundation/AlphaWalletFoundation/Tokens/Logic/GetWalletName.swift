// Copyright © 2020 Stormbird PTE. LTD.

import Foundation
import Combine

//Use the wallet name which the user has set, otherwise fallback to ENS, if available
public class GetWalletName {
    private let domainResolutionService: DomainNameResolutionServiceType

    public init(domainResolutionService: DomainNameResolutionServiceType) {
        self.domainResolutionService = domainResolutionService
    }

    public func assignedNameOrEns(for address: AlphaWallet.Address) -> AnyPublisher<String?, Never> {
        //TODO: pass ref
        if let walletName = FileWalletStorage().name(for: address) {
            return .just(walletName)
        } else {
            let result: CurrentValueSubject<String?, Never> = CurrentValueSubject(nil)
            Task {
                result.value = try? await self.domainResolutionService.reverseResolveDomainName(address: address, server: RPCServer.forResolvingDomainNames)
            }
            return result.eraseToAnyPublisher()
        }
    }
}
