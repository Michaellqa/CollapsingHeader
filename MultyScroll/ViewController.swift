//
//  ViewController.swift
//  MultyScroll
//
//  Created by Micky on 02/07/2018.
//  Copyright © 2018 Micky. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .blue
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    lazy var internalHeaderView: UIView = {
        let width = UIScreen.main.bounds.width
        let internalView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 200))
        internalView.translatesAutoresizingMaskIntoConstraints = false
        internalView.backgroundColor = UIColor.magenta
        
        let v = UIView(frame: CGRect(x: 100, y: 100, width: 50, height: 50))
        v.layer.cornerRadius = 25
        v.backgroundColor = .green
        internalView.addSubview(v)
        v.center = internalView.center
        
        return internalView
    }()
    lazy var headerView: CollapsingHeaderView = {
        let header = CollapsingHeaderView(minVisibleHeight: 40, headerView: internalHeaderView)
        header.translatesAutoresizingMaskIntoConstraints = false
        header.onHeightChanged = { _, _ in
            self.tableView.reloadData()
        }
        return header
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupTable()
    }
    
    func setupTable() {
        view.addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.tableHeaderView = internalHeaderView
        
    }
    
}

extension ViewController: UITableViewDataSource {
    
    var rus: [UIColor] { return [.red, .yellow, .black] }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = rus[indexPath.row % 3]
        return cell
    }
}










