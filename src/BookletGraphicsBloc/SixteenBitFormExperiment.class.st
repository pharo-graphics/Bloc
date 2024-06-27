"
(**Form extent: 6@1** ""size of the form""
 depth: 16 ""color depth - 16 => 2 bits to define color value 65K color possible"")
 initFromArray: #( ""pixel color, expressed on 4 bytes or 32 bits, which is the maximum of color depth""
""[ 0  XXXXX XXXXX XXXXX ]

----- ----- -----

       R     G     B
 first pixel 		second pixel   ""
2r01111100000000000000000000011111 ""red - blue""
2r00000011111000000111111111100000 ""green -yellow""
2r01111111111111111000000000000000 ""white -black""
"
Class {
	#name : #SixteenBitFormExperiment,
	#superclass : #Object,
	#instVars : [
		'sprite'
	],
	#category : #'BookletGraphicsBloc-Form'
}

{ #category : #initialization }
SixteenBitFormExperiment >> magnifyFactor [
	^ 15
]

{ #category : #accessing }
SixteenBitFormExperiment >> sixteenColorDepth [
<bookExample>
^(Form extent: 6@1 "size of the form"
 depth: 16 "color depth - 16 => 2 bits to define color value 65K color possible")
 initFromArray: #( "pixel color, expressed on 4 bytes or 32 bits, which is the maximum of color depth"
"[ 0  XXXXX XXXXX XXXXX ]

----- ----- -----

       R     G     B
 first pixel 		second pixel   "
2r01111100000000000000000000011111 "red - blue"
2r00000011111000000111111111100000 "green -yellow"
2r01111111111111111000000000000000 "white -black"
) ; magnifyBy: self magnifyFactor 
]
