//
//  ShowArticleViewController.swift
//  chessBookApp
//
//  Created by Дмитрий Миронов on 07.08.2022.
//

import UIKit

class ShowArticleViewController: UIViewController {

    var articleViewModel = ArticleViewModel()
    
    var showTheoryArray: Theory?
    var showBiographyArray: ChessPlayer?
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        articleViewModel.configurateShowView(firstLabel: firstLabel, secondLabel: secondLabel, imageView: imageView, descriptionTextView: descriptionTextView)
    }
    

    

}
