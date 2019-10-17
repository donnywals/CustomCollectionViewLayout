import UIKit

class ViewController: UIViewController, UICollectionViewDataSource {
  
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  private let cellIdentifier = "collectionCell"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:cellIdentifier)
  }
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 50
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CustomCollectionViewCell
    
    cell.imageView.image = UIImage(named: "cat_\(indexPath.row%10)")
    
    return cell
  }
}

