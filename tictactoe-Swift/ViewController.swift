//
//  ViewController.swift
//  tictactoe-Swift
//
//  Created by Mayur Dhaka on 08/01/15.
//  Copyright (c) 2015 LionWolf. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // defining the UIIMAGEViews as outlets
    @IBOutlet var ticTacImg1: UIImageView!
    @IBOutlet var ticTacImg2: UIImageView!
    @IBOutlet var ticTacImg3: UIImageView!
    @IBOutlet var ticTacImg4: UIImageView!
    @IBOutlet var ticTacImg5: UIImageView!
    @IBOutlet var ticTacImg6: UIImageView!
    @IBOutlet var ticTacImg7: UIImageView!
    @IBOutlet var ticTacImg8: UIImageView!
    @IBOutlet var ticTacImg9: UIImageView!
    
    @IBOutlet var ticTacBtn1: UIButton!
    @IBOutlet var ticTacBtn2: UIButton!
    @IBOutlet var ticTacBtn3: UIButton!
    @IBOutlet var ticTacBtn4: UIButton!
    @IBOutlet var ticTacBtn5: UIButton!
    @IBOutlet var ticTacBtn6: UIButton!
    @IBOutlet var ticTacBtn7: UIButton!
    @IBOutlet var ticTacBtn8: UIButton!
    @IBOutlet var ticTacBtn9: UIButton!

    @IBOutlet var resetBtn: UIButton!
    
    @IBOutlet var userMessage: UILabel!
    
    
    
   
    
    
    
    
    //code begins
    
    var plays: Dictionary<Int,Int> = [:]  //position, 0/1: 1 is the user
    var gameHasEnded = false
    var aiThoughtProcess = false
    
    
    
    @IBAction func buttonPressed(sender: UIButton){
        //check: is the game over?   is the button occupied?    is AI thinking?
        
        if (!gameHasEnded && !aiThoughtProcess && plays[sender.tag] == nil){
            
            makeMoveFor(sender.tag,player: 1)
            checkIfWon()
            
            aiTurn()
            
        }
    }
    
    
    func makeMoveFor(spot: Int, player: Int){
        plays[spot] = player    //set the player as 1 or 0(human or AI) for spot 
        
        var playerIdentity = (player == 1 ? "x" : "o") //which image is to be inserted. 1= human
        
        switch spot{
        case 1:
            ticTacImg1.image = UIImage(named: playerIdentity)
        case 2:
            ticTacImg2.image = UIImage(named: playerIdentity)
        case 3:
            ticTacImg3.image = UIImage(named: playerIdentity)
        case 4:
            ticTacImg4.image = UIImage(named: playerIdentity)
        case 5:
            ticTacImg5.image = UIImage(named: playerIdentity)
        case 6:
            ticTacImg6.image = UIImage(named: playerIdentity)
        case 7:
            ticTacImg7.image = UIImage(named: playerIdentity)
        case 8:
            ticTacImg8.image = UIImage(named: playerIdentity)
        case 9:
            ticTacImg9.image = UIImage(named: playerIdentity)
            
        default:
            //dummy case. Followuing exists only for the heck of it
            ticTacImg9.image = UIImage(named: playerIdentity)
            
        }
        
        
        
    }
    
    
    @IBAction func resetButtonPressed(sender: AnyObject) {
        
        gameHasEnded=false
        
        userMessage.hidden=true
        resetBtn.hidden = true
        reset()
        
    }
    
    func reset(){           //reset needs to have its own function since just this aspect is called later too
        
        plays = [:]
        ticTacImg1.image = nil
        ticTacImg2.image = nil
        ticTacImg3.image = nil
        ticTacImg4.image = nil
        ticTacImg5.image = nil
        ticTacImg6.image = nil
        ticTacImg7.image = nil
        ticTacImg8.image = nil
        ticTacImg9.image = nil
        userMessage.hidden = true
        resetBtn.hidden = true
    }
    
    

    
    func checkIfWon(){
        
        var whoAmI: Dictionary<Int,String> = [:]        //required for displaying in the textbox
        whoAmI[0] = "I" //computer
        whoAmI[1] = "You" //Playa
        
        
        for (key,value) in whoAmI{
            
            var logicalExpression = (plays[7] == key && plays[8] == key && plays[9] == key)                     //preparing the statement since Swift can't handle this entire thing written in the if statement
            
            logicalExpression = logicalExpression || (plays[4] == key && plays[5] == key && plays[6] == key)
            logicalExpression = logicalExpression || (plays[1] == key && plays[2] == key && plays[3] == key)
            logicalExpression = logicalExpression || (plays[1] == key && plays[4] == key && plays[7] == key)
            logicalExpression = logicalExpression || (plays[2] == key && plays[5] == key && plays[8] == key)
            logicalExpression = logicalExpression || (plays[3] == key && plays[6] == key && plays[9] == key)
            logicalExpression = logicalExpression || (plays[1] == key && plays[5] == key && plays[9] == key)

            
            if( logicalExpression||(plays[3] == key && plays[5] == key && plays[7] == key))
            {
                    userMessage.hidden = false
                    userMessage.text = "\(value) won!"
                    resetBtn.hidden = false
            }
            
            
        }
        
    }
    
    
    
    func checkTop(#value: Int) -> (location: String, Pattern: String){
        return ("top", patternGenerator(userIS: value, listToSearch: [1,2,3]))
    }
    func checkBottom(#value: Int) -> (location: String, Pattern: String){
        return ("bottom", patternGenerator(userIS: value, listToSearch: [7,8,9]))
    }
    func checkLeft(#value: Int) -> (location: String, Pattern: String){
        return ("left", patternGenerator(userIS: value, listToSearch: [1,4,7]))
    }
    func checkRight(#value: Int) -> (location: String, Pattern: String){
        return ("right", patternGenerator(userIS: value, listToSearch: [3,6,9]))
    }
    func checkMiddleDown(#value: Int) -> (location: String, Pattern: String){
        return ("middledown", patternGenerator(userIS: value, listToSearch: [2,5,8]))
    }
    func checkMiddleAcross(#value: Int) -> (location: String, Pattern: String){
        return ("middleacross", patternGenerator(userIS: value, listToSearch: [4,5,6]))
    }
    func checkDiagonalLR(#value: Int) -> (location: String, Pattern: String){
        return ("diagonallr", patternGenerator(userIS: value, listToSearch: [1,5,9]))
    }
    func checkDiagonalRL(#value: Int) -> (location: String, Pattern: String){
        return ("diagonalrl", patternGenerator(userIS: value, listToSearch: [3,5,7]))
    }
    
    
    
    func patternGenerator(#userIS: Int, listToSearch: [Int]) -> (String){ //generates a pattern similar to 110, 010 depending on where an 'o' or 'x' exists.
        
        var pattern = ""
        
        for checkerVariable in listToSearch{
            if plays[checkerVariable] == userIS{
                pattern += "1"
            }
            
            else{
                pattern += "0"
            }
           
            
        }
         return pattern
        
    }
    
    
    
    func rowCheck(#value: Int) -> (location: String, Pattern:String)?{  //? = may or maynot return
        
        var acceptablePatterns = ["110", "101", "011"]
        var rowsToCheck = [checkTop, checkBottom, checkMiddleAcross, checkMiddleDown, checkLeft, checkRight, checkDiagonalLR, checkDiagonalRL]
        
        for currentFunction in rowsToCheck{
            
            var functionResult = currentFunction(value: value) //all the rows to check are passed value
            if (find(acceptablePatterns, functionResult.Pattern) != nil){   //if function's returned value's pattern valiable is matched to the list of acceptable patterns
                return functionResult
            }
        }
        return nil
        
        
        
    }
    
    
    
    func whereToPlay( location: String, pattern: String) -> Int{      //returns the integer value of where to make the move
        var leftPattern = "011"
        var midPattern = "101"
        var rightPattern = "110"
        
        switch location{
            
        case "top":
            if pattern == leftPattern{
                return 1
            }
            else if pattern == midPattern{
                return 2
            }
            else{
                return 3
            }
            
        case "bottom":
            if pattern == leftPattern{
                return 7
            }
            else if pattern == midPattern{
                return 8
            }
            else{
                return 9
            }
            
        case "left":
            if pattern == leftPattern{
                return 1
            }
            else if pattern == midPattern{
                return 4
            }
            else{
                return 7
            }
        case "right":
            if pattern == leftPattern{
                return 3
            }
            else if pattern == midPattern{
                return 6
            }
            else{
                return 9
            }
            
        case "middledown":
            if pattern == leftPattern{
                return 2
            }
            else if pattern == midPattern{
                return 5
            }
            else{
                return 8
            }
            
        case "middleacross":
            if pattern == leftPattern{
                return 4
            }
            else if pattern == midPattern{
                return 5
            }
            else{
                return 6
            }
            
        case "diagonallr":
            if pattern == leftPattern{
                return 1
            }
            else if pattern == midPattern{
                return 5
            }
            else{
                return 9
            }
            
        case "diagonalrl":
            if pattern == leftPattern{
                return 3
            }
            else if pattern == midPattern{
                return 5
            }
            else{
                return 7
            }
            
        default:
            return 2
            
        }
    }
    
    
    
    func positionIsOcupied( spot: Int) -> Bool{ // check this if there are errors
        
       var x = plays[spot] != nil ? true : false
        return x
        
    }
    
    

    func firstAvailable(#isCorner:Bool) -> Int?{
        
        var spots = isCorner ? [1,3,7,9] : [2,4,6,9]
        for spot in spots{
            if positionIsOcupied(spot) == false{
                return spot
            }
        }
        return nil
    }
    
    
    
    
    func aiTurn(){
       
        //-----------------
        if gameHasEnded{
            return
        }
        
        
        aiThoughtProcess = true
        
        //-------------
        
        
        //on a prirotiiy basis, we have to check a few rules or states. we = the computer
        
        
        
        //1.   We have two 'O's in a row: we are about to win
        
        if let result = rowCheck(value : 0){
            
            var whereToPlayResult: Int = whereToPlay(result.location, pattern:result.Pattern)
            if positionIsOcupied(whereToPlayResult) == false{
                
                makeMoveFor(whereToPlayResult, player: 0)   //the AI plays
                aiThoughtProcess = false
                checkIfWon()
                return
            }
                
        }
        
        
        //2. If the user is about to win:
        
        if let result = rowCheck(value : 1){        //checking for 1, ie the user
            
            var whereToPlayResult: Int = whereToPlay(result.location, pattern:result.Pattern)
            if positionIsOcupied(whereToPlayResult) == false{
                
                makeMoveFor(whereToPlayResult, player: 0)   //the AI plays
                aiThoughtProcess = false
                checkIfWon()
                return
            }
            
        }
        
        
        //3. Is the center available?
        
        if positionIsOcupied(5) == false{
            makeMoveFor(5, player: 0)
            aiThoughtProcess = false
            checkIfWon()
            return
        }
        
        
        //4. Is a corner available?
        if let cornerAvailable = firstAvailable(isCorner:true){
            makeMoveFor(cornerAvailable, player: 0)
            aiThoughtProcess = false
            checkIfWon()
            return
            
        }
        //5. Is a side available?
        if let sideAvailable = firstAvailable(isCorner:false){
            makeMoveFor(sideAvailable, player: 0)
            aiThoughtProcess = false
            checkIfWon()
            return
            
        }
        
        
        //6. it was a draw
        userMessage.hidden = false
        userMessage.text = "It was a tie"
        reset()     //reason why reset had to have its own separate function
        aiThoughtProcess = false
        return
}


    
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

