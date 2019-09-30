Class {
	#name : #BlIgnoredLayoutConstraints,
	#superclass : #BlLayoutConstraints,
	#category : #'Bloc-Layouts-Basic'
}

{ #category : #accessing }
BlIgnoredLayoutConstraints >> alignment [
	^ self horizontal alignment + self vertical alignment
]

{ #category : #initialization }
BlIgnoredLayoutConstraints >> defaultHorizontal [
	^ BlIgnoredLayoutConstraintsHorizontal new
]

{ #category : #initialization }
BlIgnoredLayoutConstraints >> defaultVertical [
	^ BlIgnoredLayoutConstraintsVertical new
]
