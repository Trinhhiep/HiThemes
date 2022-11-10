import UIKit
import HiThemes

class ViewController: UIViewController {

   public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        PopupManager.share.presentTest(vc: self)
    }
}
