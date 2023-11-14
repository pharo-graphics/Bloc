"
# Attached cached space reference
For performance reasons elements cache a reference to the space so that there is no need all the time to go up the hierarchy of the elements until root to get access to the space.

"
Class {
	#name : #BlAttachedCachedSpaceReference,
	#superclass : #BlAttachedSpaceReference,
	#instVars : [
		'space'
	],
	#category : 'Bloc-Space'
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
