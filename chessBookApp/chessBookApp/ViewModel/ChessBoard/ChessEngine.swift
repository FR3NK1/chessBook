//
//  ChessEngine.swift
//  chessBookApp
//
//  Created by Дмитрий Миронов on 31.07.2022.
//

import UIKit

struct ChessEngine {
    var pieces = Set<ChessPiece>()
    var movesArray = [String]()
    var targetsArray = [ChessPiece]()

    
    func pieceAt(col: Int, row: Int) -> ChessPiece? {
        for piece in pieces {
            if piece.col == col && piece.row == row {
                return piece
            }
        }
        return nil
    }
    
    mutating func movePiece(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int) {
        if !canMovePiece(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow) {
            return
        }
        
        guard let movingPiece = pieceAt(col: fromCol, row: fromRow) else {
            return
        }
        
        if let target = pieceAt(col: toCol, row: toRow) {
            if target.isWhite == movingPiece.isWhite {
                return
            }
            targetsArray.append(target)
            pieces.remove(target)
        } else {
            targetsArray.append(ChessPiece(col: 0, row: 0, imageName: "NoTarget", isWhite: true))
        }
        pieces.remove(movingPiece)
        pieces.insert(ChessPiece(col: toCol, row: toRow, imageName: movingPiece.imageName, isWhite: movingPiece.isWhite))
        guard let from = numToLet(fromNum: fromCol), let to = numToLet(fromNum: toCol) else { return }
        movesArray.append("\(from)\(fromRow+1)-\(to)\(toRow+1)")
    }
    
    mutating func cancelMovePiece() {
        
        guard !movesArray.isEmpty else { return }
        let toMove = movesArray.last?.split(separator: "-").first
        let fromMove = movesArray.last?.split(separator: "-").last
        let fromMoveArray = Array(fromMove!)
        let toMoveArray = Array(toMove!)
        movePiece(fromCol: letToNum(fromLet: fromMoveArray[0])!, fromRow: Int(String(fromMoveArray[1]))!-1, toCol: letToNum(fromLet: toMoveArray[0])!, toRow: Int(String(toMoveArray[1]))!-1)
 
        movesArray = movesArray.dropLast()
        movesArray = movesArray.dropLast()
        targetsArray = targetsArray.dropLast()

        if targetsArray.last?.imageName != "NoTarget" {
            pieces.insert(targetsArray.last!)
        }
        targetsArray = targetsArray.dropLast()

    }
    
    func canMovePiece(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int) -> Bool {
        if fromCol == toCol && fromRow == toRow {
            return false
        }
        return true
    }

    mutating func initializeGame() {
        pieces.removeAll()
        
        for i in 0..<2 {
            pieces.insert(ChessPiece(col: i * 7, row: 0, imageName: "rook_w", isWhite: true))
            pieces.insert(ChessPiece(col: i * 7, row: 7, imageName: "rook_b", isWhite: false))
            pieces.insert(ChessPiece(col: 1 + i * 5, row: 0, imageName: "knight_w", isWhite: true))
            pieces.insert(ChessPiece(col: 1 + i * 5, row: 7, imageName: "knight_b", isWhite: false))
            pieces.insert(ChessPiece(col: 2 + i * 3, row: 0, imageName: "bishop_w", isWhite: true))
            pieces.insert(ChessPiece(col: 2 + i * 3, row: 7, imageName: "bishop_b", isWhite: false))
        }

        pieces.insert(ChessPiece(col: 3, row: 0, imageName: "queen_w", isWhite: true))
        pieces.insert(ChessPiece(col: 3, row: 7, imageName: "queen_b", isWhite: false))
        pieces.insert(ChessPiece(col: 4, row: 0, imageName: "king_w", isWhite: true))
        pieces.insert(ChessPiece(col: 4, row: 7, imageName: "king_b", isWhite: false))
        
        for i in 0..<8 {
            pieces.insert(ChessPiece(col: i, row: 1, imageName: "pawn_w", isWhite: true))
            pieces.insert(ChessPiece(col: i, row: 6, imageName: "pawn_b", isWhite: false))
        }
    }
    
    func numToLet(fromNum num: Int) -> String? {
        switch num {
        case 0:
            return "a"
        case 1:
            return "b"
        case 2:
            return "c"
        case 3:
            return "d"
        case 4:
            return "e"
        case 5:
            return "f"
        case 6:
            return "g"
        case 7:
            return "h"
        default:
            return nil
        }
    }
    
    func letToNum(fromLet letter: Character) -> Int? {
        switch letter {
        case "a":
            return 0
        case "b":
            return 1
        case "c":
            return 2
        case "d":
            return 3
        case "e":
            return 4
        case "f":
            return 5
        case "g":
            return 6
        case "h":
            return 7
        default:
            return nil
        }
    }
}
