//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Andrew Liu on 7/19/15.
//  Copyright (c) 2015 Andrew Liu. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    var filePathURL: NSURL
    var title: String
    
    init(filePathURL: NSURL, title: String) {
        self.filePathURL = filePathURL
        self.title = title
    }
}