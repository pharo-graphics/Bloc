Class {
	#name : #BlRowNumberDecoration,
	#superclass : #BlSideBackgroundDecoration,
	#category : #'Bloc-Infinite-Core'
}

{ #category : #geometry }
BlRowNumberDecoration >> numberLeftGap [
	" the gap between the row number background left and the row number"

	^ 4
]

{ #category : #geometry }
BlRowNumberDecoration >> numberVerticalHeightIn: anItemElement fontHeight: fontHeight [

	" By default, the row number is centered vertically"
	^ (anItemElement height - fontHeight) / 2
]
