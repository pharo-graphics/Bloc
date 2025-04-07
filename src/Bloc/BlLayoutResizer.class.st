Class {
	#name : #BlLayoutResizer,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'Bloc-Layouts-Support'
}

{ #category : #'instance creation' }
BlLayoutResizer class >> exact: aNumber [
	^ BlLayoutExactResizer size: aNumber
]

{ #category : #'instance creation' }
BlLayoutResizer class >> fitContent [
	^ BlLayoutFitContentResizer uniqueInstance
]

{ #category : #'instance creation' }
BlLayoutResizer class >> fitContentLimited [
	^ BlLayoutFitContentLimitedResizer uniqueInstance
]

{ #category : #'instance creation' }
BlLayoutResizer class >> fitContentLimitedOffset: aNumber [
	^ BlLayoutFitContentLimitedOffsetResizer offset: aNumber
]

{ #category : #'instance creation' }
BlLayoutResizer class >> matchParent [
	^ BlLayoutMatchParentResizer uniqueInstance
]

{ #category : #comparing }
BlLayoutResizer >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	^ self class = anObject class
]

{ #category : #comparing }
BlLayoutResizer >> hash [
	^ self class hash
]

{ #category : #controlling }
BlLayoutResizer >> ifExact: aBlock [
	^ self
]

{ #category : #controlling }
BlLayoutResizer >> ifFitContent: aBlock [
	^ self
]

{ #category : #controlling }
BlLayoutResizer >> ifMatchParent: aBlock [
	^ self
]

{ #category : #testing }
BlLayoutResizer >> isExact [
	^ false
]

{ #category : #testing }
BlLayoutResizer >> isFitContent [
	^ false
]

{ #category : #testing }
BlLayoutResizer >> isFitContentLimited [
	^ false
]

{ #category : #testing }
BlLayoutResizer >> isMatchParent [
	^ false
]

{ #category : #'double dispatching' }
BlLayoutResizer >> measurementAtMostWith: aNumber [

	^ self subclassResponsibility
]

{ #category : #'double dispatching' }
BlLayoutResizer >> measurementExactlyWith: aNumber [
	^ self subclassResponsibility
]

{ #category : #'double dispatching' }
BlLayoutResizer >> measurementUnspecifiedWith: aNumber [
	^ self subclassResponsibility
]
