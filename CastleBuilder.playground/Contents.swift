//: Castle Builder - Solution given to problem n.1: Placing Castles
/*
 
 -- HOW DOES IT WORK? --
 The problem consist in telling how many local max / min we can find in an array of integers. (an array representing height of a land, treated as a signal)
 The procedure to arrive to the solution consist in iterating through the array counting how many times the tendency of the signal changes. So everytime the signal goes from (+) to (-) or from (-) to (+) we increment a counter (i). The number of total max and mins altogether would be (i-1) as everytime we change tendency it means we have either a max or a min.
 
 Example
   array [1,2,1,2]
 counter:
    Incremented 3 times:
            -going from 1(-) to 2(+)
            -going from 2(+) to 1(-)
            -going from 1(-) to 2(+)
 
    The signal has 3 changes of tendency, so for this to occur there must be 2 max/min points
    (3 changes of tendency - 1) -> Equals 2 so we would have 2 castles.
 
 Another solution would be to compare each component with the previous & next one to locate max/ mins (probably more intuitive) but for this it would also be neccessary to filter the array and remove components that are the same as the next one, i.e [1,3,3,4,1] -> [1,3,4,1] which would make it more inefficient
 
 Based on this we can then determine where the castles will be placed (another array with same number of components: '1' if there should be a castle, '0' if there should not be one
 Every change of tendency we set a '1'
*/

import Cocoa

struct CastleTest {
    var sequence: [Int]
    var solution: [Int]
}

/*
 * sameSign
 * Checks that two integer value have the same sign
*/

func sameSign(int1: Int?, int2: Int?) -> Bool {
    guard let value1 = int1, let value2 = int2 else { return false }
    return (value1 > 0 && value2 > 0) || (value1 < 0 && value2 < 0)
}

/*
 * getCastles
 * Returns the number of tendency changes in the array
 * The number of interesting points in the array (local peaks / valleys) will be the number of tendency change divided by two
 * RETURNS a tuple (number of castles, array containing their positions)
 */

func getCastles(array: [Int]) -> (Int, [Int]) {
    
    var tendencyChanges = 0 //Number of times the tendency changes. when it changes more than once, it means there would be a max / min associated therefore a castle
    var lastTendency: Int?
    var castles = [Int](repeating: 0, count: array.count)
    
    
    guard array.count > 0 else { return (0, castles) }
    
    for i in 1..<array.count {
        
        let tendency = array[i] - array[i-1]
        
        if tendency == 0 || sameSign(int1: tendency, int2: lastTendency) {
            //Not interested if the components are the same since there is no difference in height.
            
            // a) A PEAK is an integer or series of integers that is above the immediately preceding and following ints
            // b) A VALLEY is an integer or series of integers that is below the immediately preceding and following ints
            
            // We don't consider a max / min cases like [1,2,2](0 Castles) since a max has to be also greater than the following component.
            // Also, in case we wanted to place a castle, it's a confusing case as we can't determine if where to place the castle (bottom or top ?)
            continue
        }
      
        tendencyChanges += 1
        if tendencyChanges > 1 { // For a peak/valley to occur there must be more than one tendency change (2 and subsequents make them)
            castles[i-1] = 1
        }
        lastTendency = tendency
    }

    return (tendencyChanges-1, castles)
}

func test() {
    
    let tests: [CastleTest] = [CastleTest(sequence: [2,6,6,6,3], solution: [0, 0, 0, 1, 0]),
                               CastleTest(sequence: [1,2,1,2], solution: [0, 1, 1, 0]),
                               CastleTest(sequence: [2,6,4,6,3], solution: [0, 1, 1, 1, 0]),
                               CastleTest(sequence: [6,1,4], solution:[0, 1, 0]),
                               CastleTest(sequence: [1,2,1,1,2], solution: [0, 1, 0, 1, 0]),
                               CastleTest(sequence: [3,2,5,0,6,6,6,6,3,1], solution: [0, 1, 1, 1, 0, 0, 0, 1, 0, 0])
                            ]

    for test in tests {
        
        let (result, destribution) = getCastles(array: test.sequence)
        
        print("Land sequence \(test.sequence)")
        print("\(result) Castles are to be placed following this distribution: \(destribution)")
        print("Solution is: \(test.solution) \(test.solution == destribution ? "Correct ✅" : "Wrong ❌")\n")
    }
}

test()
