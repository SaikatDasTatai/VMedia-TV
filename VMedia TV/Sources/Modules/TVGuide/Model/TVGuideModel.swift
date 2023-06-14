//
//  TVGuideModel.swift
//  VMedia TV
//
//  Created by Sd Saikat Das on 15/06/23.
//

import Foundation

struct ChannelModel: Decodable {
    let orderNum: Int
    let accessNum: Int
    let CallSign: String
    let id: Int
}

struct ProgramModel: Hashable, Decodable {
    struct RecentAirTime: Hashable, Decodable {
        let id: Int
        let channelID: Int
    }
    let startTime: String
    let recentAirTime: RecentAirTime
    let length: Int
    let name: String
}
