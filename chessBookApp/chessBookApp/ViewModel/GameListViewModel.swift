//
//  GameListViewModel.swift
//  chessBookApp
//
//  Created by Дмитрий Миронов on 31.07.2022.
//

import UIKit
import CoreData

class GameListViewModel: ChessDelegate {
    
    
    
    let coreDataManager = CoreDataManager()
    var chessEngine = ChessEngine()
    var boardView = BoardView()
    var games: [Game] = []
    var viewGame = Game()
    var moveNum = 0
    
    func getGames() {
        let context = coreDataManager.getContext()
        let fetchRequest: NSFetchRequest<Game> = Game.fetchRequest()
//        let sortDescriptor = NSSortDescriptor(key: "title", ascending: false)
//        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            games = try context.fetch(fetchRequest)
            games.reverse()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func numberOfRows() -> Int {
        return games.count
    }
    
    func gameForCell(forCell cell: UITableViewCell, atIndexPath indexPath: IndexPath) -> UITableViewCell? {
        cell.textLabel?.text = games[indexPath.row].title
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    
    func deleteGameForIndexPath(forIndexPath indexPath: IndexPath) {
        let context = coreDataManager.getContext()
        let fetchRequest: NSFetchRequest<Game> = Game.fetchRequest()
        if var objects = try? context.fetch(fetchRequest) {
            objects.reverse()
            context.delete(objects[indexPath.row])
        }

        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func viewGameForIndexPath(forIndexPath indexPath: IndexPath) {
        viewGame = games[indexPath.row]
    }
    
    
    func initGame(forBoard board: BoardView) {
        boardView = board
        chessEngine.initializeGame()
        boardView.shadowPieces = chessEngine.pieces
        boardView.chessDelegate = self
        boardView.transform = CGAffineTransform(scaleX: 1, y: -1)
        moveNum = 0
    }
    
    
    func viewNextMove() {
        
        guard let movesArray = viewGame.movesArray else { return }
        if moveNum < movesArray.count {
            let move = movesArray[moveNum]
            let fromMove = move.split(separator: "-").first
            let toMove = move.split(separator: "-").last
            let fromMoveArray = Array(fromMove!)
            let toMoveArray = Array(toMove!)
            movePiece(fromCol: letToNum(fromLet: fromMoveArray[0])!, fromRow: Int(String(fromMoveArray[1]))!-1, toCol: letToNum(fromLet: toMoveArray[0])!, toRow: Int(String(toMoveArray[1]))!-1)
            moveNum += 1
        }
    }
    
    func viewPrevMove() {
        if moveNum != 0 {
            chessEngine.cancelMovePiece()
            boardView.shadowPieces = chessEngine.pieces
            boardView.setNeedsDisplay()
            moveNum -= 1
        }
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
    }
    
    func pieceAt(col: Int, row: Int) -> ChessPiece? {
        return chessEngine.pieceAt(col: col, row: row)
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
