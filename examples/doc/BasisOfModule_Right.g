#! @Chunk BasisOfModule_Right

LoadPackage( "IntrinsicModules" );

#! @Example
zz := HomalgRingOfIntegers( );
#! Z
M := HomalgMatrix( "[ \
2, 3, 4, \
5, 6, 7  \
]", 2, 3, zz );
#! <A 2 x 3 matrix over an internal ring>
M := RightPresentation( M );
#! <A right module on 2 generators satisfying 3 relations>
Display( M );
#! [ [  2,  3,  4 ],
#!   [  5,  6,  7 ] ]
#! 
#! Cokernel of the map
#! 
#! Z^(3x1) --> Z^(2x1),
#! 
#! currently represented by the above matrix
BasisOfModule( M );
#! <A set of 2 relations for 2 generators of a homalg right module>
M;
#! <A torsion right module on 2 generators satisfying 2 relations>
Display( M );
#! [ [  1,  0 ],
#!   [  1,  3 ] ]
#! 
#! Cokernel of the map
#! 
#! Z^(2x1) --> Z^(2x1),
#! 
#! currently represented by the above matrix
#! @EndExample
