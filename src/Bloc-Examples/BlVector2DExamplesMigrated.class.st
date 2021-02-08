Class {
	#name : #BlVector2DExamplesMigrated,
	#superclass : #Object,
	#category : #'Bloc-Examples-BasicMigrated'
}

{ #category : #examples }
BlVector2DExamplesMigrated >> vector_0degrees [
	<gtExample>
	| aVector |
	aVector := BlVector x: 10 y: 0.
	
	self assert: aVector length equals: 10.
	self assert: aVector degrees equals: 0.
	
	^ aVector
]

{ #category : #examples }
BlVector2DExamplesMigrated >> vector_180degrees [
	<gtExample>
	| aVector |
	aVector := BlVector x: -10 y: 0.
	
	self assert: aVector length equals: 10.
	self assert: aVector degrees equals: 180.
	
	^ aVector
]

{ #category : #examples }
BlVector2DExamplesMigrated >> vector_270degrees [
	<gtExample>
	| aVector |
	aVector := BlVector x: 0 y: -10.
	
	self assert: aVector length equals: 10.
	self assert: aVector degrees equals: 270.
	
	^ aVector
]

{ #category : #examples }
BlVector2DExamplesMigrated >> vector_346degrees [
	<gtExample>
	| aVector |
	aVector := BlVector x: 4 y: -1.
	
	self 
		assert: (aVector length - 4.123) abs < 0.1 
		description: [ 'vector length must be 4.123 +/- 0.1, but is ', aVector length asString ].
	self 
		assert: (aVector degrees - 346) abs < 0.1 
		description: [ 'vector degrees must be 346 +/- 0.1, but is ', aVector degrees asString ].
	
	^ aVector
]

{ #category : #examples }
BlVector2DExamplesMigrated >> vector_45degrees [
	<gtExample>
	| aVector |
	aVector := BlVector x: 10 y: 10.
	
	self 
		assert: (aVector length - 14.14) abs < 0.1 
		description: [ 'vector length must be 4.123 +/- 0.1, but is ', aVector length asString ].
	self assert: aVector degrees equals: 45.
	
	^ aVector
]
