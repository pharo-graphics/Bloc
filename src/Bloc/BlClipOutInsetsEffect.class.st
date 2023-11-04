Class {
	#name : 'BlClipOutInsetsEffect',
	#superclass : 'BlClipOutEffect',
	#instVars : [
		'insets'
	],
	#category : 'Bloc-Effect',
	#package : 'Bloc',
	#tag : 'Effect'
}

{ #category : 'initialization' }
BlClipOutInsetsEffect >> initialize [
	super initialize.
	
	insets := BlInsets empty
]

{ #category : 'accessing' }
BlClipOutInsetsEffect >> insets [
	<return: #BlInsets>

	^ insets
]

{ #category : 'accessing' }
BlClipOutInsetsEffect >> insets: aBlInsets [
	insets := aBlInsets
]
