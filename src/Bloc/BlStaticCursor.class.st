Class {
	#name : 'BlStaticCursor',
	#superclass : 'BlCursor',
	#instVars : [
		'image'
	],
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
