
Castle Builder - Solution given to problem n.1: Placing Castles
 
 -- HOW DOES IT WORK? --
 The problem consist in telling how many local max / min we can find in an array of integers. (an array representing height of a land, treated as a signal)
 The procedure to get to the solution consist in iterating through the array counting how many times the tendency of the signal changes. So everytime the signal goes from (+) to (-) or from (-) to (+) we increment a counter (i). The number of total max and mins altogether would be (i-1) as everytime there is a change in the tendency it means we have either a max or a min.
 
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
 
 Based on this we can then determine where the castles will be placed (another array with same number of components: '1' if there should be a castle, '0' if there should not be one.
 Every change of tendency we set a '1' in such array.


OTHER NOTES:

Regarding this point in the documentation: 

You can always build a castle at the start of the array, provided it is non-empty. 

I was not quite sure what to do with it, as it could also sound like placing a castle there is mandatory if the array is not empty? Or I could also assume that if we have an array like: [1,2,2,2], there must be a castle there?. 

This solution does not place a castle there since in [1,2,2,2] there is not a max/min, following the rules for a point to be a max/min.

To solve that we could have a parameter that will delimit the components of the array that are buildable.

