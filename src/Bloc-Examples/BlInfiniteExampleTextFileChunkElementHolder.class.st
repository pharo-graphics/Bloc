Class {
	#name : #BlInfiniteExampleTextFileChunkElementHolder,
	#superclass : #BlInfiniteHolder,
	#instVars : [
		'textChunk'
	],
	#category : #'Bloc-Examples-Infinite Files'
}

{ #category : #initialization }
BlInfiniteExampleTextFileChunkElementHolder >> initialize [
	super initialize.
	
	itemElement := BrEditor new
		look: BrGlamorousRegularEditorLook new;
		vFitContent;
		hMatchParent;
		padding: BlInsets empty
]

{ #category : #accessing }
BlInfiniteExampleTextFileChunkElementHolder >> textChunk [
	^ textChunk
]

{ #category : #accessing }
BlInfiniteExampleTextFileChunkElementHolder >> textChunk: aString [
	textChunk := aString.
	
	"update the ui of the text chunk"
	itemElement text: textChunk
]
