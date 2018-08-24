"
I am a BlBackground builder.

Example:

BlBackground builder
	paint: (BlRadialGradientPaint new
		stops: { 0 -> Color blue . 1 -> Color red};
		center: 100@100;
		radius: 200);
	opacity: 0.2; ""change opacity of paint background""
	image: PolymorphSystemSettings pharoLogoForm;
	opacity: 0.6; ""change opacity of image background""
	build
"
Class {
	#name : #BlBackgroundBuilder,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'backgrounds'
	],
	#category : 'Bloc-Basic-Visual'
}

{ #category : #builder }
BlBackgroundBuilder >> build [
	<return: #BlBackground>
	self
		assert: [ backgrounds isNotEmpty ]
		description: [ 'There should be specified at least one background' ].
	
	^ backgrounds size > 1
		ifTrue: [ BlCompositeBackground withAll: backgrounds ]
		ifFalse: [ backgrounds first ]
]

{ #category : #accessing }
BlBackgroundBuilder >> image: aForm [
	backgrounds add: (BlImageBackground image: aForm)
]

{ #category : #initialization }
BlBackgroundBuilder >> initialize [
	super initialize.
	
	backgrounds := OrderedCollection new
]

{ #category : #accessing }
BlBackgroundBuilder >> opacity: aNumber [
	"Change opacity of previously added background"
	
	self
		assert: [ backgrounds isNotEmpty ]
		description: [ 'There is no background to modify!' ].
		
	backgrounds last opacity: aNumber
]

{ #category : #accessing }
BlBackgroundBuilder >> paint: aColorOrBlPaint [
	backgrounds add: (BlPaintBackground paint: aColorOrBlPaint)
]
