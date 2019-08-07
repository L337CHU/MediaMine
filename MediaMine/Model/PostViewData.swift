//
//  PostViewData.swift
//  MediaMine
//
//  Created by Amy Stockinger on 8/6/19.
//  Copyright © 2019 Christopher Chu. All rights reserved.
//

import Foundation

struct PostViewData : Decodable {
    let polarity:String?
    let afinn_sentiment:String?
    let pronoun_fraction:String?
    let noun_fraction:String?
    let verb_fraction:String?
    let adjective_fraction:String?
    let adverb_fraction:String?
    let total_words:String?
    
    init(polarity: String? = nil,
        afinn_sentiment: String? = nil,
        pronoun_fraction:String? = nil,
        noun_fraction:String? = nil,
        verb_fraction:String? = nil,
        adjective_fraction:String? = nil,
        adverb_fraction:String? = nil,
        total_words:String? = nil) {
        
        self.polarity = polarity
        self.afinn_sentiment = afinn_sentiment
        self.pronoun_fraction = pronoun_fraction
        self.noun_fraction = noun_fraction
        self.verb_fraction = verb_fraction
        self.adjective_fraction = adjective_fraction
        self.adverb_fraction = adverb_fraction
        self.total_words = total_words
    }
}
