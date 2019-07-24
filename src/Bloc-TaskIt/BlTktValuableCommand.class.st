Class {
	#name : #BlTktValuableCommand,
	#superclass : #BlTktCommand,
	#instVars : [
		'valuable'
	],
	#category : #'Bloc-TaskIt-New Implementation'
}

{ #category : #defaults }
BlTktValuableCommand >> defaultValuable [
	^ self subclassResponsibility
]

{ #category : #initialization }
BlTktValuableCommand >> initialize [
	super initialize.
	self valuable: self defaultValuable.
	
]

{ #category : #accessing }
BlTktValuableCommand >> valuable [
	^ valuable
]

{ #category : #accessing }
BlTktValuableCommand >> valuable: aValuable [
	self
		assert: [ aValuable isNotNil ] 
		description: [ 'Valuable must be non-nil' ].
	valuable := aValuable
]
