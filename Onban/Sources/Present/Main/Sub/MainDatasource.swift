//
//  MainDatasource.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/07.
//

import UIKit
import RxRelay

final class MainDatasource: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var items: [[MainCellViewModel]] = Array(repeating: [], count: CategoryType.allCases.count)
    
    struct State {
        let readySection = PublishRelay<Int>()
    }
    
    let state = State()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items[section].count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.reusableIdentifier,
                                     for: indexPath) as? MainCollectionViewCell
        else { return UICollectionViewCell() }
        let dish = items[indexPath.section][indexPath.row]
        cell.viewModel = dish
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = itemWidth(for: UIScreen.main.bounds.width, spacing: LayoutConstant.edgeSpacing)
        return CGSize(width: width, height: LayoutConstant.cellHeight)
    }
    
    private func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let itemsInRow: CGFloat = 1
        let totalSpacing: CGFloat = (2 * spacing) + (itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow
        
        return finalWidth - 5
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = itemWidth(for: UIScreen.main.bounds.width, spacing: LayoutConstant.edgeSpacing)
        return CGSize(width: width, height: LayoutConstant.sectionHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let headerView = collectionView
                .dequeueReusableSupplementaryView(
                    ofKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: MainCollectionReusableView.reusableIdentifier,
                    for: indexPath) as? MainCollectionReusableView
        else { return UICollectionReusableView() }
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let itemCount = items[indexPath.section].count
            headerView.setup(by: indexPath.section, itemCount)
        default:
            break
        }
        return headerView
    }

}

extension MainDatasource {
    func updateItems(_ type: CategoryType, items: [MainCellViewModel]) {
        self.items[type.index] = items
        
        state.readySection
            .accept(type.index)
    }
}
