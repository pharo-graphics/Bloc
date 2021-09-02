Class {
	#name : 'BlDevScripterCollection',
	#superclass : 'Object',
	#instVars : [
		'collection'
	],
	#category : 'Bloc-Scripter-Scripter-Utilities'
}

{ #category : 'accessing' }
BlDevScripterCollection >> at: anIndex [
	^ self subclassResponsibility
]

{ #category : 'accessing' }
BlDevScripterCollection >> collection [
	^ collection
]

{ #category : 'accessing' }
BlDevScripterCollection >> collection: anObject [
	collection := anObject
]

{ #category : 'enumerating' }
BlDevScripterCollection >> detect: aBlock ifFound: foundBlock ifNone: exceptionBlock [
	^ self subclassResponsibility
]

{ #category : 'enumerating' }
BlDevScripterCollection >> detect: aBlock ifNone: exceptionBlock [
	^ self detect: aBlock ifFound: [ :anEvent | anEvent ] ifNone: exceptionBlock
]

{ #category : 'enumerating' }
BlDevScripterCollection >> detectEventOfClass: anEventClass ifFound: aFoundBlock ifNone: aNoneBlock [
	^ self 
		detectEventOfClass: anEventClass 
		satisfying: [ :anEvent | true ] 
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : 'enumerating' }
BlDevScripterCollection >> detectEventOfClass: anEventClass ifNone: aNoneBlock [
	^ self 
		detectEventOfClass: anEventClass 
		satisfying: [ :anEvent | true ] 
		ifFound: [ :anEvent | anEvent ]
		ifNone: aNoneBlock
]

{ #category : 'enumerating' }
BlDevScripterCollection >> detectEventOfClass: anEventClass satisfying: anOneArgBlock ifFound: aFoundBlock ifNone: aNoneBlock [
	^ self 
		detect: [ :eachEvent | eachEvent class = anEventClass and: [ anOneArgBlock value: eachEvent ] ] 
		ifFound: aFoundBlock 
		ifNone: aNoneBlock
]

{ #category : 'accessing' }
BlDevScripterCollection >> first [
	^ self at: 1
]

{ #category : 'testing' }
BlDevScripterCollection >> ifEmpty: aBlock [
	^ self collection ifEmpty: aBlock
]

{ #category : 'testing' }
BlDevScripterCollection >> ifNotEmpty: aBlock [
	^ self collection ifNotEmpty: aBlock
]

{ #category : 'initialization' }
BlDevScripterCollection >> initialize [
	super initialize.
	collection := OrderedCollection new.
]

{ #category : 'testing' }
BlDevScripterCollection >> isEmpty [
	^ self collection isEmpty
]

{ #category : 'testing' }
BlDevScripterCollection >> isNotEmpty [
	^ self collection isNotEmpty
]

{ #category : 'removing' }
BlDevScripterCollection >> removeAll [
	collection removeAll
]

{ #category : 'accessing' }
BlDevScripterCollection >> size [
	^ self collection size
]
