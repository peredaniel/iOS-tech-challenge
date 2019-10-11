import UIKit

extension UINavigationController {
    override open var shouldAutorotate: Bool {
        if let visibleVC = visibleViewController {
            return visibleVC.shouldAutorotate
        }
        return super.shouldAutorotate
	}

    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        if let visibleVC = visibleViewController {
            return visibleVC.preferredInterfaceOrientationForPresentation
        }
        return super.preferredInterfaceOrientationForPresentation
	}

	override open var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        if let visibleVC = visibleViewController {
            return visibleVC.supportedInterfaceOrientations
        }
        return super.supportedInterfaceOrientations
    }
}
