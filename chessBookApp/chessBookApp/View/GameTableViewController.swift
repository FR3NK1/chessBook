//
//  GameTableViewController.swift
//  chessBookApp
//
//  Created by Дмитрий Миронов on 30.07.2022.
//

import UIKit

class GameTableViewController: UITableViewController {

    
    let gameListViewModel = GameListViewModel()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gameListViewModel.getGames()
        tableView.reloadData()
    }
    

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return gameListViewModel.numberOfRows()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        guard let customCell = gameListViewModel.gameForCell(forCell: cell, atIndexPath: indexPath) else {
            return cell
        }
        return customCell
    }
        
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            gameListViewModel.deleteGameForIndexPath(forIndexPath: indexPath)
        }
        gameListViewModel.getGames()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        gameListViewModel.viewGameForIndexPath(forIndexPath: indexPath)
        performSegue(withIdentifier: "viewGame", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? ViewGameViewController else { return }
        destination.gameListViewModel = gameListViewModel
    }

}
