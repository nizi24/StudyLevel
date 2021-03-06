//
//  Request.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/17.
//

import Foundation

protocol Request {
    associatedtype Response: Decodable
    
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Encodable? { get }
    var contentType: String? { get }
}

extension Request {
    var baseURL: URL {
        URL(string: "https://polpa-api.herokuapp.com")!
    }
    
    func buildURLRequest() -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        var urlRequest = URLRequest(url: url)
        
        switch method {
        case .get:
            components?.queryItems = queryItems
        case .post: fallthrough
        case .patch: fallthrough
        case .delete:
            if let contentType = contentType {
                urlRequest.addValue(contentType + ";boundary=----BoundaryZLdHZy8HNaBmUX0d", forHTTPHeaderField: "Content-Type")
            } else {
                urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        default: break
        }
        
        urlRequest.url = components?.url
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = body as? Data
        return urlRequest
    }
    
    func response(from data: Data, urlResponse: HTTPURLResponse) throws -> Response {
        let decoder = JSONDecoder()
        if (200..<300).contains(urlResponse.statusCode) {
            return try decoder.decode(Response.self, from: data)
        } else {
            throw try decoder.decode(StudyLevelAPIError.self, from: data)
        }
    }
}
