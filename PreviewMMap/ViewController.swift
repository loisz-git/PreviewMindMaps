//
//  ViewController.swift
//  PreviewMMap
//
//  Created by 赵建宇 on 2021/5/25.
//

import UIKit
import QuickLook
import SSZipArchive

class ViewController: UIViewController {
    
    fileprivate lazy var quickLookView: QLPreviewController = {
        let tempview = QLPreviewController()
        //tempview.delegate = self
        tempview.dataSource = self
        return tempview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let button = UIButton(frame: CGRect(x: (UIScreen.main.bounds.width - 100)/2, y: 150, width: 100, height: 100))
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.blue.cgColor
        button.setTitleColor(UIColor.blue, for: .normal)
        button.setTitle("点击预览", for: .normal)
        button.addTarget(self, action: #selector(click), for: .touchUpInside)
        view.addSubview(button)
        
        let filepath = Bundle.main.path(forResource: "test", ofType: "mmap") ?? ""
        SSZipArchive.unzipFile(atPath: filepath, toDestination: NSTemporaryDirectory())
    }

    @objc func click(){
        present(quickLookView, animated: true, completion: nil)
    }

}

// MARK: - QLPreviewControllerDataSource
extension ViewController: QLPreviewControllerDataSource{
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        let filepath = "\(NSTemporaryDirectory())/PDFPreview.pdf"
        return NSURL(fileURLWithPath: filepath)
    }
    
    
}
