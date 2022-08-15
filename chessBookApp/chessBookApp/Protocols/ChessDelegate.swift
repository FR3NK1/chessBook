//
//  ChessDelegate.swift
//  chessBookApp
//
//  Created by Дмитрий Миронов on 31.07.2022.
//

import Foundation

protocol ChessDelegate {
    func movePiece(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int)
    func pieceAt(col: Int, row: Int) -> ChessPiece?
}
