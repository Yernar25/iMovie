//
//  ViewController.swift
//  iMovie
//
//  Created by Yernar Dyussenbekov on 27.11.2024.
//

import UIKit
import SVProgressHUD
import Alamofire
import SwiftyJSON
import SDWebImage


class FilmDetailViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var roleLabel: UILabel!
    
    var apiKey = ""
    var filmID = 0
    var actorsArray = [ActorItem]()
    var videoKey = ""
    var videoSite = ""
    var videoType = ""
    
    override func viewDidLoad() {
        playButton.isEnabled = false
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout.invalidateLayout()
        // Do any additional setup after loading the view.
        filmDetails(id: filmID)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(actorsArray.count)
        return actorsArray.count // Количество элементов
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ActorsCollectionViewCell
        let url = "https://media.themoviedb.org/t/p/w276_and_h350_face/"
        cell.actorImageView.sd_setImage(with: URL(string:(url + self.actorsArray[indexPath.row].profilePath)))
        cell.nameLabel.text = actorsArray[indexPath.row].name
        cell.roleLabel.text = actorsArray[indexPath.row].character
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let screenWidth = collectionView.frame.width
        let itemWidth: CGFloat = 190
           let itemHeight: CGFloat = 102   // Высота ячейки
           
           return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    
    @IBAction func playTrailer(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "TrailerVC") as! TrailerViewController
        vc.key = videoKey
        navigationController?.show(vc, sender: self)
    }
    
    func filmDetails (id: Int) {
        print(1)
        SVProgressHUD.show()
        let parameters = ["api_key": apiKey, "language": "ru-RU"] as [String: Any]
        
        // Информация о фильме
        let url = "https://api.themoviedb.org/3/movie/\(id)"
        
        // Актеры фильма
        let urlActors = "https://api.themoviedb.org/3/movie/\(id)/credits"
        
        // Трейлер фильма
        let urlTrailer = "https://api.themoviedb.org/3/movie/\(id)/videos"
        
        //Получение Информация о фильме
        AF.request(url, method: .get, parameters: parameters).responseData {response in
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                let film = FilmItem(json: json)
                self.titleLabel.text = film.title
                self.overviewLabel.text = film.overview
                self.taglineLabel.text = film.tagline
                self.posterImageView.layer.cornerRadius = 10
                self.posterImageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/" + film.posterPath))
                
                if film.voteAverage >= 7 {
                    self.voteAverageLabel.backgroundColor = .systemGreen
                }
                if film.voteAverage >= 8 {
                    self.voteAverageLabel.backgroundColor = .magenta
                }
                self.voteAverageLabel.text = " " + String(format: "%.1f", film.voteAverage)
                self.voteAverageLabel.layer.cornerRadius = 7
                self.voteAverageLabel.layer.masksToBounds = true
                
                //Получение жанров фильма
                if let genresArray = json["genres"].array {
                    var i = 0
                    var genres = ""
                    for item in genresArray {
                        //перед вторым и далее жанром добавляется запятая
                        if i != 0 { genres.append(", ")}
                        genres.append("\(item["name"])")
                        i += 1
                    }
                    self.genresLabel.text = genres
                }
            }
        }
        
        //Получение ссылки трейлера фильма
        AF.request(urlTrailer, method: .get, parameters: parameters).responseData {response in
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                if let array = json["results"].array {
                    if array.count > 0 {
                        if (array[0]["key"].string != "") && (array[0]["site"].string == "YouTube") && (array[0]["type"].string == "Trailer"){
                            self.videoKey = array[0]["key"].string!
                            self.videoSite = array[0]["site"].string!
                            self.videoType = array[0]["type"].string!
                            self.playButton.setTitle("Запустить трейлер", for: .normal)
                            self.playButton.isEnabled = true
                        }
                    }
                }
                
            }
        }
        
        //Получение списка актеров фильма
        AF.request(urlActors, method: .get, parameters: parameters).responseData {response in
            SVProgressHUD.dismiss()
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                
                if let array = json["cast"].array {
                    for item in array {
                        let actor = ActorItem(json: item)
                        self.actorsArray.append(actor)
                        
                        //print(actor.name," ", actor.character)
                        self.collectionView.reloadData()
                    }
                }
                
            }
        }
        
        
    }
    

}

