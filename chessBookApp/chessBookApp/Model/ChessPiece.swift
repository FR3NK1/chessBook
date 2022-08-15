//
//  ChessPiece.swift
//  chessBookApp
//
//  Created by Дмитрий Миронов on 31.07.2022.
//

import Foundation

struct ChessPiece: Hashable {
    let col: Int
    let row: Int
    let imageName: String
    let isWhite: Bool
}
