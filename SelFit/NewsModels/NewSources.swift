//
//  NewSources.swift
//  SelFit
//
//  Created by Reathan Luo on 2/2/22.
//

import Foundation

public struct NewsSource: Decodable, Hashable {
    let id: String?
    let name: String?
    let category: String?
}

public struct AllNewsSources: Decodable {
    let sources: [NewsSource]
}
