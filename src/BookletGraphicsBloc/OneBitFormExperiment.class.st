"
color depth - 1 => 1 bits to define color value

pixel color, expressed on 4 bytes or 32 bits, which is the maximum of color depth
[ 0000 0000 0000 0000 0000 0000 0000 0000]
	first 		second    third    fourth pixel
Each pixel can have 2^1 = 2 different color
[ 0000 0000 0000 0000 0000 0000 0000 0000] ""2 colors""
"
Class {
	#name : #OneBitFormExperiment,
	#superclass : #Object,
	#instVars : [
		'sprite'
	],
	#category : #'BookletGraphicsBloc-Form'
}

{ #category : #initialization }
OneBitFormExperiment >> magnifyFactor [
	^ 15
]

{ #category : #accessing }
OneBitFormExperiment >> oneBitColorDepthWithBitmap [

	<bookExample>
	| bitmap |
	bitmap := Bitmap newFrom: #( 2r10011000000100010000000000000001
		             2r11000000000000000000000000000000 ).

	^ ((Form extent: 32 @ 2 depth: 1) initFromArray: bitmap) magnifyBy:
		  self magnifyFactor
]

{ #category : #accessing }
OneBitFormExperiment >> oneBitColorDepthWithFormColor [
<bookExample>
	| pict map |
	pict := ColorForm extent: 32 @ 2 depth: 1.

	"create a color map of 2^depth color"
	map := { 
		       (Color
			        r: 0.0
			        g: 0.5992179863147605
			        b: 0.19941348973607037
			        alpha: 1.0).
		       Color blue }.
	pict colors: map.
	pict initFromArray: #( 2r01010101010101010101010101010101
		   2r10101010101010101010101010101010 ).
	^ pict magnifyBy: self magnifyFactor 
]

{ #category : #accessing }
OneBitFormExperiment >> oneBitColorDepthWithoutBitmap [

	<bookExample>
	^ (Form extent: 32 @ 2 depth: 1)
		  initFromArray: 
			  #( 2r10011000000100010000000000000001
			     2r11000000000000000000000000000000 );
		  magnifyBy: self magnifyFactor
]
