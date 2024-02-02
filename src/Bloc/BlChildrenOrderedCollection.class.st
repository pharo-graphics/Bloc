"
I am a holder that uses an `OrderedCollection` to store children of bloc elements.

Internally I maintain one single `OrderedCollection` instance. When children are added or removed I add or remove them from the wrapped collection. 

## Examples
Examples are provided by the class `BlChildrenOrderedCollectionExamples`

"
Class {
	#name : #BlChildrenOrderedCollection,
	#superclass : #BlChildrenCollection,
	#instVars : [
		'collection'
	],
	#category : #'Bloc-Basic-Children'
}

{ #category : #'children - adding' }
BlChildrenOrderedCollection >> add: aChild at: anIndex [
	"Adds aChild at a given index moving existing children to the right"
		
	collection add: aChild beforeIndex: anIndex
]

{ #category : #'children - adding' }
BlChildrenOrderedCollection >> addAll: aSequenceableCollection [
	collection addAll: aSequenceableCollection
]

{ #category : #'children - accessing' }
BlChildrenOrderedCollection >> at: anIndex [
	"Return an element at a given index"
	<return: #BlElement>

	^ collection at: anIndex
]

{ #category : #'children - enumerating' }
BlChildrenOrderedCollection >> do: aBlock [
	collection do: aBlock
]

{ #category : #initialization }
BlChildrenOrderedCollection >> initialize [
	super initialize.
	
	collection := OrderedCollection new
]

{ #category : #accessing }
BlChildrenOrderedCollection >> name [
	^ 'Children ordered collection'
]

{ #category : #removing }
BlChildrenOrderedCollection >> removeAll: aCollectionOfBlElement [
	collection removeAll: aCollectionOfBlElement
]

{ #category : #'children - removing' }
BlChildrenOrderedCollection >> removeAt: anIndex [
	collection removeAt: anIndex
]

{ #category : #'children - accessing' }
BlChildrenOrderedCollection >> size [
	<return: #Number>

	^ collection size
]
