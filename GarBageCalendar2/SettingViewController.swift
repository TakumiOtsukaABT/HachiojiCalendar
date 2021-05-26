//
//  SettingViewController.swift
//  GarBageCalendar2
//
//  Created by Takumi Otsuka on 2021/05/23.
//

import UIKit

class SettingViewController: UIViewController {

    let cellDescription: [String] = ["通知日", "通知時間"]
    let date: [String] = ["前日", "当日"]
    let hour: [Int] = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]
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
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

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
        cell.textLabel?.text = self.cellDescription[indexPath.row]
        cell.detailTextLabel?.text = ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pickerIndexPath = indexPath
        
        //ピッカービューをリロード
        pickerView.reloadAllComponents()
        //ピッカービューを表示
        UIView.animate(withDuration: 0.2) {
            self.pickerToolbar.frame = CGRect(x:0,y:self.view.frame.height - self.pickerViewHeight - self.toolbarHeight,
                                              width:self.view.frame.width,height:self.toolbarHeight)
            self.pickerView.frame = CGRect(x:0,y:self.view.frame.height - self.pickerViewHeight,
                                           width:self.view.frame.width,height:self.pickerViewHeight)
        }
        // タップされたセルの行番号を出力
        print("\(indexPath.row)番目の行が選択されました。")
    }
    
    
    
    
}

extension SettingViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    
    func pickerView(_ pickerView: UIPickerView,titleForRow row: Int,forComponent component: Int) -> String? {
        
        return String(hour[row])
    }
    
    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let cell = tableview.cellForRow(at:pickerIndexPath)
        cell?.detailTextLabel?.text = String(hour[row])
        // 処理
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
