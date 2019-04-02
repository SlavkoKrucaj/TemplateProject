import Foundation
import UIKit

import IGListKit

final class TestScreenViewController: UIViewController, TestScreenViewInterface,
                                      ListAdapterDataSource, ErrorDelegate, LoadMoreDelegate {
    @IBOutlet private weak var collectionView: UICollectionView!
    private var listAdapter: ListAdapter!

    var presenter: TestScreenPresenterInterface!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.listAdapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self)
        self.listAdapter.collectionView = self.collectionView
        self.listAdapter.dataSource = self

        self.title = "title".localized()

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        self.collectionView.addSubview(refreshControl)

        self.presenter.load()
    }

    func refreshView() {
        self.listAdapter.performUpdates(animated: true)
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch (object) {
        case is LoadingModel:
            return LoadingItemController.controller()
        case is EmptyModel:
            return EmptyItemController.controller()
        case is <T>Model:
            // TODO create controller for Item of type T
        case is OfflineModel:
            return OfflineItemController.controller()
        case is ErrorModel:
            return ErrorItemController.controller(delegate: self)
        case is LoadMoreModel<T>:
            return LoadMoreItemController.controller(delegate: self)
        default:
            fatalError("Trying to display unsupported type in review list")
        }
    }

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return self.presenter.items
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }

    func loadMore() {
        self.presenter.loadMore()
    }

    func reload() {
        self.presenter.load()
    }

    @objc private func refresh(sender: UIRefreshControl) {
        self.presenter.load()
        sender.endRefreshing()
    }
}
