import UIKit

protocol Reusable {
    static var identifier: String { get }
}

protocol Nib {
    static var nibName: String { get }
}

protocol NibReusable: Nib, Reusable {
    static func register(in tableView: UITableView)
    static func register(in collectionView: UICollectionView)
}

extension NibReusable {
    static func register(in tableView: UITableView) {
        let nib = UINib(nibName: nibName, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: identifier)
    }

    static func register(in collectionView: UICollectionView) {
        let nib = UINib(nibName: nibName, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
    }
}
