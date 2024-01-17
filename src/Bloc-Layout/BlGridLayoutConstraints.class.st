Class {
	#name : 'BlGridLayoutConstraints',
	#superclass : 'BlLayoutConstraints',
	#category : 'Bloc-Layout-Grid',
	#package : 'Bloc-Layout',
	#tag : 'Grid'
}

{ #category : 'as yet unclassified' }
BlGridLayoutConstraints >> columnSpec [
	"Column spec defined horizontal characteristics"
	<return: #BlGridLayoutSpec>

	^ self horizontal spec
]

{ #category : 'initialize-release' }
BlGridLayoutConstraints >> defaultHorizontal [
	^ BlGridLayoutConstraintsHorizontal new
]

{ #category : 'initialize-release' }
BlGridLayoutConstraints >> defaultVertical [
	^ BlGridLayoutConstraintsVertical new
]

{ #category : 'as yet unclassified' }
BlGridLayoutConstraints >> rowSpec [
	"Row spec defined vertical characteristics"
	<return: #BlGridLayoutSpec>

	^ self vertical spec
]
