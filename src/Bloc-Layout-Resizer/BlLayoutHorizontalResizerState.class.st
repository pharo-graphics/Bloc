Class {
	#name : 'BlLayoutHorizontalResizerState',
	#superclass : 'BlLayoutResizerState',
	#classInstVars : [
		'any'
	],
	#package : 'Bloc',
	#tag : 'Layout-Resizer',
	#package : 'Bloc-Layout-Resizer'
}

{ #category : 'instance creation' }
BlLayoutHorizontalResizerState class >> any [
	^ any ifNil: [ any := self exact or: (self fitContent or: (self fitContentLimited or: self matchParent)) ]
]

{ #category : 'cleanup' }
BlLayoutHorizontalResizerState class >> cleanUp [
	any := nil
]

{ #category : 'instance creation' }
BlLayoutHorizontalResizerState class >> exact [
	^ BlLayoutHorizontalExactResizerState uniqueInstance
]

{ #category : 'instance creation' }
BlLayoutHorizontalResizerState class >> fitContent [
	^ BlLayoutHorizontalFitContentResizerState uniqueInstance
]

{ #category : 'instance creation' }
BlLayoutHorizontalResizerState class >> fitContentLimited [
	^ BlLayoutHorizontalFitContentLimitedResizerState uniqueInstance
]

{ #category : 'instance creation' }
BlLayoutHorizontalResizerState class >> local [
	^ BlLayoutHorizontalLocalResizerState uniqueInstance
]

{ #category : 'instance creation' }
BlLayoutHorizontalResizerState class >> matchParent [
	^ BlLayoutHorizontalMatchParentResizerState uniqueInstance
]
