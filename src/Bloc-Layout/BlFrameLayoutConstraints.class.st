Class {
	#name : #BlFrameLayoutConstraints,
	#superclass : #BlLayoutConstraints,
	#package : 'Bloc',
	#tag : 'Layout-Frame'
}

{ #category : #accessing }
BlFrameLayoutConstraints >> alignment [
	^ self horizontal alignment + self vertical alignment
]

{ #category : #initialization }
BlFrameLayoutConstraints >> defaultHorizontal [
	^ BlFrameLayoutConstraintsHorizontal new
]

{ #category : #initialization }
BlFrameLayoutConstraints >> defaultVertical [
	^ BlFrameLayoutConstraintsVertical new
]
