//
//  HistorySearchRecord.swift
//  FlickrSearchAssignment
//
//  Created by Mohammad Zulqarnain on 19/12/2019.
//  Copyright © 2019 Mohammad Zulqarnain. All rights reserved.
//

import Foundation

/* SearchRecord
This entity struct contains the implementation for search history SearchRecord attributes and operator method
*/
struct SearchRecord: Codable, Equatable  {
  internal let string: String
  internal let time: String
    
    static func == (lhs: SearchRecord, rhs: SearchRecord) -> Bool {
        return  lhs.string == rhs.string &&
                lhs.time == rhs.time
    }
}
