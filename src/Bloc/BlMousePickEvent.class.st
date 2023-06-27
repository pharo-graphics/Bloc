Class {
	#name : #BlMousePickEvent,
	#superclass : #BlMouseEvent,
	#category : #'Bloc-Events'
}

{ #category : #converting }
BlMousePickEvent >> asMouseOutsideEvent [

	^ self subclassResponsibility 
]

{ #category : #processing }
BlMousePickEvent >> findTargetInSpace: aSpace [

	^ aSpace findMousePickTargetFromEvent: self.
]
