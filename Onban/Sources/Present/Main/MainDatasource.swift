//
//  MainDatasource.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/07.
//

import UIKit

final class MainDatasource: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getItemCount(of: section)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.countOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.reusableIdentifier,
                                     for: indexPath) as? MainCollectionViewCell,
              let dish = viewModel[indexPath]
        else { return UICollectionViewCell() }
        
        cell.setup(dish)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = itemWidth(for: UIScreen.main.bounds.width, spacing: LayoutConstant.spacing)
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
        let width = itemWidth(for: UIScreen.main.bounds.width, spacing: LayoutConstant.spacing)
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
            let itemCount = viewModel.getItemCount(of: indexPath.section)
            headerView.setup(by: indexPath.section, itemCount)
        default:
            assert(false)
        }
        return headerView
    }

}
