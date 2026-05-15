//
//  ViewController.swift
//  ch09-tableViewCollectionView
//
//  Created by jmleehs on 5/1/26.
//

import UIKit

class CityViewController: UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cityTableView: UITableView!
    
    var cities: [City] = ch09_tableViewCollectionView.load("cityData.json")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        cityTableView.register(UITableViewCell.self, forCellReuseIdentifier: "ymlee")
        
        cityTableView.dataSource = self
        cityTableView.delegate = self
        
        cityTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .top)
        descriptionLabel.text = cities[0].description
    }
    
    @IBAction func editingTableRow(_ sender: UIBarButtonItem) {
            if cityTableView.isEditing == true{
                sender.title = "Edit"
                cityTableView.isEditing = false
            }else{
                sender.title = "Done"
                cityTableView.isEditing = true
            }
    }
}


extension CityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cell = UITableViewCell()
        let cell = tableView.dequeueReusableCell(withIdentifier: "ymlee")!
        
        // 이미지의 크기도 반영되지 않는다.
        let city = cities[indexPath.row]
        
        cell.imageView?.image = UIImage(named: city.imageName)?.resized(to: CGSize(width: 200, height: 100))

        cell.textLabel?.text = city.name
        cell.detailTextLabel?.text = city.country

        cell.textLabel?.textAlignment = .right // 동작하지 않는다.
        cell.accessoryType = .none
        return cell
    }
}

extension CityViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        descriptionLabel.text = cities[indexPath.row].description
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        // 테이불에서의 삭제는 TableViewr가 자동으로 한다.
        if editingStyle == .delete{
            // 반드시 데이터베이스에서 삭제를 하여야 한다.
            cities.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    // 이동하는 경우 호출된다.
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        // 테이블의 row는 TableView가 바꾸어주므로 데이터베이스만 바꾸어주면된다.
        let city = cities.remove(at: sourceIndexPath.row)
        cities.insert(city, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
        }

}

