//
//  TopTableViewController.swift
//  iMovie
//
//  Created by Yernar Dyussenbekov on 30.11.2024.
//

import UIKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

class TopTableViewController: UITableViewController {
    let apiKey = "28b95a5da61ebd0dd6bd98ceb804e478"
    var arrayTopFilms = [FilmList]()

    override func viewDidLoad() {
        super.viewDidLoad()
        topFilms ()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func topFilms (){
        SVProgressHUD.show()
        let parameters = ["api_key": apiKey, "language": "ru-RU"] as [String: Any]
                          
        AF.request("https://api.themoviedb.org/3/movie/top_rated", method: .get, parameters: parameters).responseData {response in
            SVProgressHUD.dismiss()
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                if let array = json["results"].array {
                    for item in array {
                        let film = FilmList(json: item)
                        self.arrayTopFilms.append(film)
                    }
                }
                
                self.tableView.reloadData()
            }
        }
        
    }
    
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayTopFilms.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TopTableViewCell
        cell.setData(item: arrayTopFilms[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "FilmId") as! FilmDetailViewController
        vc.filmID = arrayTopFilms[indexPath.row].id
        vc.apiKey = apiKey
        navigationController?.show(vc , sender: self)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
