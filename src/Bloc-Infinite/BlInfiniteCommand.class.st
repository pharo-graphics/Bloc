Class {
	#name : #BlInfiniteCommand,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#pools : [
		'BlInfiniteConstants'
	],
	#category : #'Bloc-Infinite-DataSource'
}

{ #category : #commands }
BlInfiniteCommand >> applyIn: anInfiniteElement [


	"In case of scrolling, only for item change (no add-remove-move). Check
	if any of the visible items is affected and if not, just ignore the change."
	self subclassResponsibility 
]
