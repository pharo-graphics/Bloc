"
I render external form (pixel buffer of sparta canvas) to morphic canvas.
I take all available space within host window, by convention my extent = bloc space extent 
"
Class {
	#name : #BlMorphicExternalFormMorph,
	#superclass : #Morph,
	#instVars : [
		'form',
		'hostSpace',
		'defered'
	],
	#category : #'BlocHost-Morphic-Support'
}

{ #category : #drawing }
BlMorphicExternalFormMorph >> drawOn: aCanvas [
	| spaceForm |
	
	spaceForm := form.
	spaceForm isNull
		ifTrue: [ ^ self ].
	hostSpace ifNotNil: [ 
		hostSpace lock critical: [
			aCanvas clipBy: self fullBounds during: [ :aClippedCanvas |
				aClippedCanvas drawImage: spaceForm at: self position ] ] ]
]

{ #category : #accessing }
BlMorphicExternalFormMorph >> form: aForm [
	
	form := aForm.
	
	defered
		ifTrue: [ ^ self ].
	 
	defered := true.
	self defer: [
		defered := false.
		self changed ]
]

{ #category : #accessing }
BlMorphicExternalFormMorph >> hostSpace [
	^ hostSpace
]

{ #category : #accessing }
BlMorphicExternalFormMorph >> hostSpace: anObject [
	hostSpace := anObject
]

{ #category : #initialization }
BlMorphicExternalFormMorph >> initialize [
	super initialize.
	
	form := BlExternalForm extent: 1@1 depth: 32.
	form autoRelease.
	form allocateSpace.
	form fillColor: Color transparent.
	color := Color transparent.
	defered := false
]
