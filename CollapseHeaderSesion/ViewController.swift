//
//  ViewController.swift
//  CollapseHeaderSesion
//
//  Created by Trương Thắng on 5/15/17.
//  Copyright © 2017 Trương Thắng. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var displayStudent = DataServices.shared.students
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: - UITableViewDataSource

extension ViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Array(displayStudent.keys).count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let className = Array(displayStudent.keys)[section]
        return ((displayStudent[className]?.count) ?? 0) + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let className = Array(displayStudent.keys)[indexPath.section]
        let isHeaderSesion = indexPath.row == 0
        var cell : UITableViewCell
        if isHeaderSesion {
            cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath)
            configureHeaderCell(cell: cell, forRowAtIndexPath: indexPath)
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath)
            configureCell(cell: cell, forRowAtIndexPath: indexPath)
        }
        return cell
    }
    
    func configureCell(cell: UITableViewCell, forRowAtIndexPath indexPath: IndexPath) {
        let className = Array(displayStudent.keys)[indexPath.section]
        cell.textLabel?.text = displayStudent[className]?[indexPath.row-1].firstName ?? ""
    }
    
    func configureHeaderCell(cell: UITableViewCell, forRowAtIndexPath indexPath: IndexPath) {
        let className = Array(displayStudent.keys)[indexPath.section]
        cell.textLabel?.text = className
        
    }
}

// MARK: - <#Mark#>

extension ViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let isHeaderSection = indexPath.row == 0
        if isHeaderSection {
            let className = Array(displayStudent.keys)[indexPath.section]
            if displayStudent[className] != nil, displayStudent[className]!.count != 0 {
                var willRemoveIndexPaths : [IndexPath] = []
                for row in 1 ... displayStudent[className]!.count {
                    let willRemoveIndexPath = IndexPath(row: row, section: indexPath.section)
                    willRemoveIndexPaths.append(willRemoveIndexPath)
                }
                displayStudent[className]?.removeAll()
                self.tableView.beginUpdates()
                tableView.deleteRows(at: willRemoveIndexPaths, with: .fade)
                self.tableView.endUpdates()

            } else {
                displayStudent[className] = DataServices.shared.students[className]
                var willAddIndexPaths : [IndexPath] = []
                for row in 1 ... displayStudent[className]!.count {
                    let willRemoveIndexPath = IndexPath(row: row, section: indexPath.section)
                    willAddIndexPaths.append(willRemoveIndexPath)
                }
                self.tableView.beginUpdates()
                tableView.insertRows(at: willAddIndexPaths, with: .fade)
                self.tableView.endUpdates()

            }
        }
    }
}

