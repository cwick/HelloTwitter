//
//  TwitterAPIAuthenticator.swift
//  HelloTwitter
//
//  Created by Carmen Wick on 10/4/14.
//  Copyright (c) 2014 Carmen Wick. All rights reserved.
//

import Foundation

class TwitterAPIAuthenticator {
  class func printBearerToken() {
    var sessionConfig = NSURLSessionConfiguration.ephemeralSessionConfiguration()
    var session = NSURLSession(configuration: sessionConfig)
    var request = NSMutableURLRequest(URL: NSURL(string: "https://api.twitter.com/oauth2/token"))
    var credentials = "yr40AyjoUvDBlE2apn4dfsBqz:ZLelMvsTfhjOMoeDjy2qouo66HayjIVoXJWgMLUIQtCX7eY33Z"
    credentials = credentials.dataUsingEncoding(NSASCIIStringEncoding)!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions())
    
    request.HTTPMethod = "POST"
    request.HTTPBody = String("grant_type=client_credentials").dataUsingEncoding(NSASCIIStringEncoding)
    
    sessionConfig.HTTPAdditionalHeaders = [
      "Authorization": "Basic \(credentials)"
    ]
    
    var task = session.dataTaskWithRequest(request) { (data, response, error) in
      println(NSString(data: data, encoding: NSASCIIStringEncoding))
    }
    
    task.resume()
  }
}