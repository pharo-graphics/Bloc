Class {
	#name : 'BlLayoutVerticalResizerState',
	#superclass : 'BlLayoutResizerState',
	#classInstVars : [
		'any'
	],
	#category : 'Bloc-Layout-Resizer',
	#package : 'Bloc-Layout-Resizer'
}

{ #category : 'accessing' }
BlLayoutVerticalResizerState class >> any [
	^ any ifNil: [ any := self exact or: (self fitContent or: (self fitContentLimited or: self matchParent)) ]
]

{ #category : 'cleanup' }
BlLayoutVerticalResizerState class >> cleanUp [
	any := nil
]

{ #category : 'instance creation' }
BlLayoutVerticalResizerState class >> exact [
	^ BlLayoutVerticalExactResizerState uniqueInstance
]

{ #category : 'instance creation' }
BlLayoutVerticalResizerState class >> fitContent [
	^ BlLayoutVerticalFitContentResizerState uniqueInstance
]

{ #category : 'instance creation' }
BlLayoutVerticalResizerState class >> fitContentLimited [
	^ BlLayoutVerticalFitContentLimitedResizerState uniqueInstance
]

{ #category : 'instance creation' }
BlLayoutVerticalResizerState class >> local [
	^ BlLayoutVerticalLocalResizerState uniqueInstance
]

{ #category : 'instance creation' }
BlLayoutVerticalResizerState class >> matchParent [

	^ BlLayoutVerticalMatchParentResizerState uniqueInstance
]

{ #category : 'accessing' }
BlLayoutVerticalResizerState >> type [
	"Return an object used to compare two states when adding to the collection of states in order to prevent
	elements from having duplicated states"
	<return: #Object>

	^ BlLayoutVerticalResizerState
]
