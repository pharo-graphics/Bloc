Class {
	#name : #BAOffscreen,
	#superclass : #Object,
	#instVars : [
		'session',
		'aeCanvas',
		'cairoContext',
		'textMeasurer'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'Bloc-Alexandrie-Utility'
}

{ #category : #accessing }
BAOffscreen class >> instance [

	^ instance ifNil: [ instance := self new ]
]

{ #category : #accessing }
BAOffscreen class >> resetInstance [
	<script>

	instance := nil
]

{ #category : #initialization }
BAOffscreen >> ensureReady [

	session == Smalltalk session ifTrue: [ ^ self ].
	session := Smalltalk session.

	aeCanvas := AeCanvas extent: 1 asPoint.
	cairoContext := aeCanvas privateAeCairoContext.

	textMeasurer := BACanvasTextMeasurer new
							canvas: aeCanvas;
							yourself
]

{ #category : #api }
BAOffscreen >> measureTextParagraph: aBlTextParagraph [

	self ensureReady.
	textMeasurer measureTextParagraph: aBlTextParagraph
]
