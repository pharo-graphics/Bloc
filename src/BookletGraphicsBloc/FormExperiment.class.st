"
Experiment on creating manually Form, and open it in a Morph

"
Class {
	#name : #FormExperiment,
	#superclass : #Morph,
	#instVars : [
		'sprite'
	],
	#category : #'BookletGraphicsBloc-Morph'
}

{ #category : #accessing }
FormExperiment >> defaultLabel [

	^ 'form experiment'
]

{ #category : #'instance creation' }
FormExperiment >> drawOn: aCanvas [

	aCanvas
		paintImage: (sprite magnifyBy: self magnifyFactor)
		at: self topLeft
]

{ #category : #accessing }
FormExperiment >> helloWorldInBitmap [
	^ (Form extent: 4 @ 3 depth: 8) initFromArray:
		  (('Hello world!' asByteArray groupsOf: 4) collect: [ :each | 
			   each asInteger ])
]

{ #category : #initialization }
FormExperiment >> initialize [
	super initialize.
	sprite := self helloWorldInBitmap.
	self extent: (32 * self magnifyFactor) @ (32 * self magnifyFactor)
]

{ #category : #initialization }
FormExperiment >> magnifyFactor [
	^ 15
]

{ #category : #'instance creation' }
FormExperiment >> open [
	<script: 'self new openInWindow'>
]
