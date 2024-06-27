Class {
	#name : #ThirtyTwoBitExperiment,
	#superclass : #Object,
	#instVars : [
		'sprite'
	],
	#category : #'BookletGraphicsBloc-Form'
}

{ #category : #initialization }
ThirtyTwoBitExperiment >> magnifyFactor [
	^ 15
]

{ #category : #accessing }
ThirtyTwoBitExperiment >> thirtyTwoBitColorDepth1 [
<bookExample>
^(Form extent: 7@1 "size of the form"
 depth: 32 "color depth")
 initFromArray: #( "pixel color, expressed on 4 bytes or 32 bits, which is the maximum of color depth"
"colore are:
2r 00000000 00000000 00000000 00000000 
     ALPHA    RED 		BLUE     GREEN   "
		16rffff0000 "red"
		16rff0000ff "blue"
		16rff00ff00 "green"
		16rff000000 "black"
		16rffffffff "white"
		16rf0ff00d9 "pink"
		16r2fff0000 "red with opacity"
); magnifyBy: self magnifyFactor 
]

{ #category : #accessing }
ThirtyTwoBitExperiment >> thirtyTwoBitColorDepth2 [
<bookExample>
^(Form extent: 3@3 "size of the form"
 depth: 32 "color depth")
 initFromArray: #( "pixel color, expressed on 4 bytes or 32 bits, which is the maximum of color depth"
"colore are:
2r 00000000 00000000 00000000 00000000 
     ALPHA    RED 		BLUE     GREEN   "
		16rffff0000 "red" 	 16rff000000 "black" 16rff0000ff "blue"
		16rff000000 "black" 16rffffffff "white" 16rff000000 "black" 
		16rff00ff00 "green" 16rff000000 "black" 16rffffff00 "yello"

) ; magnifyBy: self magnifyFactor 
]
