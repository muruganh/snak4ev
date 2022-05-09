//
//  BaseViewController.swift
//  SNAK4EV
//
//  Created by Apple  on 30/03/22.
//

import UIKit
import SideMenu
import JTMaterialSpinner

class BaseViewController: UIViewController, LoaderStartStopDelegate {
    
    var spinnerView = JTMaterialSpinner()
    @IBOutlet var headerView: UIView?
    @IBOutlet var headerViewHeight: NSLayoutConstraint?
    let API = APIRequestManager.sharedInstance
    var navigationBar = HeaderView.loadNib()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if headerView != nil{
            headerView?.addSubview(navigationBar)
            if navigationBar.btnBack != nil{
                navigationBar.btnBack?.addTarget(self, action: #selector(btnMenu(_:)), for: .touchUpInside)
                if Display.typeIsLike == .iphoneX{
                    headerViewHeight?.constant = 90
                }else{
                    headerViewHeight?.constant = 70
                }
            }
        }

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        API.loaderDelegate = self
        Globals.shared.shareViewController = self
    }
    

    @IBAction func btnMenu(_ sender: UIButton){
        let vc = Storyboards.Main.instance.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        let menu = SideMenuNavigationController(rootViewController: vc)
        menu.leftSide = true
        menu.menuWidth = 300
        menu.presentationStyle = .menuSlideIn
        // SideMenuNavigationController is a subclass of UINavigationController, so do any additional configuration
        // of it here like setting its viewControllers. If you're using storyboards, you'll want to do something like:
        // let menu = storyboard!.instantiateViewController(withIdentifier: "RightMenu") as! SideMenuNavigationController
        present(menu, animated: true, completion: nil)
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

extension BaseViewController{
    func isStartLoading(isload: Bool) {
        if isload{
            if(!(Globals.shared.disableLoaderForSomeScreen)){
                DispatchQueue.main.async {self.didBeginLoading()}
            }
        }else{
            if(!(Globals.shared.disableLoaderForSomeScreen)){
                DispatchQueue.main.async {self.didEndLoading()}
            }
        }
    }
    
    open func didBeginLoading() {
        spinnerView.frame = CGRect(x: (self.view.frame.size.width-50) / 2.0, y: (self.view.frame.size.height-50) / 2.0, width: 50, height: 50)
        spinnerView.circleLayer.lineWidth = 2.0
        spinnerView.circleLayer.strokeColor = UIColor.red.cgColor//App.AppTheme.Color.cgColor
        spinnerView.animationDuration = 1.5
        self.view.addSubview(spinnerView)
        spinnerView.beginRefreshing()
        self.view.isUserInteractionEnabled = false
    }
    
    open func didEndLoading() {
        spinnerView.endRefreshing()
        self.view.isUserInteractionEnabled = true
    }
}

extension BaseViewController: SideMenuNavigationControllerDelegate {

    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        DispatchQueue.main.async {
            self.view.alpha = 0.8
            self.view.layoutIfNeeded()
        }
    }

    func sideMenuDidAppear(menu: SideMenuNavigationController, animated: Bool) {
        
    }

    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        self.view.alpha = 1
    }

    func sideMenuDidDisappear(menu: SideMenuNavigationController, animated: Bool) {
    }
}
