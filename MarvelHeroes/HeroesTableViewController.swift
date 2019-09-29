//
//  HeroesTableViewController.swift
//  MarvelHeroes
//
//  Created by Cesar Paiva.
//  Copyright © Cesar Paiva. All rights reserved.
//

import UIKit

class HeroesTableViewController: UITableViewController {

    var name: String?
    var heroes: [Hero] = []
    var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    var loadingData = false
    var currentPage = 0
    var total = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Searching for heroes. Wait..."
        loadHeroes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func loadHeroes() {
        loadingData = true
        MarvelAPI.loadHeroes(name: name, page: currentPage) { (info) in
            if let info = info {
                self.heroes += info.data.results
                self.total = info.data.total
                DispatchQueue.main.async {
                    self.loadingData = false
                    self.label.text = "No heroes found with name \(String(describing: self.name ?? ""))"
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? HeroViewController else { return }
        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow {
            viewController.hero = heroes[indexPathForSelectedRow.row]            
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundView = heroes.count == 0 ? label : nil
        return heroes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HeroTableViewCell else { return UITableViewCell() }
        let hero = heroes[indexPath.row]
        cell.prepareCell(with: hero)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == heroes.count - 10 && !loadingData  && heroes.count != total {
            currentPage += 1
            loadHeroes()
        }
    }

}
