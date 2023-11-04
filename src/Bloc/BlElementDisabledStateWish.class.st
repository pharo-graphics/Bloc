Class {
	#name : 'BlElementDisabledStateWish',
	#superclass : 'BlElementStateWish',
	#instVars : [
		'enabled'
	],
	#package : 'Bloc',
	#tag : 'Basic-State'
}

{ #category : 'accessing' }
BlElementDisabledStateWish >> enabled [
	^ enabled
]

{ #category : 'accessing' }
BlElementDisabledStateWish >> enabled: anObject [
	enabled := anObject
]
