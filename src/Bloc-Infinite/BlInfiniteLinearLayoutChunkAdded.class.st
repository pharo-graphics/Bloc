Class {
	#name : 'BlInfiniteLinearLayoutChunkAdded',
	#superclass : 'BlInfiniteLinearLayoutAnnouncements',
	#instVars : [
		'element'
	],
	#category : 'Bloc-Infinite-Layout-Linear',
	#package : 'Bloc-Infinite',
	#tag : 'Layout-Linear'
}

{ #category : 'accessing' }
BlInfiniteLinearLayoutChunkAdded >> element [
	<return: #BlElement>

	^ element
]

{ #category : 'accessing' }
BlInfiniteLinearLayoutChunkAdded >> element: aBlElement [
	element := aBlElement
]
