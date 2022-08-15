//
//  CreateGameViewModel.swift
//  chessBookApp
//
//  Created by Дмитрий Миронов on 06.08.2022.
//

import UIKit
import CoreData

class CreateGameViewModel: ChessDelegate {
    
    var chessEngine = ChessEngine()
    var boardView = BoardView()
    var movesLabel = UILabel()
    let coreDataManager = CoreDataManager()
    
    func initGame(forBoard board: BoardView, withLabel label: UILabel) {
        boardView = board
        chessEngine.initializeGame()
        boardView.shadowPieces = chessEngine.pieces
        boardView.chessDelegate = self
        boardView.transform = CGAffineTransform(scaleX: 1, y: -1)
        movesLabel = label
    }
    
    func deleteGame() {
        chessEngine.movesArray.removeAll()
        chessEngine.initializeGame()
        boardView.shadowPieces = chessEngine.pieces
        boardView.setNeedsDisplay()
        movesLabel.text = "Ходы"
    }
    
    func cancelMove() {
        chessEngine.cancelMovePiece()
        boardView.shadowPieces = chessEngine.pieces
        boardView.setNeedsDisplay()
        
        if !chessEngine.movesArray.isEmpty {
            movesLabel.text = String(describing: chessEngine.movesArray)
        } else {
            movesLabel.text = "Ходы"
        }
    }
    
    func createGame() -> UIAlertController? {
        let alertController = UIAlertController(title: "Новая партия", message: "Введите название партии", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            let tf = alertController.textFields?.first
            if let newTaskTitle = tf?.text {
                self.coreDataManager.saveTask(withMoves: self.chessEngine.movesArray, withTitle: newTaskTitle)
            }
        }
        
        alertController.addTextField { _ in }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { _ in }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        return alertController
    }
    
    func flipBoard() -> UIImage {
        if boardView.chessOrientation == .downMirrored {
            boardView.transform = CGAffineTransform(scaleX: -1, y: 1)
            boardView.chessOrientation = .upMirrored
            boardView.setNeedsDisplay()
            return UIImage(named: "boardColRowBlack")!
        } else {
            boardView.transform = CGAffineTransform(scaleX: 1, y: -1)
            boardView.chessOrientation = .downMirrored
            boardView.setNeedsDisplay()
            return UIImage(named: "boardColRowWhite")!
        }
    }
    
    func movePiece(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int) {
        chessEngine.movePiece(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
        boardView.shadowPieces = chessEngine.pieces
        boardView.setNeedsDisplay()
        movesLabel.text = String(describing: chessEngine.movesArray)
    }
    
    func pieceAt(col: Int, row: Int) -> ChessPiece? {
        return chessEngine.pieceAt(col: col, row: row)
    }
    
    
}
