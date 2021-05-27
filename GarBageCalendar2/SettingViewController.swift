//
//  SettingViewController.swift
//  GarBageCalendar2
//
//  Created by Takumi Otsuka on 2021/05/23.
//

import UIKit

class SettingViewController: UIViewController {
    
    let userDefaults = UserDefaults.standard


    let cellDescription: [String] = ["通知日", "通知時間"]
    let date: [String] = ["前日", "当日"]
    let hour: [String] = [ "0時", "1時", "2時", "3時", "4時", "5時", "6時", "7時", "8時", "9時", "10時", "11時", "12時", "13時", "14時", "15時", "16時", "17時", "18時", "19時", "20時", "21時", "22時", "23時"]
    @IBOutlet weak var tableview: UITableView!
    
    //ピッカービュー
    private var pickerView:UIPickerView!
    private let pickerViewHeight:CGFloat = 160
    
    //pickerViewの上にのせるtoolbar
    private var pickerToolbar:UIToolbar!
    private let toolbarHeight:CGFloat = 40.0
    
    private var pickerIndexPath:IndexPath!

    override func viewDidLoad() {
        super.viewDidLoad()
        userDefaults.register(defaults: ["DataStore": "default"])
        // Do any additional setup after loading the view.
        
        let width = self.view.frame.width
        let height = self.view.frame.height
        
        
        //pickerView
        pickerView = UIPickerView(frame:CGRect(x:0,y:height + toolbarHeight,
                                               width:width,height:pickerViewHeight))
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.selectRow(2, inComponent: 0, animated: true)
        self.view.addSubview(pickerView)
        
        //pickerToolbar
        pickerToolbar = UIToolbar(frame:CGRect(x:0,y:height,width:width,height:toolbarHeight))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneBtn = UIBarButtonItem(title: "完了", style: .plain, target: self, action: #selector(self.doneTapped))
         pickerToolbar.items = [flexible,doneBtn]
        self.view.addSubview(pickerToolbar)

    }
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        print("pressed")

    }
    
    @IBAction func updateNotification(_ sender: Any) {
        print("pressed")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
