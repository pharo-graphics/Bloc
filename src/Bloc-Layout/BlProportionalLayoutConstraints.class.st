Class {
	#name : #BlProportionalLayoutConstraints,
	#superclass : #BlLayoutConstraints,
	#category : #'Bloc-Layout-Proportional'
}

{ #category : #initialization }
BlProportionalLayoutConstraints >> defaultHorizontal [

	^ BlProportionalLayoutConstraintsHorizontal new
]

{ #category : #initialization }
BlProportionalLayoutConstraints >> defaultVertical [

	^ BlProportionalLayoutConstraintsVertical new
]

{ #category : #accessing }
BlProportionalLayoutConstraints >> fractions [

	^ Rectangle
		left: horizontal leftFraction
		right: horizontal rightFraction
		top: vertical topFraction
		bottom: vertical bottomFraction
]

{ #category : #accessing }
BlProportionalLayoutConstraints >> fractions: aRectangle [

	horizontal leftFraction: aRectangle left.
	horizontal rightFraction: aRectangle right.
	vertical topFraction: aRectangle top.
	vertical bottomFraction: aRectangle bottom
]
