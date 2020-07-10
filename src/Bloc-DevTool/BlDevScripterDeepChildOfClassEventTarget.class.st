Class {
	#name : #BlDevScripterDeepChildOfClassEventTarget,
	#superclass : #BlDevScripterEventTarget,
	#instVars : [
		'elementClass'
	],
	#category : #'Bloc-DevTool-Scripter-Targets'
}

{ #category : #accessing }
BlDevScripterDeepChildOfClassEventTarget class >> matchesWithInput: anObject [
	<return: #Boolean>
	^ anObject isClass
]

{ #category : #accessing }
BlDevScripterDeepChildOfClassEventTarget class >> newFromInput: anObject [
	^ self new elementClass: anObject
]

{ #category : #accessing }
BlDevScripterDeepChildOfClassEventTarget >> elementClass [
	^ elementClass
]

{ #category : #accessing }
BlDevScripterDeepChildOfClassEventTarget >> elementClass: aClass [
	self 
		assert: [ aClass isNotNil and: [ (self class environment at: aClass name) = aClass ] ] 
		description: [ 'Element class must be defined in the environment' ].
	self 
		assert: [ aClass == BlElement or: [ 
			aClass inheritsFrom: BlElement ] ]
		description: [ 'Element class must be subclass of BlElement' ].
	elementClass := aClass
]

{ #category : #accessing }
BlDevScripterDeepChildOfClassEventTarget >> findTargetIn: anElement [
	<return: #BlElement>

	^ anElement 
		allChildrenBreadthFirstDetect: [ :eachChild | eachChild class = self elementClass ]
		ifFound: [:x | x ]
]

{ #category : #accessing }
BlDevScripterDeepChildOfClassEventTarget >> identifier [
	^ self elementClass ifNil: [ self ]
]
