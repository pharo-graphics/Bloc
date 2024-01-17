Class {
	#name : 'BlGridPackedMap',
	#superclass : 'Object',
	#instVars : [
		'values',
		'indices',
		'keys'
	],
	#category : 'Bloc-Layout-Grid-Utilities',
	#package : 'Bloc-Layout',
	#tag : 'Grid-Utilities'
}

{ #category : 'instance creation' }
BlGridPackedMap class >> fromAssociations: anArrayOfAssociations [
	^ self new values: (anArrayOfAssociations collect: #value) keys: (anArrayOfAssociations collect: #key)
]

{ #category : 'accessing' }
BlGridPackedMap >> at: index [
	^ values at: (indices at: index)
]

{ #category : 'private' }
BlGridPackedMap >> compact: anArray indices: theIndices [
	|size result|
	size := anArray size.
	result := Array new: (theIndices ifEmpty: [ 0 ] ifNotEmpty: #max).
	
	1 to: size do: [ :index | result at: (theIndices at: index) put: (anArray at: index) ].
	^ result
]

{ #category : 'private' }
BlGridPackedMap >> createIndex: theKeys [
	| size result keyToIndex |
	size := theKeys size.
	result := Array new: size withAll: 0.
	keyToIndex := Dictionary new.
	
	1 to: size do: [ :i |
		| key index |
		key := theKeys at: i.
		index := keyToIndex at: key ifAbsentPut: [ keyToIndex size + 1 ].
		result at: i put: index ].
	^ result
]

{ #category : 'accessing' }
BlGridPackedMap >> keys [
	^ keys
]

{ #category : 'accessing' }
BlGridPackedMap >> keysAndValuesDo: aBlock [

	1 to: self keys size do: [ :i | aBlock value: (self keys at: i) value: (self values at: i) ]
]

{ #category : 'accessing' }
BlGridPackedMap >> keysDo: aBlock [
	self keys do: aBlock
]

{ #category : 'accessing' }
BlGridPackedMap >> values [
	^ values
]

{ #category : 'accessing' }
BlGridPackedMap >> values: theValues keys: theKeys [
	indices := self createIndex: theKeys.
	keys := self compact: theKeys indices: indices.
	values := self compact: theValues indices: indices
]

{ #category : 'accessing' }
BlGridPackedMap >> valuesDo: aBlock [
	self values do: aBlock
]
