//
//  ILocationsViewModel.swift
//  FinalProject
//
//  Created by 1okmon on 06.06.2023.
//

protocol ILocationsViewModel {
    func loadNextPage()
    func loadPreviousPage()
    func openLocation(with id: Int)
    func reload()
}
