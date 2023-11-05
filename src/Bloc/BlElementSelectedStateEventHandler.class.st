Class {
	#name : 'BlElementSelectedStateEventHandler',
	#superclass : 'BlElementStateEventHandler',
	#category : 'Bloc-Basic-State'
}

{ #category : 'private' }
BlElementSelectedStateEventHandler >> element: anElement selected: aBoolean [
	aBoolean
		ifTrue: [ anElement states addState: BlElementState selected ]
		ifFalse: [ anElement states removeState: BlElementState selected ]
]

{ #category : 'api - accessing' }
BlElementSelectedStateEventHandler >> eventsToHandle [
	^ { BlElementSelectedStateWish }
]

{ #category : 'api - event managing' }
BlElementSelectedStateEventHandler >> handleEvent: aBlElementSelectedStateWish [
	self
		element: aBlElementSelectedStateWish currentTarget
		selected: aBlElementSelectedStateWish selected
]
