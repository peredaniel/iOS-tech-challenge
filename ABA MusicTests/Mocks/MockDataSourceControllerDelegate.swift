import DataSourceController

class MockDataSourceControllerDelegate: DataSourceControllerDelegate {
    var didMutateDataSource: (() -> Void)?

    func dataSourceWasMutated(_: DataSourceController) {
        didMutateDataSource?()
    }
}
