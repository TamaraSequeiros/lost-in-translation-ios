import Foundation

class WordGuessAPIClient {
    private let proxyUrl = "https://lost-in-translation-api.onrender.com/api/guess-word"
    private let timeoutInterval: TimeInterval = 5.0
    
    private let deviceAuth: DeviceAuthenticator
    
    init(deviceAuth: DeviceAuthenticator = DeviceAuthenticator()) {
        self.deviceAuth = deviceAuth
    }
    
    func guessWord(description: String, language: String) -> Result<String, Error> {
        let url = URL(string: proxyUrl)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(deviceAuth.deviceId, forHTTPHeaderField: "X-Device-ID")
        request.setValue(deviceAuth.signature, forHTTPHeaderField: "X-Device-Signature")
        request.timeoutInterval = timeoutInterval
        
        let parameters: [String: Any] = [
            "description": description,
            "language": language
        ]
        
        return executeRequest(request, parameters: parameters)
    }
    
    private func executeRequest(_ request: URLRequest, parameters: [String: Any]) -> Result<String, Error> {
        var mutableRequest = request
        
        do {
            mutableRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            return .failure(error)
        }

        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<String, Error>!
        
        let task = URLSession.shared.dataTask(with: mutableRequest) { data, response, error in
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