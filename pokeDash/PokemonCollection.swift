//
//  PokemonCollection.swift
//  pokeDash
//
//  Created by Prism Student on 2020-02-15.
//  Copyright © 2020 Pranav Patel. All rights reserved.
//  These classes are built from previous assignments involving Fruit
//
import Foundation
import UIKit
class PokemonCollection: NSObject, NSCoding {
    static var collection = [Pokemon]() // a collection is an array of pokemons
    static var current:Int = 0 // the current pokemon in the collection (to be shown in thescene)

    let collectionKey = "collectionKey"
    let currentKey = "currentKey"

    // MARK: - NSCoding methods
    override init(){
        super.init()
        //setup()
    }
    
    //add function
    func add(pokemonName: String, type1: String, type2: String, moreInfo: String){
        let pokemon = Pokemon(pokemonName: pokemonName, type1: type1, type2: type2, moreInfo: moreInfo)
        PokemonCollection.collection.append(pokemon!)
    }
    
    //getter functions
    func getName() -> String{
        let pokemon = PokemonCollection.collection[PokemonCollection.current]
        return pokemon.pokemonName
    }
    //func getImage() -> UIImage{
    //    let pokemon = PokemonCollection.collection[PokemonCollection.current]
    //    return pokemon.pokemonImage
    //}
    func gettype1() -> String{
        let pokemon = PokemonCollection.collection[PokemonCollection.current]
        return pokemon.type1
    }
    func gettype2() -> String{
          let pokemon = PokemonCollection.collection[PokemonCollection.current]
          return pokemon.type2
    }
    func getmoreInfo() -> String{
          let pokemon = PokemonCollection.collection[PokemonCollection.current]
          return pokemon.moreInfo
    }
    
    func getCurrentIndex() -> Int {
        return PokemonCollection.current
    }
    func getCurrentPokemon() -> Pokemon {
        let pokemon = PokemonCollection.collection[PokemonCollection.current]
        return pokemon
    }
    
    //setter functions
    func setCurrentIndex(to index: Int){
        PokemonCollection.current = index
    }
    
    required convenience init?(coder decoder: NSCoder) {
        self.init()
        PokemonCollection.collection = (decoder.decodeObject(forKey: collectionKey) as? [Pokemon])!
        PokemonCollection.current = (decoder.decodeInteger(forKey: currentKey))
    }
    
    func clearAll(){
        PokemonCollection.collection.removeAll()
    }
    
    func encode(with acoder: NSCoder) {
        acoder.encode(PokemonCollection.collection, forKey: collectionKey)
        acoder.encode(PokemonCollection.current, forKey: currentKey)
 }
 // Mark: - Helpers
}
