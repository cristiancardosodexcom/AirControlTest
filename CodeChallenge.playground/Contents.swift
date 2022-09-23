import UIKit

func printMatriz(_ matriz: [[String]]){
    for col in 0...n-1 { //x
        var line = ""
        for ren in 0...m-1 { //y
            line += "\(matriz[ren][col])"
        }
        print(line)
    }
}


func isMatrixEmpty(_ matriz: [[String]]) -> Bool{
    for col in 0...n-1 { //x
        for ren in 0...m-1 { //y
            if matriz[ren][col] != "0" {
                return false
            }
        }
    }
    
    return true
}

//HERE PROGRAM STARTS

var n = 4
var m = 4

//var aviones = [(2,0,"v"),(1,1,"v"),(0,2,">"),(2,2,"^")] //Test case 1
//var aviones = [(3,1,"v"), (2,3,">"), (0,0,">")] //Test case 2
//var aviones = [(2,1,"v"), (1,2,">"), (3,2,"<"), (2,3,"^")] //Test case 3
//var aviones = [(0,0,">"),(0,2,"^"),(2,0,"<"),(2,2,"^")] //Test case 4
//var aviones = [(0,0,">"),(0,2,">"),(0,3,">"),(2,0,"<"),(2,2,"<"),(2,3,"<")] //Test case 5
var aviones = [(2,0,"v"),(1,1,">"),(3,1,"<"),(2,2,"^")] //Test case 6

//INIT MATRIZ WITH ZERO ALL POSITIONS
var originalBoard = [[String]](repeating: [String](repeating: "0", count: n), count: m)

var step = 0
var colisiones = 0

//ADD PLANES TO MATRIX
for avion in aviones {
    originalBoard[avion.0][avion.1] = avion.2
}

//PRINT MATRIX CONTENT
print("Original Old Board:")
printMatriz(originalBoard)

repeat {
    
    step += 1
            
    //TEMPORAL MATRIX
    var newBoard = [[String]](repeating: [String](repeating: "0", count: n), count: m)
        
    for j in 0...n-1 { //x
        for i in 0...m-1 { //y
                            
                if originalBoard[i][j] != "0" && originalBoard[i][j] != "X" {
                
                    var newCoords: (x: Int, y:Int) = (x: 0, y:0)

                    let dir = originalBoard[i][j]
                    
                    switch dir {
                    case "v":
                        newCoords = (i,j+1)
                        break
                    case ">":
                        newCoords = (i+1,j)
                        break
                    case "<":
                        newCoords = (i-1,j)
                        break
                    case "^":
                        newCoords = (i,j-1)
                        break
                    default:
                        break
                    }
                    
                    if newCoords.x >= 0 && newCoords.y >= 0 {
                        if newBoard[newCoords.x][newCoords.y] != "0" {
                            newBoard[newCoords.x][newCoords.y] = "X"
                        } else {
                            newBoard[i][j] = "0"
                            newBoard[newCoords.x][newCoords.y] = dir
                        }
                    } else {
                        newBoard[i][j] = "0"
                    }
                }
            }
    }
   
    print("Compare New Board:")
    printMatriz(newBoard)
    
    //Compare old vs new
    for col in 0...n-1 { //x
        for ren in 0...m-1 { //y
            if newBoard[col][ren] == "X" {
                colisiones += 1
                newBoard[col][ren] = "0"
            }
        }
    }
    
    originalBoard = newBoard
    
} while(!isMatrixEmpty(originalBoard))
    

print("Colisiones: \(colisiones)")
print("Steps: \(step)")
