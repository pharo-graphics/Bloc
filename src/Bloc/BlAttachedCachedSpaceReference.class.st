Class {
	#name : #BlAttachedCachedSpaceReference,
	#superclass : #BlAttachedSpaceReference,
	#instVars : [
		'space'
	],
	#category : #'Bloc-Space'
}

{ #category : #'instance creation' }
BlAttachedCachedSpaceReference class >> forSpace: aBlSpace [
	^ self new space: aBlSpace
]

{ #category : #accessing }
BlAttachedCachedSpaceReference >> space [
	^ space
]

{ #category : #accessing }
BlAttachedCachedSpaceReference >> space: aBlSpace [
	space := aBlSpace
]

{ #category : #enumerating }
BlAttachedCachedSpaceReference >> spaceDo: aBlock [
	"Evaluate a given block with a bloc space as an argument"
	
	aBlock value: self space
]
