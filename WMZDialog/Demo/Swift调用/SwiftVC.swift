//
//  SwiftVC.swift
//  WMZDialog
//
//  Created by wmz on 2020/10/21.
//  Copyright © 2020 wmz. All rights reserved.
//

import UIKit

class SwiftVC: BaseVC {
 
    var text = ""
    override func viewDidLoad() {
        super.viewDidLoad()
     self.dataArr = ["默认","选择","日期","编辑"]

    }
    override func action(_ sender: UIButton) {
        if sender.tag == 0 {
            let dialog:WMZDialog = Dialog()
            dialog
            .wTypeSet()(DialogTypeNornal)
            .wEventOKFinishSet()({(anyId:Any?,otherData:Any?)in
                print("点击确定",anyId as Any);
            })
            _ = dialog.wStart()
            

        } else if sender.tag == 1 {
            let dialog:WMZDialog = Dialog()
            dialog
            .wTypeSet()(DialogTypeSheet)
            .wDataSet()(["男","女","未知"])
            .wEventFinishSet()({(anyID:Any?,path:IndexPath?,type:DialogType) in
                print("选择",anyID as Any);
            })
            _ = dialog.wStart()
        }else if sender.tag == 2 {
            let dialog:WMZDialog = Dialog()
            dialog.wDateTimeTypeSet()("yyyy年MM月dd日")
            .wDefaultDateSet()(Date())
            .wEventOKFinishSet()({(anyId:Any?,otherData:Any?)in
                print("点击确定",anyId as Any,otherData as Any);
            })
            .wTypeSet()(DialogTypeDatePicker);
            _ = dialog.wStart()
        }else if sender.tag == 3 {
            let dialog:WMZDialog = Dialog()
            dialog.wTypeSet()(DialogTypeWrite)
                .wEventOKFinishSet()({(anyId:Any?,otherData:Any?)in
                print("点击确定",anyId as Any);
            })
                .wPlaceholderSet()("请输入名称")
                .wWirteKeyBoardTypeSet()(.numbersAndPunctuation)
                .wWirteTextMaxLineSet()(2)
                .wWriteDefaultTextSet()(text)
            _ = dialog.wStart()
        }
    }

}
