//
//  MySquadViewController.swift
//  blndIn
//
//  Created by Zyad Galal on 4/19/18.
//  Copyright © 2018 Zyad Galal. All rights reserved.
//

import UIKit

class MySquadViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource {

    @IBOutlet weak var MySquadCollectionView: UICollectionView!
    
    var namearr = ["Momen Zarad","Zyad Galal","Omar El Rayes","Mostafa Waleed","Abdullah Ahmed","Abo El Naga","Momen Zarad","Zyad Galal"]
    var membersarr = ["50 Members","10 Members","0 Members","10 Members","20 Members","30 Members","70 Members","1 Members"]
    var imagearr = ["profile","profile","profile","profile","profile","profile","profile","profile"]
    
    override func viewDidLoad() {
        MySquadCollectionView.dataSource = self
        MySquadCollectionView.delegate = self
        customizeCell()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //customize cell layout
    func customizeCell (){
        
        var cellLayout = self.MySquadCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        cellLayout.sectionInset = UIEdgeInsets(top: 0,left: 9,bottom: 0,right: 9)
        cellLayout.minimumLineSpacing = 9
        cellLayout.itemSize = CGSize(width: (self.MySquadCollectionView.frame.size.width - 28)/2, height: (self.MySquadCollectionView.frame.size.height/3.5))
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return namearr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let squadCell = MySquadCollectionView.dequeueReusableCell(withReuseIdentifier: "MySquadCell", for: indexPath) as! MySquadCollectionViewCell
        squadCell.squadImage.image = UIImage(named : imagearr[indexPath.row])
        squadCell.squadName.text = namearr[indexPath.row]
        squadCell.squadNumOfMembers.text = membersarr[indexPath.row]
        
        //image customize
        squadCell.squadImage.layer.cornerRadius = 25
        
        //shdow for cell
        squadCell.layer.borderColor = UIColor.lightGray.cgColor
        squadCell.layer.borderWidth = 0.5
        return squadCell
    }
    
    
}
