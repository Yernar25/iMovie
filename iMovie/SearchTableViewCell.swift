//
//  TableViewCell.swift
//  iMovie
//
//  Created by Yernar Dyussenbekov on 27.11.2024.
//

import UIKit
import SDWebImage

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var voteAverageLabel: UILabel!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(item: FilmList) {
        titleLabel.text = item.title
        releaseDateLabel.text = item.release_date
        
        voteAverageLabel.layer.cornerRadius = 7
        voteAverageLabel.layer.masksToBounds = true
        
        if item.vote_average < 7 {
            voteAverageLabel.backgroundColor = .lightGray
        }
        
        if item.vote_average >= 7 {
            voteAverageLabel.backgroundColor = .systemGreen
        }
        
        if item.vote_average >= 8 {
            voteAverageLabel.backgroundColor = .magenta
        }
        
        voteAverageLabel.text = " " + String(format: "%.1f", item.vote_average)
        
        
        posterImageView.layer.cornerRadius = 10
        posterImageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w188_and_h282_bestv2"+item.poster_path))
        
    }

}
