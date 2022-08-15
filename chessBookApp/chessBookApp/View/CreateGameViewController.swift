//
//  CreateViewController.swift
//  chessBookApp
//
//  Created by Дмитрий Миронов on 31.07.2022.
//

import UIKit
import CoreData

class CreateGameViewController: UIViewController {
   
    
    @IBOutlet weak var boardColRow: UIImageView!
    @IBOutlet weak var boardView: BoardView!
    @IBOutlet weak var movesLabel: UILabel!
    
    var createGameViewModel = CreateGameViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGameViewModel.initGame(forBoard: boardView, withLabel: movesLabel)
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        createGameViewModel.deleteGame()
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        createGameViewModel.cancelMove()
    }
    
    @IBAction func createButtonTapped(_ sender: UIButton) {
        guard let alertController = createGameViewModel.createGame() else { return }
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func flipChessColorButtonTapped(_ sender: UIButton) {
        boardColRow.image = createGameViewModel.flipBoard()
    }
    
    
}
