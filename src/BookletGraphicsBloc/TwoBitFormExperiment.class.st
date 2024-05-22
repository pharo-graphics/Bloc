"
""size of the form"" ""color depth - 16 => 2 bits to define color value"" ""pixel color, expressed on 4 bytes or 32 bits, which is the maximum of color depth""
	""[ 0000 0000 0000 0000 0000 0000 0000 0000]
	first 		second    third    fourth pixel
  Each pixel can have 2^2 = 4 different color""
	""[ 0000 0000 0000 0000 0000 0000 0000 0000]"" ""4 colors""
"
Class {
	#name : #TwoBitFormExperiment,
	#superclass : #Object,
	#instVars : [
		'sprite'
	],
	#category : #'BookletGraphicsBloc-Form'
}

{ #category : #initialization }
TwoBitFormExperiment >> magnifyFactor [
	^ 15
]

{ #category : #accessing }
TwoBitFormExperiment >> twoBitColorDepth [
<bookExample>
^ (Form extent: 16@1 "size of the form"
 depth: 2 "color depth - 16 => 2 bits to define color value")
 initFromArray: #( "pixel color, expressed on 4 bytes or 32 bits, which is the maximum of color depth"
"[ 0000 0000 0000 0000 0000 0000 0000 0000]
	first 		second    third    fourth pixel
  Each pixel can have 2^2 = 4 different color"
"[ 0000 0000 0000 0000 0000 0000 0000 0000]"
 2r00011011000110110001101100011011 "4 colors"
) ;magnifyBy:
		  self magnifyFactor
]

{ #category : #accessing }
TwoBitFormExperiment >> twoBitColorDepthWithColorForm [

	<bookExample>
	| pict map |
	pict := ColorForm extent: 16 @ 1 depth: 2.

	"create a color map of 2^depth color"
	map := {
		       Color white.
		       (Color
			        r: 0.0
			        g: 0.5992179863147605
			        b: 0.19941348973607037
			        alpha: 1.0).
		       Color blue.
		       Color red }.
	pict colors: map.
	pict initFromArray: #( 2r00011011000110110001101100011011 ).
	^ pict magnifyBy: self magnifyFactor
]
