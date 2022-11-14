import UIKit
import HiThemes

class ViewController: UIViewController {

   public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        PopupManager.share.presentTest1(vc: self, delegate: self)
    }
}
extension ViewController: PopupWithListItemVCDelegate{

    func didSelectRowAt(indexPath: IndexPath) {
        print(indexPath)
    }
    
    func viewForCellAt(indexPath: IndexPath) -> UIView {
        let v = UIView()
        v.backgroundColor = .blue
        return v
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return 10
    }
    
    
}
