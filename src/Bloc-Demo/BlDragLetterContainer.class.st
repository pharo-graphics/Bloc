Class {
	#name : #BlDragLetterContainer,
	#superclass : #BlElement,
	#category : #'Bloc-Demo-DragAndDrop'
}

{ #category : #initialization }
BlDragLetterContainer >> initialize [ 

	super initialize.
	self layout: BlFlowLayout horizontal;
		  constraintsDo: [ :c |
			  c horizontal matchParent.
			  c vertical matchParent ];
		  padding: (BlInsets all: 10);
		geometry: (BlRoundedRectangleGeometry cornerRadius: 5)
]
