"
I represent the constraints of a `BlProportionalLayout`.
"
Class {
	#name : 'BlProportionalLayoutConstraints',
	#superclass : 'BlLayoutConstraints',
	#category : 'Bloc-Layout-Proportional',
	#package : 'Bloc-Layout',
	#tag : 'Proportional'
}

{ #category : 'initialization' }
BlProportionalLayoutConstraints >> defaultHorizontal [

	^ BlProportionalLayoutConstraintsHorizontal new
]

{ #category : 'initialization' }
BlProportionalLayoutConstraints >> defaultVertical [

	^ BlProportionalLayoutConstraintsVertical new
]
