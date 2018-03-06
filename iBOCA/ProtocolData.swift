//
//  ProtocolData.swift
//  iBOCA
//
//  Created by saman on 12/3/17.
//  Copyright © 2017 sunspot. All rights reserved.
//

import Foundation

// tests need to be put in order
//  Cats and Dogs
//  Forward Digit Span
//  Backward Digit Span
//  Trails B
//  Serial 3
//  Go/No go
//  Months backward
//  Letter Fluency

let ProtocolOrder = ["A":[6, 1, 2, 4, 3, 5, 7, 0],
                     "B":[7, 2, 3, 6, 1, 0, 5, 4],
                     "C":[0, 4, 5, 1, 3, 6, 2, 7],
                     "D":[3, 5, 6, 4, 0, 7, 1, 2],
                     "E":[2, 6, 7, 0, 4, 3, 5, 1],
                     "F":[1, 3, 4, 7, 6, 2, 0, 5],
                     "G":[5, 0, 1, 3, 7, 2, 4, 6],
                     "H":[7, 2, 3, 6, 1, 0, 4, 5]]

let ProtocolFDS = ["A": [[[3, 7, 1, 9],
                          [9, 2, 8, 4]],
                         [[7, 1, 4, 2, 8],
                          [9, 6, 2, 7, 1]],
                         [[8, 3, 9, 7, 1, 4],
                          [7, 2, 5, 1, 4, 8]],
                         [[5, 3, 8, 9, 6, 1, 7],
                          [2, 8, 3, 7, 1, 5, 9]],
                         [[3, 9, 6, 3, 8, 2, 1, 7],
                          [2, 7, 9, 5, 4, 8, 3, 1]],
                         [[7, 3, 1, 8, 9, 6, 4, 2, 5],
                          [4, 7, 2, 6, 1, 9, 5, 3, 8]]],
                   "B": [[[8, 1, 2, 6],
                          [7, 4, 8, 3]],
                         [[9, 6, 8, 5, 1],
                          [9, 1, 8, 5, 2]],
                         [[7, 4, 9, 3, 1, 8],
                          [5, 2, 6, 9, 3, 7]],
                         [[3, 1, 6, 5, 8, 2, 7],
                          [8, 1, 5, 9, 2, 6, 3]],
                         [[6, 1, 4, 9, 3, 7, 5, 2],
                          [5, 9, 6, 2, 8, 1, 3, 7]],
                         [[2, 7, 3, 8, 4, 6, 5, 1, 9],
                          [3, 7, 1, 9, 6, 4, 8, 5, 2]]],
                   "C": [[[9, 6, 3, 7],
                          [6, 1, 8, 3]],
                         [[1, 4, 2, 5, 7],
                          [9, 3, 8, 6, 1]],
                         [[4, 9, 6, 3, 2, 5],
                          [7, 2, 9, 4, 1, 8]],
                         [[1, 4, 7, 3, 8, 2, 9],
                          [6, 1, 4, 9, 5, 2, 8]],
                         [[8, 4, 1, 9, 3, 6, 2, 7],
                          [9, 7, 3, 8, 4, 2, 5, 1]],
                         [[4, 9, 8, 3, 7, 2, 5, 1, 6],
                          [2, 7, 1, 3, 6, 4, 9, 5, 8]]],
                   "D": [[[5, 9, 6, 1],
                          [2, 9, 5, 7]],
                         [[6, 2, 7, 4, 1],
                          [9, 6, 2, 8, 4]],
                         [[5, 2, 7, 4, 1, 8],
                          [6, 3, 2, 8, 5, 9]],
                         [[2, 9, 3, 7, 1, 5, 8],
                          [5, 1, 6, 9, 2, 8, 3]],
                         [[8, 2, 9, 4, 1, 6, 3, 7],
                          [1, 8, 3, 7, 4, 9, 5, 2]],
                         [[7, 2, 6, 1, 8, 5, 3, 9, 4],
                          [4, 7, 3, 8, 5, 1, 9, 6, 2]]],
                   "E": [[[1, 5, 9, 4],
                          [7, 3, 9, 2]],
                         [[9, 7, 2, 6, 1],
                          [6, 3, 9, 1, 8]],
                         [[7, 5, 1, 4, 9, 2],
                          [8, 2, 5, 1, 6, 9]],
                         [[4, 9, 7, 3, 1, 5, 2],
                          [6, 2, 8, 7, 4, 9, 3]],
                         [[3, 1, 7, 4, 9, 5, 2, 8],
                          [8, 1, 5, 2, 9, 4, 7, 3]],
                         [[2, 7, 3, 5, 8, 1, 4, 9, 6],
                          [6, 4, 1, 8, 5, 2, 9, 3, 7]]],
                   "F": [[[7, 4, 1, 8],
                          [2, 8, 1, 7]],
                         [[6, 3, 5, 1, 4],
                          [9, 6, 3, 7, 2]],
                         [[4, 1, 7, 4, 2, 6],
                          [5, 8, 1, 3, 9, 4]],
                         [[1, 9, 6, 2, 5, 8, 3],
                          [9, 2, 8, 5, 1, 6, 2]],
                         [[4, 1, 8, 3, 6, 9, 2, 5],
                          [5, 2, 7, 9, 6, 4, 1, 8]],
                         [[1, 7, 6, 3, 9, 4, 8, 5, 2],
                          [3, 9, 2, 6, 1, 5, 7, 4, 8]]],
                   "G": [[[4, 9, 7, 3],
                          [1, 5, 2, 8]],
                         [[4, 2, 8, 5, 1],
                          [6, 9, 4, 1, 7]],
                         [[7, 2, 5, 9, 1, 6],
                          [9, 7, 3, 2, 6, 1]],
                         [[7, 4, 1, 5, 8, 2, 9],
                          [9, 2, 6, 3, 8, 4, 1]],
                         [[1, 7, 2, 9, 6, 8, 5, 3],
                          [6, 1, 5, 7, 4, 8, 3, 9]],
                         [[5, 7, 2, 1, 6, 9, 4, 8, 3],
                          [8, 4, 2, 7, 3, 9, 6, 1, 5]]],
                   "H": [[[2, 7, 3, 8],
                          [8, 3, 1, 6]],
                         [[1, 4, 7, 3, 9],
                          [6, 2, 7, 1, 8]],
                         [[9, 7, 3, 6, 2, 5],
                          [4, 1, 3, 8, 5, 9]],
                         [[6, 2, 9, 7, 6, 1, 3],
                          [7, 2, 5, 9, 1, 6, 8]],
                         [[6, 3, 1, 5, 2, 6, 9, 4],
                          [8, 4, 1, 9, 5, 2, 8, 3]],
                         [[6, 2, 5, 9, 6, 1, 4, 7, 3],
                          [5, 9, 3, 7, 4, 8, 2, 6, 1]]]]


let ProtocolBDS = ["A": [[[6, 3],
                          [1, 5]],
                         [[5, 8, 3],
                          [9, 4, 8]],
                         [[7, 9, 5, 2],
                          [8, 2, 6, 9]],
                         [[7, 1, 4, 8, 2],
                          [6, 9, 2, 1, 7]],
                         [[9, 5, 2, 1, 4, 7],
                          [1, 7, 2, 5, 8, 4]],
                         [[9, 7, 1, 5, 3, 8, 6],
                          [3, 8, 2, 7, 1, 6, 9]],
                         [[6, 9, 2, 5, 8, 1, 4, 7],
                          [2, 7, 3, 6, 4, 9, 5, 1]],
                         [[8, 3, 7, 1, 9, 6, 2, 5, 4],
                          [6, 2, 7, 3, 8, 4, 1, 5, 9]]],
                   "B": [[[9, 4],
                          [5, 2]],
                         [[3, 9, 5],
                          [4, 1, 9]],
                         [[7, 5, 2, 6],
                          [8, 4, 1, 7]],
                         [[2, 7, 3, 1, 8],
                          [5, 2, 9, 4, 8]],
                         [[8, 4, 1, 6, 3, 9],
                          [7, 2, 8, 1, 3, 6]],
                         [[8, 2, 7, 3, 6, 1, 9],
                          [3, 8, 5, 1, 7, 2, 6]],
                         [[4, 7, 2, 5, 9, 1, 8, 3],
                          [1, 5, 9, 6, 3, 7, 4, 8]],
                         [[2, 8, 4, 5, 9, 6, 1, 7, 3],
                          [7, 4, 1, 6, 3, 8, 2, 5, 9]]],
                   "C": [[[8, 5],
                          [9, 2]],
                         [[6, 5, 1],
                          [3, 9, 7]],
                         [[6, 9, 5, 1],
                          [2, 9, 1, 4]],
                         [[7, 3, 9, 8, 2],
                          [9, 5, 1, 8, 4]],
                         [[7, 4, 9, 3, 1, 8],
                          [6, 1, 5, 2, 7, 3]],
                         [[2, 7, 9, 1, 8, 4, 5],
                          [4, 9, 3, 8, 5, 1, 7]],
                         [[8, 4, 1, 5, 2, 7, 9, 3],
                          [3, 5, 2, 7, 5, 1, 8, 6]],
                         [[2, 7, 8, 4, 3, 9, 6, 1, 5],
                          [5, 1, 7, 4, 9, 2, 6, 8, 3]]],
                   "D": [[[4, 1],
                          [2, 6]],
                         [[7, 8, 2],
                          [9, 5, 1]],
                         [[1, 5, 9, 2],
                          [3, 6, 1, 8]],
                         [[9, 6, 1, 7, 4],
                          [3, 4, 8, 2, 7]],
                         [[9, 3, 7, 1, 6, 2],
                          [2, 9, 7, 4, 1, 5]],
                         [[7, 2, 8, 6, 3, 1, 4],
                          [5, 8, 2, 3, 9, 1, 6]],
                         [[2, 9, 7, 3, 1, 5, 8, 3],
                          [8, 5, 2, 9, 6, 4, 7, 1]],
                         [[5, 8, 3, 1, 7, 4, 9, 6, 2],
                          [6, 2, 8, 5, 1, 9, 4, 7, 3]]],
                   "E": [[[9, 3],
                          [8, 1]],
                         [[6, 2, 8],
                          [1, 7, 4]],
                         [[9, 5, 1, 4],
                          [2, 8, 6, 3]],
                         [[8, 5, 2, 9, 6],
                          [6, 1, 7, 8, 3]],
                         [[2, 9, 4, 8, 1, 7],
                          [3, 1, 5, 9, 2, 8]],
                         [[4, 7, 1, 6, 9, 2, 8],
                          [3, 8, 5, 1, 6, 2, 7]],
                         [[7, 3, 8, 2, 6, 1, 9, 4],
                          [1, 8, 4, 7, 2, 6, 9, 3]],
                         [[5, 3, 9, 1, 4, 6, 8, 2, 7],
                          [2, 6, 3, 1, 8, 5, 9, 7, 4]]],
                   "F": [[[2, 5],
                          [9, 4]],
                         [[1, 5, 9],
                          [7, 3, 8]],
                         [[5, 2, 6, 1],
                          [2, 8, 4, 9]],
                         [[9, 1, 6, 7, 2],
                          [4, 9, 3, 1, 7]],
                         [[2, 5, 9, 3, 1, 6],
                          [3, 8, 1, 5, 6, 2]],
                         [[7, 2, 9, 6, 5, 1, 4],
                          [4, 8, 5, 2, 6, 3, 7]],
                         [[6, 1, 9, 3, 7, 4, 2, 8],
                          [9, 4, 1, 5, 7, 3, 8, 2]],
                         [[5, 1, 8, 3, 4, 7, 9, 6, 2],
                          [3, 9, 6, 4, 2, 8, 5, 1, 4]]],
                   "G": [[[1, 8],
                          [3, 7]],
                         [[6, 2, 9],
                          [3, 8, 6]],
                         [[7, 1, 9, 6],
                          [5, 3, 9, 7]],
                         [[4, 1, 8, 5, 2],
                          [2, 9, 6, 5, 1]],
                         [[1, 4, 9, 7, 5, 2],
                          [5, 9, 7, 2, 1, 3]],
                         [[2, 7, 3, 1, 4, 9, 5],
                          [4, 9, 7, 2, 5, 8, 3]],
                         [[2, 8, 3, 7, 4, 1, 5, 9],
                          [9, 3, 7, 2, 8, 4, 1, 6]],
                         [[1, 5, 8, 4, 9, 2, 7, 3, 6],
                          [5, 2, 7, 6, 9, 3, 8, 4, 1]]],
                   "H": [[[9, 4],
                          [6, 1]],
                         [[2, 5, 8],
                          [1, 6, 2]],
                         [[3, 1, 8, 5],
                          [7, 6, 9, 3]],
                         [[5, 8, 1, 4, 7],
                          [3, 1, 8, 4, 2]],
                         [[3, 6, 9, 4, 9, 7],
                          [1, 3, 9, 2, 8, 4]],
                         [[5, 8, 3, 7, 4, 1, 9],
                          [1, 9, 4, 7, 2, 3, 5]],
                         [[3, 8, 2, 5, 4, 1, 9, 6],
                          [6, 4, 1, 3, 8, 2, 5, 7]],
                         [[3, 6, 2, 8, 4, 1, 7, 5, 9],
                          [6, 5, 2, 9, 3, 8, 7, 4, 1]]]]
