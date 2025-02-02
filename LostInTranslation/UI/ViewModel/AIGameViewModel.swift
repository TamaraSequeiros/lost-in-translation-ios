//
//  AIGameViewModel.swift
//  LostInTranslation
//
//  Created by Tamara on 26/01/2025.
//


import Foundation
import UIKit

class AIGameViewModel: ObservableObject {
    
    var player: Player? = UserManager.shared.loadUser()
    
    private let proxyUrl = "https://lost-in-translation-api.onrender.com/api/guess-word"
    private let timeoutInterval: TimeInterval = 5.0
    
    private let deviceIdKey = "LostInTranslation.persistentDeviceIdentifier"
    private let appSecret = "LostInTranslation2025"
    
    private var deviceId: String {
        if let savedId = UserDefaults.standard.string(forKey: deviceIdKey) {
            return savedId
        }
        
        let newId = UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
        UserDefaults.standard.set(newId, forKey: deviceIdKey)
        return newId
    }
    
    private var deviceSignature: String {
        let dataToSign = deviceId + appSecret
        return dataToSign.data(using: .utf8)!
            .base64EncodedString()
    }
    
    func getGuessedWord(from description: String, forbidden: [String]?) -> String {
        if let forbidden = forbidden {
            let used = forbiddenAreUsed(description: description, forbidden: forbidden)
            if !used.isEmpty{
                return "Used forbidden word: \(used)"
            }
        }
        
        let result = getOpenAIGuess(description: description, language: "\(player!.language)")
        switch result {
            case .success(let word):
                return word
            case .failure(let error):
                print(error)
                return "ERROR"
        }
    }
    
    func forbiddenAreUsed(description: String, forbidden: [String]) -> String {
        for forbiddenWord in forbidden {
            if description.lowercased().contains(forbiddenWord.lowercased()) {
                return forbiddenWord
            }
        }
        return ""
    }
    
    func getOpenAIGuess(description: String, language: String) -> Result<String, Error> {
        let url = URL(string: proxyUrl)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(deviceId, forHTTPHeaderField: "X-Device-ID")
        request.setValue(deviceSignature, forHTTPHeaderField: "X-Device-Signature")
        request.timeoutInterval = timeoutInterval
        
        let parameters: [String: Any] = [
            "description": description,
            "language": language
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            return .failure(error)
        }

        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<String, Error>!
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                if (error as NSError).code == NSURLErrorTimedOut {
                    result = .failure(NSError(domain: "TimeoutError",
                                           code: NSURLErrorTimedOut,
                                           userInfo: [NSLocalizedDescriptionKey: "Request timed out after \(self.timeoutInterval) seconds"]))
                } else {
                    print("Error occurred: \(error.localizedDescription)")
                    result = .failure(error)
                }
            } else if let data = data {
                if let rawResponse = String(data: data, encoding: .utf8) {
                    print("Raw response: \(rawResponse)")
                }
                do {
                    // Parse the proxy response
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let word = json["word"] as? String {
                        result = .success(word)
                    } else {
                        // Check for error message from proxy
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                           let error = json["error"] as? String {
                            result = .failure(NSError(domain: "ProxyError", 
                                                    code: -1, 
                                                    userInfo: [NSLocalizedDescriptionKey: error]))
                        } else {
                            result = .failure(NSError(domain: "InvalidResponse", 
                                                    code: -1, 
                                                    userInfo: [NSLocalizedDescriptionKey: "Invalid response format"]))
                        }
                    }
                } catch {
                    result = .failure(error)
                }
            }
            semaphore.signal()
        }

        task.resume()
        
        // Add timeout for semaphore wait
        let waitResult = semaphore.wait(timeout: .now() + timeoutInterval)
        if waitResult == .timedOut {
            task.cancel()
            return .failure(NSError(domain: "TimeoutError",
                                  code: NSURLErrorTimedOut,
                                  userInfo: [NSLocalizedDescriptionKey: "Request timed out after \(timeoutInterval) seconds"]))
        }

        return result
    }
    
}
