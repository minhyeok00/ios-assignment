import UIKit

class CityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var cities = City.prepareCity()
    
    // 이미지 캐싱을 위한 이미지풀 선언
    var imagePool = [String: UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
        let city = cities[indexPath.row]
        
        cell.textLabel?.text = city.cityName
        
        // 
        if var image = imagePool[city.imageName] {
            // 이미지풀에 있으면 리사이징해서 사용
            image = image.resized(to: CGSize(width: 200, height: 100))
            cell.imageView?.image = image
        } else {
            // 없으면 새로 생성 후 리사이징하여 이미지풀에 저장
            cell.imageView?.image = UIImage(named: city.imageName)?.resized(to: CGSize(width: 200, height: 100))
            imagePool[city.imageName] = cell.imageView?.image
        }
        
        return cell
    }
    
    // 데이터 전달을 위한 prepare 메서드 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? CityDetailViewController {
            if let selectedIndex = tableView.indexPathForSelectedRow?.row {
                dest.city = cities[selectedIndex]
                // 상세 화면에서 메인 화면의 imagePool에 접근할 수 있게 자신(self)을 넘겨줌
                dest.cityMasterViewController = self
            }
        }
    }
}
