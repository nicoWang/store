//
//  ListViewController.swift
//  Store
//
//  Created by Nicolas Wang on 07/10/2020.
//

import UIKit

protocol ListView: AnyObject {
    func reload()
}

class ListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var presenter: ListPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
}

// MARK: - ListView
extension ListViewController: ListView {
    func reload() {
        title = presenter?.title()
        tableView.reloadData()
    }
}

// MARK: - Table DataSource Delegate
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rows = presenter?.numberOfRows(for: section) else { return 0 }
        return rows
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ListCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.selectionStyle = .none
        if let item = presenter?.item(at: indexPath) {
            cell.update(with: item)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectItem(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        
        let label = UILabel()
        label.frame = CGRect.init(x: 25, y: 5, width: headerView.frame.width-30, height: headerView.frame.height-10)
        label.text = presenter?.title(by: section)
        label.font = UIFont.boldSystemFont(ofSize: 25)
        
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

// MARK: - Private
private extension ListViewController {
    func bind() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(ListCell.self)
        presenter?.bind()
    }
}
