//
//  Created by Carmen Wick on 10/4/14.
//  Copyright (c) 2014 Carmen Wick. All rights reserved.
//

import Foundation

class TwitterAPI {
  private var apiKey: String
  private var apiSecret: String
  
  init(key: String, secret: String) {
    self.apiKey = key
    self.apiSecret = secret
  }
  
  func fetchSearchResults(query: String) {
    fetchBearerToken() { token in
      var url = self.createURL(fromPath: "/1.1/search/tweets.json")
      var urlComponents = NSURLComponents(URL: url, resolvingAgainstBaseURL: false)
      urlComponents.queryItems = [NSURLQueryItem(name: "q", value: query)]
      
      var request = NSMutableURLRequest(URL: urlComponents.URL!)
      var session = self.createURLSession(fromBearerToken: token)
      
      var task = session.dataTaskWithRequest(request) { (data, response, error) in
        var result = self.parseJSONResponse(data)
        
        println(result)
      }
      
      task.resume()
    }
  }
  
  private func fetchBearerToken(callback: (String) ->()) {
    var session = createURLSession()
    var request = NSMutableURLRequest(URL: createURL(fromPath: "/oauth2/token"))
    var credentials = "\(apiKey):\(apiSecret)"
      .dataUsingEncoding(NSASCIIStringEncoding)!
      .base64EncodedStringWithOptions(NSDataBase64EncodingOptions())
    
    request.HTTPMethod = "POST"
    request.HTTPBody = String("grant_type=client_credentials").dataUsingEncoding(NSASCIIStringEncoding)
    
    session.configuration.HTTPAdditionalHeaders = [
      "Authorization": "Basic \(credentials)"
    ]
    
    var task = session.dataTaskWithRequest(request) { (data, response, error) in
      var result = self.parseJSONResponse(data)
      callback(result["access_token"] as String)
    }
    
    task.resume()
  }
  
  private func createURLSession() -> NSURLSession {
    return NSURLSession(configuration: NSURLSessionConfiguration.ephemeralSessionConfiguration())
  }
  
  private func createURLSession(fromBearerToken token: String) -> NSURLSession {
    var session = createURLSession()
    session.configuration.HTTPAdditionalHeaders = [
      "Authorization": "Bearer \(token)"
    ]
    
    return session
  }
  
  private func createURL(fromPath path: String) -> NSURL {
    return NSURL(scheme: "https", host: "api.twitter.com", path: path)
  }
  
  private func parseJSONResponse(response: NSData) -> NSDictionary {
    return NSJSONSerialization.JSONObjectWithData(response,
      options: NSJSONReadingOptions.allZeros,
      error: nil) as NSDictionary
  }
}