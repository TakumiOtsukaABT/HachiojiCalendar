//
//  ViewController.swift
//  GarBageCalendar2
//
//  Created by Takumi Otsuka on 2021/05/15.
//

import UIKit
import GoogleMobileAds
import UserNotifications

class ViewController: UIViewController {
    
    @IBOutlet weak var monthLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var dateDiscription: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var bannerView: GADBannerView!
    
    var pickerView = UIPickerView()
    let list = ["地区1", "地区2","地区3","地区4","地区5","地区6","地区7","地区8","地区9","地区10","地区11","地区12","地区13","地区14","地区15","地区16","地区17","地区18","地区19","地区20"]
    var district = 0
    
    let userDefaults = UserDefaults.standard
    
    var todaysIndex:Int = 0

    public var schedulesThisMonth = [DateWithSchedule]()
    var completionHandler:()

    var selectedDate = Date()
    var totalSquares = [String]()
    var season:Int = 0
    let calendarCycle = CalendarCycle()
    var cycleIndex:Int = 0
    var calendar = Calendar.current
    var todaycell = CalendarCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: also plist
        bannerView.adUnitID = "ca-app-pub-3039829668066613/5674423265"
        bannerView.load(GADRequest())
        bannerView.backgroundColor = .secondarySystemBackground
        
        bannerView.rootViewController = self
        bannerView.delegate = self

        self.district = userDefaults.integer(forKey: "rowInt")
        self.textField.text = list[district]
        pickerDidLoad()
        // Do any additional setup after loading the view.
        setMonthView()
    }
    
    @IBAction func onClickTextField(_ sender: Any) {
        let dialog = UIAlertController(title: "地区の選択", message: "お手持ちのゴミ出しカレンダーに記載の地区であることを確認してください。", preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        print("present")
        self.present(dialog, animated: true, completion: nil)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert]) {
            (granted, error) in
        }
                
        let content = UNMutableNotificationContent()
        content.title = "ゴミ出しお疲れ様でした。"
        content.body = "今月も通知しましょうか？アプリを開いて通知の設定をお願いします"
        
        
        let dateComponent = DateComponents(day: 1)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
        
        let uuid = "monthly"
        
        let request = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
        
        center.add(request){
            (error) in
        }
    }
    
    func setMonthView() {
        totalSquares.removeAll()
        
        let daysInMonth = CalendarHelper().daysInMonth(date: selectedDate)
        let firstDayOfMonth = CalendarHelper().firstOfMonth(date: selectedDate)
        let startingSpaces = CalendarHelper().weekDay(date: firstDayOfMonth)
        self.season = CalendarHelper().getSeason(date: selectedDate)
        let components = calendar.dateComponents([.month], from: selectedDate)
        self.cycleIndex = calendarCycle.startIndex[components.month! - 1]
        
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
        self.schedulesThisMonth.removeAll()
        collectionView.reloadData()
        collectionView.performBatchUpdates(nil, completion: {
            (result) in
            // ready
            if self.selectedDate.get(.month)==Date().get(.month) {
                for (index,i) in self.totalSquares.enumerated(){
                    if Int(i) == Date().get(.day){
                        self.collectionView(self.collectionView, didSelectItemAt: IndexPath(row: index, section: 0))
                        self.todaysIndex = index
                    }
                }
            }
        })
    }
    
    @IBAction func previousMonth(_ sender: Any) {
        selectedDate = CalendarHelper().minusMonth(date: selectedDate)
        setMonthView()
    }
    
    @IBAction func nextMonth(_ sender: Any) {
        selectedDate = CalendarHelper().plusMonth(date: selectedDate)
        setMonthView()
        
    }
    @IBAction func gotoSettings() {
        let vc = storyboard?.instantiateViewController(identifier: "Setting_VC") as! SettingViewController
        present(vc, animated: true)
        CalendarHelper.sched = self.schedulesThisMonth
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
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

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/8.0
        let yourHeight = yourWidth
        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let yourWidth = collectionView.bounds.width/9.0
                return CGFloat(yourWidth/6)
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calCell", for: indexPath) as! CalendarCell
        for i in cell.stackView.subviews{
//            print(i)
            cell.stackView.removeArrangedSubview(i)
            i.removeFromSuperview()
        }
        
        cell.garbage.removeAll()
        
        cell.dayOfMonth.text = totalSquares[indexPath.item]
        var imageView:[UIImageView] = []
        
        cell.viewWithTag(3)?.backgroundColor = .white
        dateDiscription.text = ""
        
        if totalSquares[indexPath.item] != "" {
            for (index, i) in calendarCycle.district1[district][season][cycleIndex % 4][indexPath.item % 7].enumerated() {
                let name = CalendarHelper().garbageTypeString(typeInt: GarbageType(rawValue: i)!)
                if name != nil {
                    let imageV = UIImageView()
                    imageView.append(imageV)
                    imageView[index].image = UIImage(named: name!)
                    imageView[index].contentMode = .scaleAspectFit
                    cell.stackView.addArrangedSubview(imageView[index])
                    cell.garbage.append(i)
                }
            } //for (index, i) in calendarCycle.district1[season][0 % 2][indexPath.item % 7].enumerated()
            if indexPath.item % 7 == 0 {
                cycleIndex += 1
            }
        }
        
        let selectedBGView = UIView(frame: cell.frame)
        selectedBGView.backgroundColor = .blue
        cell.selectedBackgroundView = selectedBGView
        
        if !cell.garbage.isEmpty {
            let month = CalendarHelper().getOnlyMonth(date: selectedDate)
            let day = Int(totalSquares[indexPath.item])
            let dateComponent = DateComponents(month:month, day:day)
            let withSchedule = DateWithSchedule(dateComponent: dateComponent ,garbage: cell.garbage)
            self.schedulesThisMonth.append(withSchedule)
        }
        
        if CalendarHelper().getOnlyMonth(date: self.selectedDate) == CalendarHelper().getOnlyMonth(date: Date()) {
            if CalendarHelper().getOnlyDate(date: Date()) == totalSquares[indexPath.item] {
            }
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectionView(collectionView, didDeselectItemAt: IndexPath(row: todaysIndex, section: 0))
        collectionView.cellForItem(at: indexPath)!.viewWithTag(3)?.backgroundColor = .yellow
        let cell = collectionView.cellForItem(at: indexPath) as! CalendarCell
        dateDiscription.text = ""
        for i in cell.garbage {
            dateDiscription.text! = dateDiscription.text! + "\n" + CalendarHelper().getGarbageTypeString(garbage: GarbageType(rawValue: i)!)!
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)!.viewWithTag(3)?.backgroundColor = .white
    }

}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    fileprivate func pickerDidLoad() {
        pickerView.delegate = self
        pickerView.dataSource = self
        let toolbar = UIToolbar(frame: CGRectMake(0, 0, 0, 35))
        let doneItem = UIBarButtonItem(title: "完了", style: .plain, target: self, action: #selector(ViewController.done))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(ViewController.cancel))
        let searchDistrictItem = UIBarButtonItem(title: "自分の地区を探す", style: .plain, target: self, action: #selector(ViewController.searchDistrict))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbar.setItems([cancelItem, searchDistrictItem, flexible, doneItem], animated: true)
        self.textField.inputView = pickerView
        self.textField.inputAccessoryView = toolbar
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.textField.text = list[row]
        self.district = row
        userDefaults.setValue(row, forKey: "rowInt")
        setMonthView()
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    @objc func cancel() {
        self.textField.text = ""
        self.textField.endEditing(true)
    }
    
    @objc func searchDistrict() {
        self.textField.endEditing(true)
        let url = URL(string: "https://www.city.hachioji.tokyo.jp/kurashi/gomi/kateiyougomi_karenda/001/index.html")!
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }

    @objc func done() {
        self.textField.endEditing(true)
    }
}

extension ViewController: GADBannerViewDelegate {
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
      print("bannerViewDidReceiveAd")
    }

    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
      print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
      print("bannerViewDidRecordImpression")
    }

    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillPresentScreen")
    }

    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillDIsmissScreen")
    }

    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewDidDismissScreen")
    }
}

class DateWithSchedule {
    var dateComponents:DateComponents
    var garbage:[Int]
    
    init(dateComponent:DateComponents, garbage: [Int]) {
        self.dateComponents = dateComponent
        self.garbage = garbage
    }
}

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
