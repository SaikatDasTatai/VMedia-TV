//
//  TVGuidePresentation.swift
//  VMedia TV
//
//  Created by Sd Saikat Das on 14/06/23.
//

import Combine
import UIKit

extension TVGuideViewController.Model {
    init(channelResult: Result<[ChannelModel], NetworkError>,
         programResult: Result<[ProgramModel], NetworkError>) {
        /// All the channels list
        var channels: [ChannelModel] = []
        /// All the program list for the channels
        var programs: [ProgramModel] = []
        
        switch channelResult {
        case .success(let models):
            channels = models
        case .failure(let error):
            // TODO: Implement error view
            // JIRA: Attach Jira ticket
            print(error)
        }
        
        switch programResult {
        case .success(let models):
            programs = models
        case .failure(let error):
            // TODO: Implement error view
            // JIRA: Attach Jira ticket
            print(error)
        }
        
        tvGuideMainViewModel = .init(channels: channels, programs: programs)
    }
}

extension TVGuideMainView.Model {
    init(channels: [ChannelModel], programs: [ProgramModel]) {
        /// Hash map to store Channel ID and Name
        var channelIDNameMapper: [Int: String] = [:]
        /// Hash map to store Channel ID and Programs
        var channelProgramMapper: [Int: [ProgramModel]] = [:]
        //Populate `ChannelIDNameMapper`
        channels.forEach { channelIDNameMapper[$0.id] = $0.CallSign }
        // Track the channel with highest number of programs
        var countHighest = 0
        // Map `channelProgramMapper`
        programs.forEach { program in
            var model = channelProgramMapper[program.recentAirTime.channelID] ?? []
            model.append(program)
            if model.count > countHighest {
                countHighest = model.count
            }
            channelProgramMapper[program.recentAirTime.channelID] = model
        }
        // Flatning the array to have the fit the Grid View Model
        // Logic is not great, Can be optimised , when will be thought through
        var rows: [TVGuideMainView.Row] = []
        for _ in 0..<countHighest {
            channelProgramMapper.keys.forEach { key in
                rows.append(
                    .program(
                        .init(
                            programName: channelProgramMapper[key]?.first?.name ?? "",
                            broadCastTime: (channelProgramMapper[key]?.first?.startTime ?? "").changeToDateFormat
                        )
                    )
                )
                channelProgramMapper[key] = Array(channelProgramMapper[key]?.dropFirst() ?? [])
            }
        }
        // Populate the items model
        let item: TVGuideMainView.Items = .init(
            section: .header(.init()),
            rows: rows
        )
        items = [item]
        // Construct Header Views
        var count = 0
        var headers: [TVGuideMainView.Header] = []
        for channel in channelProgramMapper {
            let frame = CGRect(
                x: .zero,
                y: CGFloat(count) * Spacing.headerCellSize.height + Spacing.space8,
                width: Spacing.headerCellSize.width,
                height: Spacing.headerCellSize.height - Spacing.space8
            )
            headers.append(.init(frame: frame, model: .init(
                channel: channelIDNameMapper[channel.key]
            )))
            count += 1
        }
        
        self.headers = headers
    }
}

extension String {
    var changeToDateFormat: Self {
        let dateFormatter = DateFormatter()
        // save locale temporarily
        let tempLocale = dateFormatter.locale
        // set locale to reliable US_POSIX
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:SSSZ"
        guard let date = dateFormatter.date(from: self) else { return "" }
        
        //"dd-MM-yyyy HH:mm:ss"
        dateFormatter.dateFormat = "MMM d, yyyy HH:mm a" ;
        dateFormatter.locale = tempLocale
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}
