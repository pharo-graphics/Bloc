Class {
	#name : #BlGridLayoutConstraints,
	#superclass : #BlLayoutConstraints,
	#category : 'Bloc-Layout-Grid'
}

{ #category : #'initialize-release' }
BlGridLayoutConstraints >> defaultHorizontal [
	^ BlGridLayoutConstraintsHorizontal new
]

{ #category : #'initialize-release' }
BlGridLayoutConstraints >> defaultVertical [
	^ BlGridLayoutConstraintsVertical new
]
