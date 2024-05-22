Class {
	#name : #RdvBasicMorphAnimation,
	#superclass : #Morph,
	#instVars : [
		'sprite',
		'position'
	],
	#category : #'BookletGraphicsBloc-Morph'
}

{ #category : #accessing }
RdvBasicMorphAnimation >> drawOn: aCanvas [
	aCanvas
		drawImage: sprite
		at: self topLeft
		sourceRect: (Rectangle origin: position @ 0 corner: (position + 100) @ 150)
]

{ #category : #accessing }
RdvBasicMorphAnimation >> initialize [
	super initialize.
	sprite := (Form
			extent: 32 @ 6
			depth: 1
			fromArray: #(2r11111111111111111111111111111111 2r10000001100000011000000110000001 2r11100111111001111110011111100111 2r10000001100000011000000110000001 2r10000001100000011000000110000001 2r10000001111111111000000110000001)
			offset: 0 @ 0) magnifyBy: 25.
	position := 0.
	self extent: 100 @ 150
]

{ #category : #accessing }
RdvBasicMorphAnimation >> open [
	<script: 'self new openInWindow'>
	
]

{ #category : #accessing }
RdvBasicMorphAnimation >> step [
	position := position + 100.
	position > 700 ifTrue: [ position := 0 ].
	self changed
]

{ #category : #accessing }
RdvBasicMorphAnimation >> stepTime [
	^ 500
]
