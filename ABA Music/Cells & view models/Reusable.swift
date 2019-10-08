import UIKit

protocol Reusable {
    static var identifier: String { get }
    static func register(in collectionView: UICollectionView)
}
