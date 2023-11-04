"
I am fired by {{gtMethod:BlSpace>>#icon:}} when {{gtMethod:BlSpace>>#icon}} is changed.

"
Class {
	#name : #BlSpaceIconChangedEvent,
	#superclass : #BlSpaceEvent,
	#instVars : [
		'iconStencil'
	],
	#category : #'Bloc-Events-Type-Space'
}

{ #category : #accessing }
BlSpaceIconChangedEvent >> iconStencil [
	"Return an object that understands #asElement, or nil"
	
	^ iconStencil
]

{ #category : #accessing }
BlSpaceIconChangedEvent >> iconStencil: aStencil [
	"aStencil is an object that undestands #asElement and returns ${class:BlElement}$"
	
	iconStencil := aStencil
]

{ #category : #sending }
BlSpaceIconChangedEvent >> sendTo: anObject [
	anObject spaceIconChangedEvent: self
]
