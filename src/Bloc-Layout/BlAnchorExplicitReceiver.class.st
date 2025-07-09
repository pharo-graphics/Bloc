Class {
	#name : #BlAnchorExplicitReceiver,
	#superclass : #BlAnchorReceiver,
	#instVars : [
		'element'
	],
	#category : #'Bloc-Layout-Anchor'
}

{ #category : #accessing }
BlAnchorExplicitReceiver class >> element: anElement [

	^ self new
		  element: anElement;
		  yourself
]

{ #category : #accessing }
BlAnchorExplicitReceiver >> element [

	^ element
]

{ #category : #accessing }
BlAnchorExplicitReceiver >> element: anElement [

	element := anElement
]
