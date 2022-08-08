//
//  EarthquakeDataModels.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 7/30/22.
//

import Foundation

struct EarthquakesResponse: Codable {
    var type: String?
    var metadata: EarthquakesResponseMetaData
    var features: [EarthquakesFeature]?
}

struct EarthquakesResponseMetaData: Codable {
    let generated: Int64
    let url: String
    let title :String
    let status: Int
    let api: String
    let limit: Int
    let offset: Int
    let count: Int
}

struct EarthquakesFeature: Codable {
    let type: String
    let properties: EarthquakesFeatureProperty
    let geometry: EarthquakesFeatureGeometry
    let id :String
}

struct EarthquakesFeatureProperty: Codable, Hashable {
    let type: String
    let title: String
    let detail: String
    let place: String?
    let time: Int64
    let status: String?
    let updated: Int64
    let url: String?

}

struct EarthquakesFeatureGeometry: Codable {
    let type: String
    let coordinates: [Double]
}
