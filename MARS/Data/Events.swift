//
//  Events.swift
//  MARS
//
//  Created by Mac on 2/17/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import Foundation

struct Events {
    fileprivate static let placeholderEventDetailsText = "Imagine there's something interesting here. \nA captivating story with dragons, car chases or volcanoes (maybe even all three). \nI just can't be bothered with Lorem Ipsum again. \n\nIt's just a filler anyway - if you're reading it then hats off to you, that's dedication right there. I've spent many hours (okay, maybe minutes) thinking about something cool and clever to put in here, and yet here we are. Nothing but random sentences strung together to try and keep someone entertained enough to check out the rest of this app. \nI know, it doesn't look and sound as sophisticated as fake-latin gibberish, but at least it makes some sense. Even if just a smidge. TBH I feel lazy typing this out. \nStill, you never know, one day I might write something worthwhile in here. A real doozy of a tale. \n\nOk fine, I'll be honest, I didn't spend any time planning this text, I'm making it up as I go, I bet you can tell. \nIt's GOT premiere today.\n\nPriorities.\n"
    
    static let upcomingEvents: [Event] = [Event(title: "Supplies Drop", date: Date.fromString("07/25/2019"), imageName: "rockets", imageAuthor: "SpaceX", details: placeholderEventDetailsText),
                                          Event(title: "Dune Buggies on Valles Marineris", date: Date.fromString("07/27/2019"), imageName: "buggy", imageAuthor: "Roberto Nickson", details: placeholderEventDetailsText),
                                          Event(title: "Solar Panel Maintenance", date: Date.fromString("08/04/2019"), imageName: "panels", imageAuthor: "Joshua Hoehne", details: placeholderEventDetailsText),
                                          Event(title: "Tharsis half-marathon", date: Date.fromString("08/11/2019"), imageName: "mountains", imageAuthor: "Vinícius Henrique", details: placeholderEventDetailsText),
    ]
}
