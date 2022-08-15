//
//  ViewModel.swift
//  chessBookApp
//
//  Created by Дмитрий Миронов on 28.07.2022.
//

import Foundation
import UIKit


class ArticleViewModel {
    
    private var videoLessonsArray: [VideoLesson]?
    private var theoryArray: [Theory]?
    private var chessPlayerArray: [ChessPlayer]?
    var showTheoryArray: Theory?
    var showBiographyArray: ChessPlayer?
    
    let networkManager = NetworkManager()
    
    func fetchVideoLessons(completion: @escaping() -> ()) {
        networkManager.parse { [weak self] json in
            self?.videoLessonsArray = json.videoLessons
            self?.theoryArray = json.theory
            self?.chessPlayerArray = json.chessPlayer
            completion()
        }
    }
    
    func numberOfRows(forTabBar tabBarIndex: Int) -> Int {
        switch tabBarIndex {
        case 0:
            return 0
            
        case 1:
            return videoLessonsArray?.count ?? 0
            
        case 2:
            return theoryArray?.count ?? 0
            
        case 3:
            return chessPlayerArray?.count ?? 0
            
        default:
            return 0
        }
    }
    
    func articleLessonForCell(forTabBar tabBarIndex: Int,forCell cell: CustomTableViewCell, atIndexPath indexPath: IndexPath) -> CustomTableViewCell? {
        
        switch tabBarIndex {
            
        case 0:
            return nil
            
        case 1:
            guard let dataArray = videoLessonsArray else {
                return nil
            }
            cell.titleLabel.text = dataArray[indexPath.row].title
            
            cell.secondLabel.text =  separatedViews(dataArray[indexPath.row].views)
            let linkString: String = "https://i.ytimg.com/vi/\(String(describing: dataArray[indexPath.row].link.components(separatedBy: "youtu.be/").last!))/mqdefault.jpg"
            
            cell.picture.imageFromServerURL(urlString: linkString, PlaceHolderImage: UIImage.init(named: "board")!)
            
            return cell
            
        case 2:
            guard let dataArray = theoryArray else {
                return nil
            }
            cell.titleLabel.text = dataArray[indexPath.row].title
            cell.secondLabel.text =  "\(dataArray[indexPath.row].type)"
            
            cell.picture.imageFromServerURL(urlString: dataArray[indexPath.row].picture, PlaceHolderImage: UIImage.init(named: "board")!)
            
            return cell
            
        case 3:
            guard let dataArray = chessPlayerArray else {
                return nil
            }
            cell.titleLabel.text = dataArray[indexPath.row].name
            cell.secondLabel.text =  "Рейтинг: \(dataArray[indexPath.row].rating)"
            
            cell.picture.imageFromServerURL(urlString: dataArray[indexPath.row].picture, PlaceHolderImage: UIImage.init(named: "player")!)
            
            return cell
            
        default:
            return nil
        }
        
    }
    
    private func separatedViews(_ number: Any) -> String {
        guard let itIsANumber = number as? NSNumber else { return "Без просмотров" }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.decimalSeparator = ","
        return "\(formatter.string(from: itIsANumber)!) просмотров"
    }
    
    func showArticleForIndexPath(forIndexPath indexPath: IndexPath, forTabBar tabBarIndex: Int) {
        switch tabBarIndex {
        case 0:
            return
        case 1:
            guard let dataArray = videoLessonsArray else { return }
            if let url = URL(string: dataArray[indexPath.row].link) {
                UIApplication.shared.open(url)
            }
        case 2:
            guard let dataArray = theoryArray else { return }
            showTheoryArray = dataArray[indexPath.row]
        case 3:
            guard let dataArray = chessPlayerArray else { return }
            showBiographyArray = dataArray[indexPath.row]
        default:
            return
        }
    }
    
    func configurateShowView(firstLabel: UILabel, secondLabel: UILabel, imageView: UIImageView, descriptionTextView: UITextView) {
        if showTheoryArray != nil {
            guard let title = showTheoryArray?.title, let type = showTheoryArray?.type, let picture = showTheoryArray?.picture, let description = showTheoryArray?.description else { return }
            firstLabel.text = title
            secondLabel.text = type
            imageView.imageFromServerURL(urlString: picture, PlaceHolderImage: UIImage.init(named: "board")!)
            descriptionTextView.text = description
        } else if showBiographyArray != nil {
            guard let name = showBiographyArray?.name, let rating = showBiographyArray?.rating, let picture = showBiographyArray?.picture, let description = showBiographyArray?.description else { return }
            firstLabel.text = name
            secondLabel.text = "Рейтинг: \(rating)"
            imageView.imageFromServerURL(urlString: picture, PlaceHolderImage: UIImage.init(named: "player")!)
            descriptionTextView.text = description
        }
    }
    
}

extension UIImageView {
    
    public func imageFromServerURL(urlString: String, PlaceHolderImage:UIImage) {
        if self.image == nil{
            self.image = PlaceHolderImage
        }
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "No Error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }
}


