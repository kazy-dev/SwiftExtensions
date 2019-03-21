import UIKit

extension UIApplication {
    
    private static var networkActivityIndicatorCount: Int = 0
    
    static func showNetworkActivityIndicator() {
        DispatchQueue.main.async(execute: {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            networkActivityIndicatorCount += 1
        })
    }
    
    static func hideNetworkActivityIndicator(_ force: Bool = false) {
        networkActivityIndicatorCount -= 1
        if networkActivityIndicatorCount <= 0 || force {
            DispatchQueue.main.async(execute: {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                networkActivityIndicatorCount = 0
            })
        }
    }
    
    /// 最前面のViewControllerを取得する
    ///
    /// - Parameter isExceptAlertController: AlertControllerを除くかどうか
    /// - Returns: 最前面のViewController
    public func topViewController(isExceptAlertController: Bool = true) -> UIViewController? {
        /// inner func (viewControllerを解析する)
        func parseVC(vc: UIViewController, presentedVC: UIViewController?) -> (UIViewController?, UIViewController?) {
            var viewController: UIViewController? = vc
            
            switch presentedVC {
            case let navagationController as UINavigationController:
                viewController = navagationController.viewControllers.last
            case let tabBarController as UITabBarController:
                viewController = tabBarController.selectedViewController
            default:
                viewController = viewController?.presentedViewController
            }
            
            return (viewController, viewController?.presentedViewController)
        }
        /// inner func end
        
        var viewController = UIApplication.shared.keyWindow?.rootViewController
        guard viewController != nil else {
            return nil
        }
        var presentedViewController = viewController?.presentedViewController
        
        if isExceptAlertController {
            while presentedViewController != nil, !(presentedViewController is UIAlertController) {
                let vcAndPresentedVC = parseVC(vc: viewController!, presentedVC: presentedViewController)
                viewController = vcAndPresentedVC.0
                presentedViewController = vcAndPresentedVC.1
            }
        }else {
            while presentedViewController != nil {
                let vcAndPresentedVC = parseVC(vc: viewController!, presentedVC: presentedViewController)
                viewController = vcAndPresentedVC.0
                presentedViewController = vcAndPresentedVC.1
            }
        }
        
        return viewController
    }
}
