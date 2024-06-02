//
//  UnstoppableDomainsNetworkProvider.swift
//  AlphaWalletFoundation
//
//  Created by Vladyslav Shepitko on 23.09.2022.
//

import Combine
import SwiftyJSON
import AlphaWalletENS
import AlphaWalletCore
import AlphaWalletLogger

struct UnstoppableDomainsNetworkProvider {
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func resolveAddress(forName name: String) async throws -> AlphaWallet.Address {
        let response = try await networkService.dataTask(AddressRequest(name: name))
        guard let json = try? JSON(data: response.data) else {
            throw UnstoppableDomainsApiError(localizedDescription: "Error calling \(Constants.unstoppableDomainsAPI.absoluteString) API isMainThread: \(Thread.isMainThread)")
        }

        let value = try UnstoppableDomainsResolver.AddressResolution.Response(json: json)
        if let owner = value.meta.owner {
            infoLog("[UnstoppableDomains] resolved name: \(name) result: \(owner.eip55String)")
            return owner
        } else {
            throw UnstoppableDomainsApiError(localizedDescription: "Error calling \(Constants.unstoppableDomainsAPI.absoluteString) API isMainThread: \(Thread.isMainThread)")
        }
    }

    private struct AddressRequest: URLRequestConvertible {
        let name: String

        public func asURLRequest() throws -> URLRequest {
            guard var components = URLComponents(url: Constants.unstoppableDomainsAPI, resolvingAgainstBaseURL: false) else { throw URLError(.badURL) }
            components.path = "/domains/\(name)"

            let request = try URLRequest(url: components.asURL(), method: .get)
            return request.appending(httpHeaders: ["Authorization": Constants.Credentials.unstoppableDomainsV2ApiKey])
        }
    }
}
