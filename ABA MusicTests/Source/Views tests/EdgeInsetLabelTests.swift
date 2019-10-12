@testable import ABA_Music
import SnapshotTesting
import XCTest

class EdgeInsetLabelTests: XCTestCase {
    func testViewLoadsSuccessfully_NoInsets() {
        let frame = CGRect(x: 0, y: 0, width: 200, height: 30)
        let label = EdgeInsetLabel(frame: frame)
        label.text = "This is a label without insets"
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.font = .systemFont(ofSize: 15)
        label.sizeToFit()
        label.textInsets = .zero
        assertSnapshot(matching: label, as: .image)
    }

    func testViewLoadsSuccessfully_LeftInsets() {
        let frame = CGRect(x: 0, y: 0, width: 200, height: 30)
        let label = EdgeInsetLabel(frame: frame)

        label.text = "This is a label with left insets"
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.font = .systemFont(ofSize: 15)
        label.textInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        label.sizeToFit()

        XCTAssertEqual(label.leftTextInset, 10)
        assertSnapshot(matching: label, as: .image)
    }

    func testViewLoadsSuccessfully_RightInsets() {
        let frame = CGRect(x: 0, y: 0, width: 200, height: 30)
        let label = EdgeInsetLabel(frame: frame)

        label.text = "This is a label with right insets"
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.font = .systemFont(ofSize: 15)
        label.textInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        label.sizeToFit()

        XCTAssertEqual(label.rightTextInset, 10)
        assertSnapshot(matching: label, as: .image)
    }

    func testViewLoadsSuccessfully_TopInsets() {
        let frame = CGRect(x: 0, y: 0, width: 200, height: 30)
        let label = EdgeInsetLabel(frame: frame)

        label.text = "This is a label with top insets"
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.font = .systemFont(ofSize: 15)
        label.textInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        label.sizeToFit()

        XCTAssertEqual(label.topTextInset, 10)
        assertSnapshot(matching: label, as: .image)
    }

    func testViewLoadsSuccessfully_BottomInsets() {
        let frame = CGRect(x: 0, y: 0, width: 200, height: 30)
        let label = EdgeInsetLabel(frame: frame)

        label.text = "This is a label with bottom insets"
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.font = .systemFont(ofSize: 15)
        label.textInsets = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        label.sizeToFit()

        XCTAssertEqual(label.bottomTextInset, 10)
        assertSnapshot(matching: label, as: .image)
    }

    func testViewLoadsSuccessfully_AllDifferentInsets() {
        let frame = CGRect(x: 0, y: 0, width: 200, height: 30)
        let label = EdgeInsetLabel(frame: frame)

        label.text = "This is a label with all different insets"
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.font = .systemFont(ofSize: 15)
        label.textInsets = UIEdgeInsets(top: 30, left: 45, bottom: 15, right: 60)
        label.sizeToFit()

        XCTAssertEqual(label.topTextInset, 30)
        XCTAssertEqual(label.leftTextInset, 45)
        XCTAssertEqual(label.bottomTextInset, 15)
        XCTAssertEqual(label.rightTextInset, 60)
        assertSnapshot(matching: label, as: .image)
    }

    func testViewLoadsSuccessfully_AllEqualInsets() {
        let frame = CGRect(x: 0, y: 0, width: 200, height: 30)
        let label = EdgeInsetLabel(frame: frame)

        label.text = "This is a label with all equal insets"
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.font = .systemFont(ofSize: 15)
        label.textInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        label.sizeToFit()

        XCTAssertEqual(label.topTextInset, 10)
        XCTAssertEqual(label.leftTextInset, 10)
        XCTAssertEqual(label.bottomTextInset, 10)
        XCTAssertEqual(label.rightTextInset, 10)
        assertSnapshot(matching: label, as: .image)
    }
}
