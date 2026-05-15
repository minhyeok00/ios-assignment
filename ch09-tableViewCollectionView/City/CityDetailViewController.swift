import UIKit

class CityDetailViewController: UIViewController {

    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    var city: City?
    var cityMasterViewController: CityViewController! 

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let city = city else { return }
        cityNameLabel.text = city.cityName
        
        // 마스터의 이미지풀에서 가져오기
        if let image = cityMasterViewController.imagePool[city.imageName] {
            cityImageView.image = image
        } else {
            // 없으면 새로 리사이징해서 넣기
            let resizedImage = UIImage(named: city.imageName)?.resized(to: CGSize(width: 200, height: 100))
            cityImageView.image = resizedImage
            cityMasterViewController.imagePool[city.imageName] = resizedImage
        }
    }
}
