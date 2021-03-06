//
//  AddNavViewController.swift
//  XinaoEnergy
//
//  Created by jun on 2018/8/21.
//  Copyright © 2018年 jun. All rights reserved.
//

import UIKit

class AddNavViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //action后的方法名如果加“：”则方法里面需要传button；如果没有“：”，则空着即可
        //只有文字
        //        let item = UIBarButtonItem(title: "done", style: UIBarButtonItemStyle.done, target: self, action: #selector(HelpDocumentViewController.backToparent))
        //        self.navigationItem.leftBarButtonItem = item
        
        //设置只有图片显示
        let leftBarBtn = UIBarButtonItem(title: "", style: .plain, target: self,
                                         action: #selector(backItemPressed))
        leftBarBtn.image = UIImage(named: "back")
        //用于消除左边空隙，要不然按钮顶不到最前面;实际发现可以没有
        //        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil,
        //                                     action: nil)
        //        spacer.width = -10
        //        spacer.tintColor = UIColor.black
        leftBarBtn.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = leftBarBtn
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func backItemPressed(){
        //present出的页面用dismiss不然会找不到上一页
        self.dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
