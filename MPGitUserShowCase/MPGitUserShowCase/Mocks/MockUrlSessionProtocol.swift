//
//  MockUrlSessionProtocol.swift
//  MPGitUserShowCaseTests
//
//  Created by Manish Parihar on 28.05.26.
//

#if DEBUG
import Foundation

/**
 Subclass (MockUrlSessionProtocol) that lets you intercept and mock network requests in unit tests
 */
class MockUrlSessionProtocol: URLProtocol {
    // Closure you set in your test to define what response and data should be returned.
    static var loadingHandler: (() -> (HTTPURLResponse, Data?))?

    // Determines whether this protocol can handle the given request.
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    /**
     Called when a request starts.
     Uses the loadingHandler closure to get a fake response and data.
     Sends them back to the URLSession client (the system that asked for the request).
     Ends the loading process.
     */
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        guard let handler = MockUrlSessionProtocol.loadingHandler else {
            fatalError("Loading handler is not set.")
        }
        let (response, data) = handler()
        client?
            .urlProtocol(
                self,
                didReceive: response,
                cacheStoragePolicy: .notAllowed
            )
        if let data = data {
            client?.urlProtocol(self, didLoad: data)
        }
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {

    }
}

#endif
