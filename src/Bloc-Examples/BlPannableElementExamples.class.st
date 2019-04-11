Class {
	#name : #BlPannableElementExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-Scalable/Pannable'
}

{ #category : #'examples - instance creation' }
BlPannableElementExamples >> pannableElement [
	<gtExample>
	| aPannableElement |
	
	aPannableElement := BlPannableElement new.

	self assert: aPannableElement hasContentElement not. 

	^ aPannableElement
]

{ #category : #'examples - instance creation' }
BlPannableElementExamples >> pannableWithForm [
	| form element pannable |
	form := PolymorphSystemSettings pharoLogoForm.
	element := BlElement new.
	element size: form extent.
	element background: (BlImageBackground new image: form).
	pannable := BlPannableElement new.
	pannable
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ].
	pannable contentElement: element.
	^ pannable
]
