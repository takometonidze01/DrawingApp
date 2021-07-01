//
//  GalleryViewController.swift
//  SimpleDrawApp
//
//  Created by CodergirlTM on 01.07.21.
//

import UIKit

class GalleryViewController: BaseViewController {
    let cellIdentifier = "ItemCollectionViewCell"

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setumCollectionView()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func newPicBtn(_ sender: Any) {
        coordinator?.paintVC()
    }
    private func setumCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "ItemCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    
   

}
extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        
        
        return cell
    }
}
