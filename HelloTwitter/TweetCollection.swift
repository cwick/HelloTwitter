//
//  TweetCollection.swift
//  HelloTwitter
//
//  Created by Carmen Wick on 10/6/14.
//  Copyright (c) 2014 Carmen Wick. All rights reserved.
//

import Foundation

struct TweetCollection: SequenceType, ArrayLiteralConvertible {
  private typealias Collection = [Tweet]
  private var data: Collection = []
  typealias Element = Tweet
  
  static func convertFromArrayLiteral(elements: Element...) -> TweetCollection {
    return TweetCollection(elements: elements)
  }
  
  private init(elements: Collection) {
    data = elements
  }
  
  init(fromDictionaryArray elements: NSArray) {
    data = (elements as [NSDictionary]).map() { (var tweet) -> Tweet in
      return (App.createManagedObject("Tweet") as Tweet).initializeFromDictionary(tweet)
    }
  }
  
  func generate() -> Collection.Generator {
    return data.generate()
  }
  
  var count: Int {
    get { return data.count }
  }
  
  subscript(index: Int) -> Tweet {
    get {
      return data[index]
    }
  }
}

