//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Jason Waldroup on 9/10/16.
//  Copyright © 2016 Jason Waldroup. All rights reserved.
//

import Foundation
class RecordedAudio: NSObject{
    var filePathUrl: NSURL
    var title: String
    
    init (filePathUrl : NSURL, title : String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}