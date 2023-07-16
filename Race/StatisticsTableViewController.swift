//
//  StatisticsTableViewController.swift
//  Race
//
//  Created by Никита Суровцев on 10.07.23.
//

import UIKit

class StatisticsTableViewController: UITableViewController {
    
    var stats = [
        StatsModel(name: "First player", score: 100),
        StatsModel(name: "Second player", score: 300),
        StatsModel(name: "Third player", score: 6000),
        StatsModel(name: "Fourth player", score: 700),
        StatsModel(name: "Fifth player", score: 10000),
        StatsModel(name: "Sixth player", score: 11234),
        StatsModel(name: "New player", score: 600),
        StatsModel(name: "New player", score: 700),
        StatsModel(name: "New player", score: 1023),
        StatsModel(name: "New player", score: 600),
        StatsModel(name: "New player", score: 700),
        StatsModel(name: "New player", score: 1002),
        StatsModel(name: "New player", score: 600),
        StatsModel(name: "New player", score: 700),
        StatsModel(name: "New player", score: 1000),
        StatsModel(name: "New player", score: 600),
        StatsModel(name: "New player", score: 700),
        StatsModel(name: "New player", score: 1023),
        StatsModel(name: "New player", score: 600),
        StatsModel(name: "New player", score: 700),
        StatsModel(name: "New player", score: 10)
    ].sorted { $0.score > $1.score }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let winnersCellNib = UINib(nibName: "WinnersTableViewCell", bundle: Bundle.main)
        tableView.register(winnersCellNib, forCellReuseIdentifier: "winners")
        
        let notWinnersCellNib = UINib(nibName: "NotWinnersTableViewCell", bundle: Bundle.main)
        tableView.register(notWinnersCellNib, forCellReuseIdentifier: "notWinners")
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stats.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let winnersCell = tableView.dequeueReusableCell(withIdentifier: "winners", for: indexPath) as? WinnersTableViewCell else {return UITableViewCell()}
        
        guard let notWinnersCell = tableView.dequeueReusableCell(withIdentifier: "notWinners", for: indexPath) as? NotWinnersTableViewCell else {return UITableViewCell()}
        
        winnersCell.gamerName.text = stats[indexPath.row].name
        notWinnersCell.gamerName.text = stats[indexPath.row].name
        
        winnersCell.score.text = String(stats[indexPath.row].score)
        notWinnersCell.score.text = String(stats[indexPath.row].score)
        
        notWinnersCell.positionStats.text = String(indexPath.row + 1)
        
        switch indexPath.row {
        case 0:
            winnersCell.imageView?.image = UIImage(named: "1st_place.png")
            return winnersCell
        case 1:
            winnersCell.imageView?.image = UIImage(named: "2nd_place.png")
            return winnersCell
        case 2:
            winnersCell.imageView?.image = UIImage(named: "3rd_place.png")
            return winnersCell
        default:
            return notWinnersCell
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}
