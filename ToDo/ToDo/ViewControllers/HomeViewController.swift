//
//  HomeViewController.swift
//  ToDo
//
//  Created by Avnish Kumar on 06/07/21.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {

    @IBOutlet weak var toDoListTableView: UITableView!
    @IBOutlet weak var addToDoButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var homeViewModel = HomeViewModel()
    var eventList = [Event]()
    var filteredEventList = [Event]()
    var selectedRow = 0
    var isModifying = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        observeViewModelChanges()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.isModifying = false
        self.homeViewModel.updateToDoList()
        self.homeViewModel.filterEventListFor(text: searchBar.text)
    }
    
    func configureUI() {
        hideKeyboardWhenTappedAround()
        toDoListTableView.register(UINib(nibName: CellIdentifier.homeTableView, bundle: nil), forCellReuseIdentifier: CellIdentifier.homeTableView)
        toDoListTableView.estimatedRowHeight = UITableView.automaticDimension
        self.addToDoButton.addShadow()
        let backButtonItem = UIBarButtonItem(title: Constant.emptyString, style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
    }
    
    func observeViewModelChanges() {
        homeViewModel.updateToDoList()
        homeViewModel.filteredEventList.observe { _ in
            self.toDoListTableView.reloadData()
        }
    }
    
    @IBAction func addToDoButtonTapped(_ sender: UIButton) {
        self.isModifying = false
        self.performSegue(withIdentifier: SegueIdentifier.addEditToDoList, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AddEditToDoListViewController {
            if self.isModifying {
                destination.addEditToDoViewModel.isModifying = true
                destination.addEditToDoViewModel.currentEvent = self.homeViewModel.eventForRow(selectedRow)
            }else {
                destination.addEditToDoViewModel.isModifying = false
            }
        }
    }
}

extension HomeViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homeViewModel.getNumberOfEvents()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = toDoListTableView.dequeueReusableCell(withIdentifier: CellIdentifier.homeTableView) as! HomeTableViewCell
        cell.tag = indexPath.row
        cell.delegate = self
        cell.container.backgroundColor = UIColor.getRandomColor(index: cell.tag)
        cell.dateAndTimeLabel.text = homeViewModel.getEventDateStringFor(row: indexPath.row)
        cell.descriptionLabel.text = homeViewModel.getEventDetailFor(row: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension HomeViewController:HomeTableViewCellDelegate {
    func editButtonTappedOn(row: Int) {
        selectedRow = row
        self.isModifying = true
        performSegue(withIdentifier: SegueIdentifier.addEditToDoList, sender: self)
    }
    
    func deleteButtonTappedOn(row: Int) {
        self.homeViewModel.deleteEventFor(row: row)
        self.homeViewModel.filterEventListFor(text: searchBar.text)
    }
}

extension HomeViewController:UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        homeViewModel.filterEventListFor(text: searchText)
    }
}

