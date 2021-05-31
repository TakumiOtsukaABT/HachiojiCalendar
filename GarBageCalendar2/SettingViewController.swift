//
//  SettingViewController.swift
//  GarBageCalendar2
//
//  Created by Takumi Otsuka on 2021/05/23.
//

import UIKit
import GoogleMobileAds

class SettingViewController: UIViewController {
    
    let userDefaults = UserDefaults.standard


    let cellDescription: [String] = ["通知日", "通知時間"]
    let date: [String] = ["前日", "当日"]
    let hour: [String] = [ "0時", "1時", "2時", "3時", "4時", "5時", "6時", "7時", "8時", "9時", "10時", "11時", "12時", "13時", "14時", "15時", "16時", "17時", "18時", "19時", "20時", "21時", "22時", "23時"]
    @IBOutlet weak var tableview: UITableView!
    
    var scheduleForThisMonth = [DateWithSchedule]()
    var timing = 0
    
    
    
    let maxNotification = 30
    
    
    
    //ピッカービュー
    private var pickerView:UIPickerView!
    private let pickerViewHeight:CGFloat = 160
    
    //pickerViewの上にのせるtoolbar
    private var pickerToolbar:UIToolbar!
    private let toolbarHeight:CGFloat = 40.0
    
    private var pickerIndexPath:IndexPath!
    
    private var interstitial: GADInterstitialAd?


    override func viewDidLoad() {
        super.viewDidLoad()
        let request = GADRequest()
            GADInterstitialAd.load(withAdUnitID:"ca-app-pub-3039829668066613/4234963489",//TODO:
                                        request: request,
                              completionHandler: { [self] ad, error in
                                if let error = error {
                                  print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                                  return
                                }
                                interstitial = ad
                                interstitial?.fullScreenContentDelegate = self
                              }
            )
        
        tableview.tableFooterView = UIView()
        
        userDefaults.register(defaults: ["DataStore": "default"])
        // Do any additional setup after loading the view.
        
        let width = self.view.frame.width
        let height = self.view.frame.height
        
        
        //pickerView
        pickerView = UIPickerView(frame:CGRect(x:0,y:height + toolbarHeight,
                                               width:width,height:pickerViewHeight))
        pickerView.dataSource = self
        pickerView.delegate = self
        self.view.addSubview(pickerView)
        
        //pickerToolbar
        pickerToolbar = UIToolbar(frame:CGRect(x:0,y:height,width:width,height:toolbarHeight))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneBtn = UIBarButtonItem(title: "完了", style: .plain, target: self, action: #selector(self.doneTapped))
         pickerToolbar.items = [flexible,doneBtn]
        self.view.addSubview(pickerToolbar)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.scheduleForThisMonth = CalendarHelper.sched
    }
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func updateNotification(_ sender: Any) {

        if interstitial != nil {
            interstitial!.present(fromRootViewController: self)
        } else {
          print("Ad wasn't ready")
        }
        
        print("continuing")
        
        var hasEmptyField = false
        for i in tableview.visibleCells{
            if i.detailTextLabel?.text == nil {
                hasEmptyField = true
            }
        }
        
        if !hasEmptyField {
            
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert]) {
                (granted, error) in
            }
            
            for i in 0...maxNotification {
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [String(i)])
            }
            
            for (index, i) in self.scheduleForThisMonth.enumerated() {
                //content
                let content = UNMutableNotificationContent()
                var garbageString = ""
                for (indexj, j) in i.garbage.enumerated() {
                    garbageString += CalendarHelper().getGarbageTypeString(garbage: GarbageType(rawValue: j)!)!
                    if indexj < i.garbage.count-1 {
                        garbageString += "と"
                    }
                }
                content.title = "ゴミ出しの時間です。"
                content.body =  garbageString + "の日です"
//                print(content.body)
                //content
                
                //trigger
                if tableview.cellForRow(at: IndexPath(row: 0, section: 0))?.detailTextLabel?.text == "前日"{
                    timing = -1
                } else if tableview.cellForRow(at: IndexPath(row: 1, section: 0))?.detailTextLabel?.text == "前日" {
                    timing = 0
                }
//                print("timing " ,timing)
                var dateComponent = i.dateComponents
//                print(dateComponent)
                let tempDate = componentToDate(dateComponent: dateComponent)
                let nextDate = Calendar.current.date(byAdding: .day, value: timing, to: tempDate!)
                dateComponent = dateToComponent(date: nextDate!)
                let whatTime = Int((tableview.cellForRow(at: IndexPath(row: 1, section: 0))?.detailTextLabel?.text)!.dropLast())
//                print ("time", whatTime)
                dateComponent.setValue(whatTime!, for: .hour)
//                print(dateComponent)
                let dateComponent2 = DateComponents(month:dateComponent.month,day: dateComponent.day,hour: dateComponent.hour)
//                print("ttt",dateComponent2)
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent2, repeats: false)
                //trigger
                
                //uuid
                let uuid = String(index)
                //uuid
                
                //request
                let request = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
                //request
                
                center.add(request){
                    (error) in
                }
            }
            let dialog = UIAlertController(title: "登録しました", message: "今月分の通知を登録しました", preferredStyle: .alert)
            dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            print("present")
            self.present(dialog, animated: true, completion: nil)
        }
    }
    private func dateToComponent(date: Date) -> DateComponents{
        let components = Calendar.current.dateComponents(in: TimeZone.current, from: date)
        return components
    }
    
    private func componentToDate(dateComponent: DateComponents) -> Date? {
        var tempComponent = dateComponent
        tempComponent.calendar = Calendar.current
        return tempComponent.date
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "myCell")
        var key = ""
        cell.textLabel?.text = self.cellDescription[indexPath.row]
        if indexPath.row == 0 {
            key = "todayOrNot"
        } else if indexPath.row == 1{
            key = "hour"
        }
        cell.detailTextLabel?.text = userDefaults.string(forKey: key)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pickerIndexPath = indexPath
        let selectedPick = tableView.cellForRow(at: indexPath)?.detailTextLabel?.text
        var index1:Int = 0
        
        if indexPath.row == 0 {
            for (index, i) in date.enumerated() {
                if i == selectedPick {
                    index1 = index
                    print(index1)
                    break
                }
            }
        } else if indexPath.row == 1 {
            for (index, i) in hour.enumerated() {
                if i == selectedPick {
                    index1 = index
                    print(index1)
                    break
                }
            }
        }
        
        self.pickerView.selectRow(index1,inComponent:0,animated:false)
            
        
        //ピッカービューをリロード
        pickerView.reloadAllComponents()
        //ピッカービューを表示
        UIView.animate(withDuration: 0.2) {
            self.pickerToolbar.frame = CGRect(x:0,y:self.view.frame.height - self.pickerViewHeight - self.toolbarHeight,
                                              width:self.view.frame.width,height:self.toolbarHeight)
            self.pickerView.frame = CGRect(x:0,y:self.view.frame.height - self.pickerViewHeight,
                                           width:self.view.frame.width,height:self.pickerViewHeight)
        }
        self.pickerView.selectRow(index1,inComponent:0,animated:false)


    }
    
    
    
    
}

extension SettingViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerIndexPath != nil){
            switch (pickerIndexPath.row){
            case 0:
                return date.count
            case 1:
                return hour.count
            default:
                return 0
            }
        }else{
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView,titleForRow row: Int,forComponent component: Int) -> String? {
        if(pickerIndexPath != nil){
            switch (pickerIndexPath.row){
            case 0:
                return date[row]
            case 1:
                return hour[row]
            default:
                return ""
            }
        } else {
            return ""
        }
    }
    
    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let cell = tableview.cellForRow(at:pickerIndexPath)
        var newLabel = ""
        var key = ""
        if(pickerIndexPath != nil){
            switch (pickerIndexPath.row){
            case 0:
                key = "todayOrNot"
                newLabel = date[row]
            case 1:
                key = "hour"
                newLabel = hour[row]
            default:
                break
            }
        }
        cell?.detailTextLabel?.text = newLabel
        userDefaults.set(newLabel, forKey: key)
    }
    
    @objc func doneTapped() {
        UIView.animate(withDuration: 0.2){
            self.pickerToolbar.frame = CGRect(x:0,y:self.view.frame.height,
                                              width:self.view.frame.width,height:self.toolbarHeight)
            self.pickerView.frame = CGRect(x:0,y:self.view.frame.height + self.toolbarHeight,
                                           width:self.view.frame.width,height:self.pickerViewHeight)
        }
        //選択を解除する
        self.tableview.deselectRow(at: pickerIndexPath, animated: true)
    }
    
}

extension SettingViewController: GADFullScreenContentDelegate {
    /// Tells the delegate that the ad failed to present full screen content.
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
      print("Ad did fail to present full screen content.")
    }

    /// Tells the delegate that the ad presented full screen content.
    func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
      print("Ad did present full screen content.")
    }

    /// Tells the delegate that the ad dismissed full screen content.
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did dismiss full screen content.")
        print("ttttttttttt")
        let dialog = UIAlertController(title: "登録しました", message: "今月分の通知を登録しました", preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        print("present")
        self.present(dialog, animated: true, completion: nil)
    }
}
