//
//  VideoLesson.swift
//  chessBookApp
//
//  Created by Дмитрий Миронов on 29.07.2022.
//

import Foundation

struct APIResult: Codable {
    let chessPlayer: [ChessPlayer]
    let videoLessons: [VideoLesson]
    let theory: [Theory]

    enum CodingKeys: String, CodingKey {
        case chessPlayer = "chess_player"
        case videoLessons = "video_lessons"
        case theory
    }
}
