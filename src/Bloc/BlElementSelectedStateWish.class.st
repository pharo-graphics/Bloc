Class {
	#name : 'BlElementSelectedStateWish',
	#superclass : 'BlElementStateWish',
	#instVars : [
		'selected'
	],
	#category : 'Bloc-Basic-State',
	#package : 'Bloc',
	#tag : 'Basic-State'
}

{ #category : 'accessing' }
BlElementSelectedStateWish class >> selected: aBoolean [
	^ self new selected: aBoolean
]

{ #category : 'accessing' }
BlElementSelectedStateWish >> selected [
	^ selected
]

{ #category : 'accessing' }
BlElementSelectedStateWish >> selected: anObject [
	selected := anObject
]
