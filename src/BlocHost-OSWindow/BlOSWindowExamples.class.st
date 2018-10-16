Class {
	#name : #BlOSWindowExamples,
	#superclass : #Object,
	#category : #'BlocHost-OSWindow-Host'
}

{ #category : #example }
BlOSWindowExamples class >> example [
	| space |
	
	space := BlSpace new.
	space host: BlOSWindowHost new.
	space addChild: (BlBasicExamples new elementsWithShadow).
	space show
]
