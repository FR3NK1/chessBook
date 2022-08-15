//
//  ViewGameViewController.swift
//  chessBookApp
//
//  Created by Дмитрий Миронов on 01.08.2022.
//

import UIKit

class ViewGameViewController: UIViewController {
    

    @IBOutlet weak var boardColRow: UIImageView!
    @IBOutlet weak var boardView: BoardView!
    
    
    var gameListViewModel = GameListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gameListViewModel.initGame(forBoard: boardView)
    }
    
    
    @IBAction func prevButtonTapped(_ sender: UIButton) {
        gameListViewModel.viewPrevMove()
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        gameListViewModel.viewNextMove()
    }
    
    @IBAction func flipBoardButtonTapped(_ sender: UIButton) {
        boardColRow.image = gameListViewModel.flipBoard()
    }

}
