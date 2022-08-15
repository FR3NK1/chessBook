//
//  ChessPlayer.swift
//  chessBookApp
//
//  Created by Дмитрий Миронов on 29.07.2022.
//

import Foundation

struct ChessPlayer: Codable {
    let id: Int
    let name: String
    let description: String
    let rating: Int
    let picture: String
}
