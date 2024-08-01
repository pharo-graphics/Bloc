"
size of the form"" ""color depth - 16 => 2 bits to define color value"" ""pixel color, expressed on 4 bytes or 32 bits, which is the maximum of color depth
	""[ 0000 0000 0000 0000 0000 0000 0000 0000]
	first 		second    third    fourth pixel   
  Each pixel can have 2^4 = 16 different color""
	""[ 0000 0000 0000 0000 0000 0000 0000 0000]"" ""8 colors"" ""8 colors""
"
Class {
	#name : #FourBitFormExperiment,
	#superclass : #Object,
	#instVars : [
		'sprite'
	],
	#category : #'BookletGraphicsBloc-Form'
}

{ #category : #accessing }
FourBitFormExperiment >> fourBitColorDepth [
<bookExample>
	^ (Form extent: 8 @ 2 depth: 4) initFromArray:
		  #( 2r00000001001000110100010101100111
		     2r10001001101010111100110111101111 ); magnifyBy: self magnifyFactor 
		
		 "size of the form" "color depth - 16 => 2 bits to define color value" "pixel color, expressed on 4 bytes or 32 bits, which is the maximum of color depth"
	"[ 0000 0000 0000 0000 0000 0000 0000 0000]
	first 		second    third    fourth pixel   
  Each pixel can have 2^4 = 16 different color"
	"[ 0000 0000 0000 0000 0000 0000 0000 0000]" "8 colors" "8 colors"
]

{ #category : #accessing }
FourBitFormExperiment >> fourBitColorDepthWithColorForm [
<bookExample>
|pict map|
pict := ColorForm extent: 8@1 depth: 4.

"create a color map of 2^depth color"
map := {  Color transparent. 
			Color white. 
			Color r: 0.0 g: 0.5992179863147605 b: 0.19941348973607037 alpha: 1.0.
			Color gray.
			Color red.
			Color green.
			Color blue.
			Color yellow.
			Color transparent. 
			Color white. 
			Color blue.
			Color gray.
			Color red.
			Color green.
			Color blue.
			Color yellow. 
 }.
pict colors: map.
pict initFromArray: #(2r01000010001100011011110111101111).
^pict magnifyBy: self magnifyFactor 
]

{ #category : #initialization }
FourBitFormExperiment >> magnifyFactor [
	^ 15
]
