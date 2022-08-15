//
//  ArticleViewController.swift
//  chessBookApp
//
//  Created by Дмитрий Миронов on 29.07.2022.
//

import UIKit


class ArticleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITabBarControllerDelegate {
    
    let viewModel = ArticleViewModel()
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchVideoLessons { [weak self] in
            DispatchQueue.main.async {
                self?.loadingIndicator.stopAnimating()
                self?.tableView.isHidden = false
                self?.tableView.reloadData()
            }
        }

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tabBarController?.delegate = self
        tableView.isHidden = true
        loadingIndicator.startAnimating()

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(forTabBar: tabBarController!.selectedIndex)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        guard let customCell = viewModel.articleLessonForCell(forTabBar: tabBarController!.selectedIndex, forCell: cell, atIndexPath: indexPath) else {
            return cell
        }
        
        return customCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tabBarIndex = tabBarController!.selectedIndex
        switch tabBarIndex {
        case 0:
            return
        case 1:
            viewModel.showArticleForIndexPath(forIndexPath: indexPath, forTabBar: 1)
        case 2:
            viewModel.showArticleForIndexPath(forIndexPath: indexPath, forTabBar: 2)
            performSegue(withIdentifier: "showTheory", sender: nil)
        case 3:
            viewModel.showArticleForIndexPath(forIndexPath: indexPath, forTabBar: 3)
            performSegue(withIdentifier: "showBiography", sender: nil)
        default:
            return
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? ShowArticleViewController else { return }
        destination.articleViewModel = viewModel
    }
    
    

}

