//
//  ViewController.swift
//  GarBageCalendar2
//
//  Created by Takumi Otsuka on 2021/05/15.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var monthLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedDate = Date()
    var totalSquares = [String]()
    var season:Int = 0
    let calendarCycle = CalendarCycle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setCellsView()
        setMonthView()
    }
    
    func setCellsView() {
        let width = (collectionView.frame.size.width - 2)/8
        let height = (collectionView.frame.size.height - 2)/8
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    func setMonthView() {
        totalSquares.removeAll()
        
        let daysInMonth = CalendarHelper().daysInMonth(date: selectedDate)
        let firstDayOfMonth = CalendarHelper().firstOfMonth(date: selectedDate)
        let startingSpaces = CalendarHelper().weekDay(date: firstDayOfMonth)
        self.season = CalendarHelper().getSeason(date: selectedDate)
        
        var count: Int = 1
        
        while count <= 42 {
            if count <= startingSpaces || count - startingSpaces > daysInMonth {
                totalSquares.append("")
            } else {
                totalSquares.append(String(count - startingSpaces))
            }
            count += 1
        }
        monthLabel.text = CalendarHelper().monthJapaneseString(date: selectedDate)
        collectionView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calCell", for: indexPath) as! CalendarCell
        for i in cell.stackView.subviews{
//            print(i)
            cell.stackView.removeArrangedSubview(i)
            i.removeFromSuperview()
        }
        cell.dayOfMonth.text = totalSquares[indexPath.item]
        
//
        var imageView:[UIImageView] = []
        
//        imageView.contentMode = .scaleAspectFit
//        print(totalSquares[indexPath.item])
        
        if totalSquares[indexPath.item] != "" {
            for (index, i) in calendarCycle.district1[season][0][indexPath.item % 7].enumerated() {
                let name = CalendarHelper().garbageTypeString(typeInt: GarbageType(rawValue: i)!)
                if name != nil {
                    let imageV = UIImageView()
                    imageView.append(imageV)
                    imageView[index].image = UIImage(named: name!)
                    imageView[index].contentMode = .scaleAspectFit
                    cell.stackView.addArrangedSubview(imageView[index])
                }
            }
        }

        return cell
    }

    @IBAction func previousMonth(_ sender: Any) {
        selectedDate = CalendarHelper().minusMonth(date: selectedDate)
        setMonthView()
    }
    
    @IBAction func nextMonth(_ sender: Any) {
        selectedDate = CalendarHelper().plusMonth(date: selectedDate)
        setMonthView()
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
//    private func initImageView(indexPath:IndexPath) {
//        // UIImage インスタンスの生成
//        let image1:UIImage = UIImage(named:"gomibukuro_blue")!
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calCell", for: indexPath) as! CalendarCell
//
//        // UIImageView 初期化
//        let imageView = UIImageView(image:image1)
//
//        // スクリーンの縦横サイズを取得
//        let screenWidth:CGFloat = cell.cellView.frame.size.width
//        let screenHeight:CGFloat = cell.cellView.frame.size.height
//
//        // 画像の縦横サイズを取得
//        let imgWidth:CGFloat = image1.size.width
//        let imgHeight:CGFloat = image1.size.height
//
//        // 画像サイズをスクリーン幅に合わせる
//        let scale:CGFloat = (screenWidth / imgWidth)/7
//        let rect:CGRect =
//            CGRect(x:20, y:20, width:imgWidth*scale, height:imgHeight*scale)
//
//        // ImageView frame をCGRectで作った矩形に合わせる
//        imageView.frame = rect;
//
//        // 画像の中心を画面の中心に設定
//        imageView.center = CGPoint(x:screenWidth/2, y:screenHeight/2)
//
//        // UIImageViewのインスタンスをビューに追加
//        cell.cellView.addSubview(imageView)
//        self.view.addSubview(imageView)
//    }
}

extension UIImage {
    func resize(size _size: CGSize) -> UIImage? {
        let widthRatio = _size.width / size.width
        let heightRatio = _size.height / size.height
        let ratio = widthRatio < heightRatio ? widthRatio : heightRatio

        let resizedSize = CGSize(width: size.width * ratio, height: size.height * ratio)

        UIGraphicsBeginImageContextWithOptions(resizedSize, false, 0.0) // 変更
        draw(in: CGRect(origin: .zero, size: resizedSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return resizedImage
    }
}

