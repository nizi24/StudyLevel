//
//  StudyLevelClient.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/17.
//

import Foundation

public class StudyLevelClient {
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient = URLSession.shared) {
        self.httpClient = httpClient
    }

    func send<Req : Request>(
        request: Req,
        completion: @escaping (Result<Req.Response, Error>) -> Void)
    {
        let urlRequest = request.buildURLRequest()
        
        httpClient.sendRequest(urlRequest) { result in
            switch result {
            case .success((let data, let urlResponse)):
                do {
                    let response = try request.response(from: data, urlResponse: urlResponse)
                    completion(.success(response))
                } catch let error as StudyLevelAPIError {
                    completion(.failure(error))
                } catch {
                    completion(.failure(StudyLevelClientError.responseParseError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

