//
//  ImageUploader.swift
//  Mentoring
//
//  Created by Aigerim Abdurakhmanova on 14.07.2022.
//

import Foundation

struct AnyError: Error {

    let error: Error
    init(_ error: Error) {
        self.error = error
    }
}

enum UploadError: Error {
    case failed
}

typealias Parameters = [String: Any]

extension Data {

    var mimeType: String? {
        var values = [UInt8](repeating: 0, count: 1)
        copyBytes(to: &values, count: 1)

        switch values[0] {
        case 0xFF:
            return "image/jpeg"
        case 0x89:
            return "image/png"
        case 0x47:
            return "image/gif"
        case 0x49, 0x4D:
            return "image/tiff"
        default:
            return nil
        }
    }
}

import UIKit

typealias HTTPHeaders = [String: String]

struct Media {
    let key: String
    let fileName: String
    let data: Data
    let mimeType: String

    init?(withImage image: UIImage, forKey key: String) {
        self.key = key
        self.mimeType = "image/jpg"
        self.fileName = "\(arc4random()).jpeg"

        guard let data = image.jpegData(compressionQuality: 0.5) else { return nil }
        self.data = data
    }
}

final class ImageUploader {

    let uploadImage: UIImage
    let number: Int
    
    let endpointURI: URL = .init(string: "http://localhost:8087/upload")!


    init(uploadImage: UIImage, number: Int) {
        self.uploadImage = uploadImage
        self.number = number
    }
    
    func uploadImage(token: String, completionHandler: @escaping (Result<Void, Error>) -> Void) {

        let boundary = generateBoundary()


        guard let mediaImage = Media(withImage: self.uploadImage, forKey: "file") else { return }

        
        var request = URLRequest(url: endpointURI)

        request.httpMethod = "POST"

        request.allHTTPHeaderFields = [
                    "Accept": "application/json",
                    "Content-Type": "multipart/form-data; boundary=\(boundary)",
                    "token": token
                ]

        print(request.allHTTPHeaderFields)
        let dataBody = createDataBody(withParameters: [:], media: [mediaImage], boundary: boundary)
        request.httpBody = dataBody

        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }

            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
        }.resume()
        
        let task = session.dataTask(with: request) { (data, urlResponse, error) in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            let statusCode = (urlResponse as? HTTPURLResponse)?.statusCode ?? 0
            if let _ = data, case (200..<300) = statusCode {
                do {
                    completionHandler(.success(()))
                } catch let error {
                    completionHandler(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }

    func createDataBody(withParameters params: [String: String]?, media: [Media]?, boundary: String) -> Data {

        let lineBreak = "\r\n"
        var body = Data()

        if let parameters = params {
            for (key, value) in parameters {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value + lineBreak)")
            }
        }

        if let media = media {
            for photo in media {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.fileName)\"\(lineBreak)")
                body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
                body.append(photo.data)
                body.append(lineBreak)
            }
        }

        body.append("--\(boundary)--\(lineBreak)")

        return body
    }
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
