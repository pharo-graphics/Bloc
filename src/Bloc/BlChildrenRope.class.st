Class {
	#name : #BlChildrenRope,
	#superclass : #BlChildrenCollection,
	#instVars : [
		'rope'
	],
	#category : 'Bloc-Basic-Children'
}

{ #category : #'children - adding' }
BlChildrenRope >> add: aChild at: anIndex [
	"Adds aChild at a given index moving existing children to the right"

	rope := rope insertItems: { aChild } at: anIndex - 1
]

{ #category : #'children - adding' }
BlChildrenRope >> addAll: aSequenceableCollection [
	rope := rope insertItems: aSequenceableCollection at: rope size
]

{ #category : #'children - accessing' }
BlChildrenRope >> at: anIndex [
	"Return an element at a given index"
	<return: #BlElement>

	^ rope at: anIndex
]

{ #category : #'children - enumerating' }
BlChildrenRope >> do: aBlock [
	rope do: aBlock
]

{ #category : #initialization }
BlChildrenRope >> initialize [
	super initialize.
	
	rope := BlCollectionRope empty 
]

{ #category : #accessing }
BlChildrenRope >> name [
	^ 'Children rope'
]

{ #category : #'children - removing' }
BlChildrenRope >> removeAll: aCollectionOfBlElement [
	aCollectionOfBlElement do: [ :aChild | self remove: aChild ]
]

{ #category : #'children - removing' }
BlChildrenRope >> removeAt: anIndex [
	rope := rope delete: anIndex to: anIndex
]

{ #category : #'children - accessing' }
BlChildrenRope >> size [
	<return: #Number>

	^ rope size
]
