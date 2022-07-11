//
//  NetworkManager.swift
//  Mentoring
//
//  Created by Aigerim Abdurakhmanova on 11.07.2022.
//

import Foundation

enum APINetworkError: Error {
    case dataNotFound
    case httpRequestFailed
}

struct Response: Codable {
    let id: String
    let username: String
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case token
    }
}

extension APINetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .dataNotFound:
            return "Error: Did not receive data"
        case .httpRequestFailed:
            return "Error: HTTP request failed"
        }
    }
}

class NetworkManager {
    static var shared = NetworkManager()
    
    var urlComponents: URLComponents = {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "localhost"
        components.port = 8087
        //components.host = "localhost:8087"
        return components
    }()
    
    private let session: URLSession

    private init() {
        session = URLSession(configuration: .default)
    }

    func postRegister(credentials: Registration, completion: @escaping (Result<String?, Error>) -> Void) {
        var components = urlComponents
        components.path = "/register"
              
        guard let url = components.url else {
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("*/*", forHTTPHeaderField: "accept")
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = try? JSONEncoder().encode(credentials)

        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(.failure(error!))
                }
                    return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(APINetworkError.dataNotFound))
                }
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                DispatchQueue.main.async {
                    print(response)
                    completion(.failure(APINetworkError.httpRequestFailed))
                }
                return
            }

            let message = String(data: data, encoding: .utf8)
                DispatchQueue.main.async {
                    completion(.success(message))
                }
              }
              task.resume()
          }
    
    func postRegisterVerification(credentials: ProcessRegistration, completion: @escaping (Result<String?, Error>) -> Void) {
        var components = urlComponents
        components.path = "/process_register"
        
        guard let url = components.url else {
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("*/*", forHTTPHeaderField: "accept")
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = try? JSONEncoder().encode(credentials)
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(.failure(error!))
                }
                    return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(APINetworkError.dataNotFound))
                }
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                DispatchQueue.main.async {
                    print(response)
                    completion(.failure(APINetworkError.httpRequestFailed))
                }
                return
            }

            let message = String(data: data, encoding: .utf8)
                DispatchQueue.main.async {
                    completion(.success(message))
                }
              }
              task.resume()
          }
    
}
    

