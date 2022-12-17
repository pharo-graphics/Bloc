Class {
	#name : #BlElementStatesSet,
	#superclass : #PluggableSet,
	#category : #'Bloc-Basic-State'
}

{ #category : #testing }
BlElementStatesSet >> hasState: aState [
	^ (self
		like: aState
		ifAbsent: [ ^ false ]) = aState
]

{ #category : #initialization }
BlElementStatesSet >> initialize: n [
	super initialize: n.

	self hashBlock: [ :eachState | eachState type hash ].
	self equalBlock: [ :oneState :anotherState | oneState type = anotherState type ]
]
