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
	space addChild: (BlElement new background: (Color gray alpha: 0.2); size: 200@200).
	space show
]
