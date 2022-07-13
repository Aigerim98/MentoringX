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

    func postLogin(credentials: Login, completion: @escaping (Result<String?, Error>) -> Void) {
        var components = urlComponents
        components.path = "/auth"
              
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
    
    func getMentorsById(id: Int,token: String, completion: @escaping (MentorCard) -> Void) {
        let queryItem = [URLQueryItem(name: "id", value: String(id))]
        var components = urlComponents
        components.path = "/filter_search/get_user_by_id"
        components.queryItems = queryItem
        guard let url = components.url else {
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("*/*", forHTTPHeaderField: "accept")
        urlRequest.setValue(token, forHTTPHeaderField: "token")
        urlRequest.httpMethod = "GET"
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                print("Error: error calling GET")
                return
            }
           
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print(response)
                print("Error: HTTP request failed")
                return
            }
            
            do {
                let mentorCard = try JSONDecoder().decode(MentorCard.self, from: data)
                print("data: \(data)")
                DispatchQueue.main.async {
                    completion(mentorCard)
                }
            }catch {
                print("no json")
            }
        }
        task.resume()
    }
    
    func getMentorId(token: String, completion: @escaping (MentorIds) -> Void) {
        var components = urlComponents
        components.path = "/filter_search/all"
              
        guard let url = components.url else {
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("*/*", forHTTPHeaderField: "accept")
        urlRequest.setValue(token, forHTTPHeaderField: "token")
        urlRequest.httpMethod = "GET"
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                print("Error: error calling GET")
                return
            }
           
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            
            do {
                let mentorIds = try JSONDecoder().decode(MentorIds.self, from: data)

                DispatchQueue.main.async {
                    completion(mentorIds)
                }
            }catch {
                print("no json")
            }
        }
        task.resume()
    }
    
    func getUserInfo(token: String, completion: @escaping (Person) -> Void) {
        
        var components = urlComponents
        components.path = "/user_info"
              
        guard let url = components.url else {
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.setValue(token, forHTTPHeaderField: "token")
        urlRequest.httpMethod = "GET"
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                print("Error: error calling GET")
                return
            }
           
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            do {
                let person = try JSONDecoder().decode(Person.self, from: data)
                print("data: \(data)")
                DispatchQueue.main.async {
                    completion(person)
                }
            }catch {
                print("no json")
            }
           
        }
        task.resume()
    }
    
    func getUserName(token: String, completion: @escaping (String) -> Void) {
        var components = urlComponents
        components.path = "/user_info/name"
        
        guard let url = components.url else {
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("*/*", forHTTPHeaderField: "accept")
        urlRequest.setValue(token, forHTTPHeaderField: "token")
        urlRequest.httpMethod = "GET"
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                print("Error: error calling GET")
                    return
            }
           
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }

            let message = String(data: data, encoding: .utf8)
                DispatchQueue.main.async {
                    completion(message!)
                }
              }
              task.resume()
    }
    
    func getIsFirstTime(token: String, completion: @escaping (Result<String?, Error>) -> Void) {
        var components = urlComponents
        components.path = "/is_first_time"
              
        guard let url = components.url else {
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("*/*", forHTTPHeaderField: "accept")
        urlRequest.setValue(token, forHTTPHeaderField: "token")
        urlRequest.httpMethod = "GET"
        
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
    
    func postMajors(token: String, credentials: Majors, completion: @escaping (Result<String?, Error>) -> Void) {
        var components = urlComponents
        components.path = "/user_info/majors"
              
        guard let url = components.url else {
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.setValue(token, forHTTPHeaderField: "token")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
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
    
    func postUserInfo(token: String, credentials: UserInfo, completion: @escaping (Result<String?, Error>) -> Void) {
        
        var components = urlComponents
        components.path = "/user_info"
              
        guard let url = components.url else {
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.setValue(token, forHTTPHeaderField: "token")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
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
    

