"
I provide text measurement in an off-screen canvas.

For time efficiency, I implement the singleton pattern, to reuse an instance along a Pharo session.
"
Class {
	#name : #BAOffscreen,
	#superclass : #Object,
	#instVars : [
		'aeCanvas',
		'textMeasurer'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'Bloc-Alexandrie-Utility'
}

{ #category : #'class initialization' }
BAOffscreen class >> initialize [

	SessionManager default registerUserClassNamed: self name
]

{ #category : #accessing }
BAOffscreen class >> instance [

	^ instance ifNil: [ instance := self new ]
]

{ #category : #accessing }
BAOffscreen class >> resetInstance [
	<script>

	instance := nil
]

{ #category : #'system startup' }
BAOffscreen class >> startUp: isImageStarting [

	isImageStarting ifFalse: [ ^ self ].
	
	self resetInstance
]

{ #category : #api }
BAOffscreen >> canvas [

	self ensureReady.
	^ aeCanvas
]

{ #category : #api }
BAOffscreen >> ensureReady [

	(aeCanvas notNil and: [ aeCanvas isValid ]) ifTrue: [ ^ self ].

	aeCanvas := AeCanvas extent: 1 asPoint.

	textMeasurer :=
		BATextMeasurer new
			canvas: aeCanvas;
			yourself
]

{ #category : #api }
BAOffscreen >> measureTextParagraph: aBlTextParagraph [

	self textMeasurer measureTextParagraph: aBlTextParagraph
]

{ #category : #api }
BAOffscreen >> textMeasurer [

	self ensureReady.
	^ textMeasurer
]
