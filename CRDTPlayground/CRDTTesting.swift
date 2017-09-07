//
//  CRDTTesting.swift
//  CRDTPlayground
//
//  Created by Alexei Baboulevitch on 2017-9-5.
//  Copyright © 2017 Alexei Baboulevitch. All rights reserved.
//

import Foundation

func WeaveHardConcurrency(_ weave: inout WeaveT)
{
    func k(_ s: String) -> UniChar { return UnicodeScalar(s)!.utf16.first! }
    func t() -> Clock { return Clock(Date().timeIntervalSinceReferenceDate * 1000 * 1000) } //hacky microseconds
    
    let weaveT = type(of: weave)
    
    let startId = weaveT.AtomId(site: weaveT.ControlSite, index: 0)
    let endId = weaveT.AtomId(site: weaveT.ControlSite, index: 1)
    
    let a1 = weave._debugAddAtom(atSite: 1, withValue: k("ø"), causedBy: endId, atTime: t(), noCommit: true)!
    let a2 = weave._debugAddAtom(atSite: 1, withValue: k("1"), causedBy: startId, atTime: t(), noCommit: true)!
    let a3 = weave._debugAddAtom(atSite: 1, withValue: k("2"), causedBy: a2, atTime: t(), noCommit: true)!
    let a4 = weave._debugAddAtom(atSite: 1, withValue: k("3"), causedBy: a3, atTime: t(), noCommit: true)!
    let a5 = weave._debugAddAtom(atSite: 1, withValue: k("4"), causedBy: a4, atTime: t(), noCommit: true)!
    
    let b1 = weave._debugAddAtom(atSite: 2, withValue: k("ø"), causedBy: a1, atTime: t(), noCommit: true)!
    let b2 = weave._debugAddAtom(atSite: 2, withValue: k("ø"), causedBy: a4, atTime: t(), noCommit: true)!
    let b3 = weave._debugAddAtom(atSite: 2, withValue: k("5"), causedBy: a2, atTime: t(), noCommit: true)!
    let b4 = weave._debugAddAtom(atSite: 2, withValue: k("6"), causedBy: a3, atTime: t(), noCommit: true)!
    let b5 = weave._debugAddAtom(atSite: 2, withValue: k("7"), causedBy: b4, atTime: t(), noCommit: true)!
    
    let c1 = weave._debugAddAtom(atSite: 3, withValue: k("ø"), causedBy: b5, atTime: t(), noCommit: true)!
    
    let d1 = weave._debugAddAtom(atSite: 4, withValue: k("ø"), causedBy: a1, atTime: t(), noCommit: true)!
    let d2 = weave._debugAddAtom(atSite: 4, withValue: k("ø"), causedBy: b5, atTime: t(), noCommit: true)!
    
    let a6 = weave._debugAddAtom(atSite: 1, withValue: k("ø"), causedBy: b5, atTime: t(), noCommit: true)!
    
    let c2 = weave._debugAddAtom(atSite: 3, withValue: k("ø"), causedBy: a6, atTime: t(), noCommit: true)!
    let c3 = weave._debugAddAtom(atSite: 3, withValue: k("8"), causedBy: a5, atTime: t(), noCommit: true)!
    let c4 = weave._debugAddAtom(atSite: 3, withValue: k("9"), causedBy: c3, atTime: t(), noCommit: true)!
    let c5 = weave._debugAddAtom(atSite: 3, withValue: k("a"), causedBy: c4, atTime: t(), noCommit: true)!
    let c6 = weave._debugAddAtom(atSite: 3, withValue: k("b"), causedBy: b5, atTime: t(), noCommit: true)!
    
    let d3 = weave._debugAddAtom(atSite: 4, withValue: k("ø"), causedBy: c6, atTime: t(), noCommit: true)!
    let d4 = weave._debugAddAtom(atSite: 4, withValue: k("c"), causedBy: b4, atTime: t(), noCommit: true)!
    let d5 = weave._debugAddAtom(atSite: 4, withValue: k("d"), causedBy: d4, atTime: t(), noCommit: true)!
    let d6 = weave._debugAddAtom(atSite: 4, withValue: k("e"), causedBy: d5, atTime: t(), noCommit: true)!
    let d7 = weave._debugAddAtom(atSite: 4, withValue: k("f"), causedBy: d6, atTime: t(), noCommit: true)!
    let d8 = weave._debugAddAtom(atSite: 4, withValue: k("g"), causedBy: c6, atTime: t(), noCommit: true)!
    
    let a7 = weave._debugAddAtom(atSite: 1, withValue: k("ø"), causedBy: c6, atTime: t(), noCommit: true)!
    let a8 = weave._debugAddAtom(atSite: 1, withValue: k("ø"), causedBy: d8, atTime: t(), noCommit: true)!
    
    let b6 = weave._debugAddAtom(atSite: 2, withValue: k("ø"), causedBy: c6, atTime: t(), noCommit: true)!
    let b7 = weave._debugAddAtom(atSite: 2, withValue: k("ø"), causedBy: d8, atTime: t(), noCommit: true)!
    
    let c7 = weave._debugAddAtom(atSite: 3, withValue: k("ø"), causedBy: d8, atTime: t(), noCommit: true)!
    
    // hacky warning suppression
    let _ = [a1,a2,a3,a4,a5,a6,a7,a8, b1,b2,b3,b4,b5,b6,b7, c1,c2,c3,c4,c5,c6,c7, d1,d2,d3,d4,d5,d6,d7,d8]
}

func WeaveHardConcurrencyAutocommit(_ weave: inout WeaveT)
{
    func k(_ s: String) -> UniChar { return UnicodeScalar(s)!.utf16.first! }
    func t() -> Clock { return Clock(Date().timeIntervalSinceReferenceDate * 1000 * 1000) } //hacky microseconds
    
    let weaveT = type(of: weave)
    
    let startId = weaveT.AtomId(site: weaveT.ControlSite, index: 0)
    
    let a2 = weave._debugAddAtom(atSite: 1, withValue: k("1"), causedBy: startId, atTime: t(), noCommit: false)!
    let a3 = weave._debugAddAtom(atSite: 1, withValue: k("2"), causedBy: a2, atTime: t(), noCommit: false)!
    let a4 = weave._debugAddAtom(atSite: 1, withValue: k("3"), causedBy: a3, atTime: t(), noCommit: false)!
    let a5 = weave._debugAddAtom(atSite: 1, withValue: k("4"), causedBy: a4, atTime: t(), noCommit: false)!
    
    let b3 = weave._debugAddAtom(atSite: 2, withValue: k("5"), causedBy: a2, atTime: t(), noCommit: false)!
    let b4 = weave._debugAddAtom(atSite: 2, withValue: k("6"), causedBy: a3, atTime: t(), noCommit: false)!
    let b5 = weave._debugAddAtom(atSite: 2, withValue: k("7"), causedBy: b4, atTime: t(), noCommit: false)!
    
    let c3 = weave._debugAddAtom(atSite: 3, withValue: k("8"), causedBy: a5, atTime: t(), noCommit: false)!
    let c4 = weave._debugAddAtom(atSite: 3, withValue: k("9"), causedBy: c3, atTime: t(), noCommit: false)!
    let c5 = weave._debugAddAtom(atSite: 3, withValue: k("a"), causedBy: c4, atTime: t(), noCommit: false)!
    let c6 = weave._debugAddAtom(atSite: 3, withValue: k("b"), causedBy: b5, atTime: t(), noCommit: false)!
    
    let d4 = weave._debugAddAtom(atSite: 4, withValue: k("c"), causedBy: b4, atTime: t(), noCommit: false)!
    let d5 = weave._debugAddAtom(atSite: 4, withValue: k("d"), causedBy: d4, atTime: t(), noCommit: false)!
    let d6 = weave._debugAddAtom(atSite: 4, withValue: k("e"), causedBy: d5, atTime: t(), noCommit: false)!
    let d7 = weave._debugAddAtom(atSite: 4, withValue: k("f"), causedBy: d6, atTime: t(), noCommit: false)!
    let d8 = weave._debugAddAtom(atSite: 4, withValue: k("g"), causedBy: c6, atTime: t(), noCommit: false)!
    
    // hacky warning suppression
    let _ = [a2,a3,a4,a5, b3,b4,b5, c3,c4,c5,c6, d4,d5,d6,d7,d8]
}

// does not account for sync points
func WeaveTypingSimulation(_ weave: inout WeaveT, _ amount: Int)
{
    let minSites = 3
    let maxSites = 10
    let minAverageYarnAtoms = min(amount, 100)
    let maxAverageYarnAtoms = amount
    let minRunningSequence = 1
    let maxRunningSequence = 20
    let attachRange = 100
    
    var stringCharacters = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    stringCharacters += [" "," "," "," "," "," "," "]
    let characters = stringCharacters.map { UnicodeScalar($0)!.utf16.first! }
    
    func k(_ s: String) -> UniChar { return UnicodeScalar(s)!.utf16.first! }
    func t() -> Clock { return Clock(Date().timeIntervalSinceReferenceDate * 1000 * 1000) } //hacky microseconds
    let stringRandomGen = { return characters[Int(arc4random_uniform(UInt32(characters.count)))] }
    
    let numberOfSites = minSites + Int(arc4random_uniform(UInt32(maxSites - minSites + 1)))
    var siteUUIDs: [UUID] = []
    var siteIds: [SiteId] = []
    var siteAtoms: [SiteId:Int] = [:]
    var siteAtomTotal: [SiteId:Int] = [:]
    
    for i in 0..<numberOfSites
    {
        //let siteUUID = UUID()
        let siteId = SiteId(i + 1)
        //siteUUIDs.append(siteUUID)
        siteIds.append(siteId)
        let siteAtomsCount = minAverageYarnAtoms + Int(arc4random_uniform(UInt32(maxAverageYarnAtoms - minAverageYarnAtoms + 1)))
        siteAtoms[siteId] = siteAtomsCount
    }
    
    // hook up first yarn
    let _ = weave.addAtom(withValue: k("ø"), causedBy: WeaveT.AtomId(site: WeaveT.ControlSite, index: 1), atTime: t())
    siteAtomTotal[siteIds[0]] = 1
    
    while siteAtoms.reduce(0, { (total,pair) in total+pair.value }) != 0
    {
        let randomSiteIndex = Int(arc4random_uniform(UInt32(siteIds.count)))
        let randomSite = siteIds[randomSiteIndex]
        //let randomSiteUUID = siteUUIDs[randomSiteIndex]
        let atomsToSequentiallyAdd = min(minRunningSequence + Int(arc4random_uniform(UInt32(maxRunningSequence - minRunningSequence + 1))), siteAtoms[randomSite]!)
        
        // pick random, non-self yarn with atoms in it for attachment point
        let array = Array(siteAtomTotal)
        let randomCausalSite = array[Int(arc4random_uniform(UInt32(array.count)))].key
        let yarn = weave.yarn(forSite: randomCausalSite)
        let atomCount = yarn.count
        
        // pick random atom for attachment
        let randomAtom = Int(arc4random_uniform(UInt32(atomCount)))
        let randomIndex = yarn.startIndex + randomAtom
        let atom = yarn[randomIndex]
        
        var lastAtomId = atom.id
        for _ in 0..<atomsToSequentiallyAdd
        {
            timeMe({
                lastAtomId = weave._debugAddAtom(atSite: randomSite, withValue: stringRandomGen(), causedBy: lastAtomId, atTime: t(), noCommit: true)!
            }, "AtomAdd", every: 250)
        }
        
        siteAtoms[randomSite]! -= atomsToSequentiallyAdd
        if siteAtomTotal[randomSite] == nil
        {
            siteAtomTotal[randomSite] = atomsToSequentiallyAdd
        }
        else
        {
            siteAtomTotal[randomSite]! += atomsToSequentiallyAdd
        }
        if siteAtoms[randomSite]! <= 0
        {
            let index = siteIds.index(of: randomSite)!
            siteIds.remove(at: index)
            //siteUUIDs.remove(at: index)
            siteAtoms.removeValue(forKey: randomSite)
        }
    }
    
    let total = siteAtomTotal.reduce(0) { (r:Int, v:(key:SiteId, val:Int)) -> Int in return r + v.val }
    print("Total test atoms: \(total)")
}