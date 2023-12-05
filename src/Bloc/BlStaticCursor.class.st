Class {
	#name : 'BlStaticCursor',
	#superclass : 'BlCursor',
	#instVars : [
		'image'
	],
	#category : 'Bloc-Space - Cursor',
	#package : 'Bloc',
	#tag : 'Space - Cursor'
}

{ #category : 'converting' }
BlStaticCursor >> asForm [
	^ self image
]

{ #category : 'accessing' }
BlStaticCursor >> image [
	<return: #Form>

	^ image
]

{ #category : 'accessing' }
BlStaticCursor >> image: aForm [
	image := aForm
]
