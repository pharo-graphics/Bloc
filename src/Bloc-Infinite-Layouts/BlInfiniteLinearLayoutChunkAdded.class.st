"
Is sent when linear layouts adds a new chunk element during the layout process
"
Class {
	#name : #BlInfiniteLinearLayoutChunkAdded,
	#superclass : #BlInfiniteLinearLayoutAnnouncements,
	#instVars : [
		'element'
	],
	#category : 'Bloc-Infinite-Layouts-Linear'
}

{ #category : #accessing }
BlInfiniteLinearLayoutChunkAdded >> element [
	<return: #BlElement>

	^ element
]

{ #category : #accessing }
BlInfiniteLinearLayoutChunkAdded >> element: aBlElement [
	element := aBlElement
]
