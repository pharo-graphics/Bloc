Class {
	#name : #BlTktValuableCommand,
	#superclass : #BlTktCommand,
	#instVars : [
		'valuable'
	],
	#category : #'Bloc-TaskIt-Commands'
}

{ #category : #defaults }
BlTktValuableCommand >> defaultValuable [
	^ self subclassResponsibility
]

{ #category : #initialization }
BlTktValuableCommand >> ensureName [
	name ifNil: [ self name: self valuable printString ]
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
	valuable := aValuable.
	self ensureName.
]
