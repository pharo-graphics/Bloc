"
I am a BlBackground builder.
"
Class {
	#name : #BlCompositeBackgroundBuilder,
	#superclass : #BlBackgroundBuilder,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'backgrounds',
		'builders'
	],
	#category : #'Bloc-Basic-Background'
}

{ #category : #builder }
BlCompositeBackgroundBuilder >> build [
	<return: #BlBackground>
	self
		assert: [ builders isNotEmpty ]
		description: [ 'There should be specified at least one background' ].

	^ builders size > 1
		ifTrue: [ (BlCompositeBackground withAll: (builders collect: #build)) opacity: self opacity ]
		ifFalse: [
			self isOpaque
				ifTrue: [ builders first build ]
				ifFalse: [ builders first isOpaque
					ifTrue: [ builders first build opacity: self opacity ]
					ifFalse: [ (BlCompositeBackground withAll: (builders collect: #build)) opacity: self opacity ] ] ]
]

{ #category : #builder }
BlCompositeBackgroundBuilder >> image [
	| aBuilder |
	
	aBuilder := BlImageBackgroundBuilder new.
	builders add: aBuilder.

	^ aBuilder
]

{ #category : #accessing }
BlCompositeBackgroundBuilder >> image: aForm [
	builders add: (BlImageBackgroundBuilder new form: aForm)
]

{ #category : #initialization }
BlCompositeBackgroundBuilder >> initialize [
	super initialize.

	builders := OrderedCollection new
]

{ #category : #accessing }
BlCompositeBackgroundBuilder >> opacity: aNumber [
	"Change opacity of previously added background"
	
	self
		assert: [ backgrounds isNotEmpty ]
		description: [ 'There is no background to modify!' ].
		
	backgrounds last opacity: aNumber
]

{ #category : #builder }
BlCompositeBackgroundBuilder >> paint [
	| aBuilder |
	
	aBuilder := BlPaintBackgroundBuilder new.
	builders add: aBuilder.

	^ aBuilder
]

{ #category : #accessing }
BlCompositeBackgroundBuilder >> paint: aColorOrBlPaint [
	builders add: (BlPaintBackgroundBuilder new paint: aColorOrBlPaint)
]
