Class {
	#name : 'BlDevScripterElementClassEventTarget',
	#superclass : 'BlDevScripterEventTarget',
	#instVars : [
		'elementClass'
	],
	#category : 'Bloc-Scripter-Scripter-Targets'
}

{ #category : 'testing' }
BlDevScripterElementClassEventTarget class >> matchesWithInput: anObject [
	<return: #Boolean>
	^ anObject isClass
]

{ #category : 'instance creation' }
BlDevScripterElementClassEventTarget class >> newFromInput: anObject [
	^ self new elementClass: anObject
]

{ #category : 'accessing' }
BlDevScripterElementClassEventTarget >> elementClass [
	<return: #Class>
	^ elementClass
]

{ #category : 'accessing' }
BlDevScripterElementClassEventTarget >> elementClass: aClass [
	self
		assert: [ aClass notNil ]
		description: [ 'Element class must not be nil' ].

	self 
		assert: [ self class environment includesKey: aClass name ]
		description: [ 'Element class named {1} does not exist in the environment' format: { aClass name } ].

	self 
		assert: [ (self class environment at: aClass name) = aClass ]
		description: [ 'Element class in the environment named {1} does not correspond to the given class' format: { aClass name } ].

	self 
		assert: [ aClass == BlElement or: [ 
			aClass inheritsFrom: BlElement ] ]
		description: [ 'Element class must be subclass of BlElement' ].
	elementClass := aClass
]

{ #category : 'searching' }
BlDevScripterElementClassEventTarget >> findTargetIn: anElement [
	<return: #BlElement>
	| aChildren |

	aChildren := anElement children select: [ :eachChild | eachChild class = self elementClass ].
	self
		assert: [ aChildren size = 1 ]
		description: [ 'Found {1} potential targets, while it must be just 1' format: { aChildren size } ].

	^ aChildren first
]

{ #category : 'accessing' }
BlDevScripterElementClassEventTarget >> identifier [
	^ self elementClass ifNil: [ self ]
]

{ #category : 'printing' }
BlDevScripterElementClassEventTarget >> printOn: aStream [
	self elementClass ifNil: [ ^ super printOn: aStream ].
	aStream 
		nextPutAll: 'Child Class: ';
		print: self elementClass.
]
