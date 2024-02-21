Class {
	#name : #BlLayoutGraphIterator,
	#superclass : #Object,
	#instVars : [
		'layoutNode'
	],
	#category : #'Bloc-Layouts-Model'
}

{ #category : #'instance creation' }
BlLayoutGraphIterator class >> new [
	self error: '(Use on: instead) I must be always created in a context of a layout node'
]

{ #category : #'instance creation' }
BlLayoutGraphIterator class >> on: aBlLayoutChildNode [
	^ self basicNew
		initialize;
		layoutNode: aBlLayoutChildNode
]

{ #category : #'api - converting' }
BlLayoutGraphIterator >> asArray [
	"Return a collection of all items enumerable by this iterator"
	<return: #Array of: #Object>

	^ Array streamContents: [ :aStream | self do: [ :anObject | aStream nextPut: anObject ] ]
]

{ #category : #'api - enumeration' }
BlLayoutGraphIterator >> do: aBlock [
	"Evaluate a given block with all iterator items"
	
	^ self subclassResponsibility
]

{ #category : #'api - testing' }
BlLayoutGraphIterator >> hasAny [
	"Return true if I have any items"
	<return: #Boolean>
	
	self do: [ :anObject | ^ true ].
	^ false
]

{ #category : #'api - testing' }
BlLayoutGraphIterator >> hasNone [
	"Return true if I don't have any items, false otherwise"
	
	self do: [ :anObject | ^ false ].
	^ true
]

{ #category : #'api - testing' }
BlLayoutGraphIterator >> isEmpty [

	^ self hasNone
]

{ #category : #'api - testing' }
BlLayoutGraphIterator >> isNotEmpty [
	<return: #Boolean>

	^ self hasAny
]

{ #category : #accessing }
BlLayoutGraphIterator >> layoutNode [
	<return: #BlLayoutChildNode>

	^ layoutNode
]

{ #category : #accessing }
BlLayoutGraphIterator >> layoutNode: aBlLayoutChildNode [
	layoutNode := aBlLayoutChildNode
]

{ #category : #'api - enumeration' }
BlLayoutGraphIterator >> select: selectBlock thenDo: doBlock [
	"Utility method to improve readability.
	Do not create the intermediate collection."
	
	self do: [ :anElement |
		(selectBlock value: anElement)
			ifTrue: [ doBlock value: anElement ] ]
]

{ #category : #'api - accessing' }
BlLayoutGraphIterator >> size [
	"Return amount of items that can be returned by this iterator.
	Please note, I have to iterate over all items, so complexity is linear"
	<return: #Number>
	| aCounter |

	aCounter := 0.
	self do: [ :anObject | aCounter := aCounter + 1 ].
	^ aCounter
]
