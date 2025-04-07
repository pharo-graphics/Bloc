"
My subclasses represent blur-related events.
"
Class {
	#name : #BlBaseFocusEvent,
	#superclass : #BlUIEvent,
	#category : #'Bloc-Events'
}

{ #category : #converting }
BlBaseFocusEvent >> asBlurEvent [

	self deprecated: 'See https://github.com/pharo-graphics/Bloc/issues/704'.

	^ BlBlurEvent new
		  copyFrom: self;
		  yourself
]

{ #category : #converting }
BlBaseFocusEvent >> asFocusInEvent [

	self deprecated: 'See https://github.com/pharo-graphics/Bloc/issues/704'.

	^ BlFocusInEvent new
		  copyFrom: self;
		  canBePropagated: false;
		  yourself
]

{ #category : #converting }
BlBaseFocusEvent >> asFocusOutEvent [

	self deprecated: 'See https://github.com/pharo-graphics/Bloc/issues/704'.

	^ BlFocusOutEvent new
		  copyFrom: self;
		  canBePropagated: false;
		  yourself
]

{ #category : #testing }
BlBaseFocusEvent >> isBaseFocus [

	self deprecated: 'See https://github.com/pharo-graphics/Bloc/issues/704'.

	^ true
]
