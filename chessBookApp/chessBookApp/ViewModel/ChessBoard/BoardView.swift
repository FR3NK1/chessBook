//
//  BoardView.swift
//  chessBookApp
//
//  Created by Дмитрий Миронов on 31.07.2022.
//

import UIKit

class BoardView: UIView {
    var shadowPieces: Set<ChessPiece> = Set<ChessPiece>()
    var chessDelegate: ChessDelegate?
    var fromCol: Int? = nil
    var fromRow: Int? = nil
    let squareSize: Double = 40
    
    var movingImage: UIImage? = nil
    var movingPieceX: CGFloat = -1
    var movingPieceY: CGFloat = -1
    
    var chessOrientation: UIImage.Orientation = .downMirrored
    

    override func draw(_ rect: CGRect) {
        drawBoard()
        drawPieces()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let fingerLocation = touch.location(in: self)
        fromCol = Int(fingerLocation.x / squareSize)
        fromRow = Int(fingerLocation.y / squareSize)
        
        if let fromCol = fromCol, let fromRow = fromRow, let movingPiece = chessDelegate?.pieceAt(col: fromCol, row: fromRow) {
//            movingImage = UIImage(named: movingPiece.imageName)
            guard let image = UIImage(named: movingPiece.imageName) else { return }
            movingImage = UIImage(cgImage: image.cgImage!, scale: image.scale, orientation: chessOrientation)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let first = touches.first!
        let fingerLocation = first.location(in: self)
        movingPieceX = fingerLocation.x
        movingPieceY = fingerLocation.y
        if movingPieceX < 0 || movingPieceX > 320 || movingPieceY < 0 || movingPieceY > 320 {
            return
        }
        setNeedsDisplay()
            
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let fingerLocation = touch.location(in: self)
        var toCol = Int(fingerLocation.x / squareSize)
        var toRow = Int(fingerLocation.y / squareSize)
        
        if let fromCol = fromCol, let fromRow = fromRow, fromCol != toCol || fromRow != toRow {
            if (toCol > 7 || toCol < 0 || toRow > 7 || toRow < 0) {
                toCol = fromCol
                toRow = fromRow
            }
            chessDelegate?.movePiece(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
        }
        movingImage = nil
        fromCol = nil
        fromRow = nil
        setNeedsDisplay()
    }
    
    func drawPieces() {
        for piece in shadowPieces where fromCol != piece.col || fromRow != piece.row {
            guard let image = UIImage(named: piece.imageName) else { return }
            let pieceImage = UIImage(cgImage: image.cgImage!, scale: image.scale, orientation: chessOrientation)
            pieceImage.draw(in: CGRect(x: Double(piece.col) * squareSize, y: Double(piece.row) * squareSize, width: squareSize, height: squareSize))
        }
        movingImage?.draw(in: CGRect(x: movingPieceX - squareSize/2, y: movingPieceY - squareSize/2, width: squareSize, height: squareSize))
        
    }
    
    
    func drawBoard() {
        drawTwoRowsAt(y: 0 * squareSize)
        drawTwoRowsAt(y: 2 * squareSize)
        drawTwoRowsAt(y: 4 * squareSize)
        drawTwoRowsAt(y: 6 * squareSize)
    }
    
    func drawTwoRowsAt(y: CGFloat) {
        drawSquareAt(x: 0 * squareSize, y: y)
        drawSquareAt(x: 2 * squareSize, y: y)
        drawSquareAt(x: 4 * squareSize, y: y)
        drawSquareAt(x: 6 * squareSize, y: y)
        
        drawSquareAt(x: 1 * squareSize, y: y + squareSize)
        drawSquareAt(x: 3 * squareSize, y: y + squareSize)
        drawSquareAt(x: 5 * squareSize, y: y + squareSize)
        drawSquareAt(x: 7 * squareSize, y: y + squareSize)
    }
    
    func drawSquareAt(x: CGFloat, y: CGFloat) {
        let path = UIBezierPath(rect: CGRect(x: x, y: y, width: squareSize, height: squareSize))
        #colorLiteral(red: 0.4666666667, green: 0.5803921569, blue: 0.3333333333, alpha: 1).setFill()
        path.fill()
    }
    

}
