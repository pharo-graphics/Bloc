Class {
	#name : #BlDemoPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'transmissionPresenter',
		'canva'
	],
	#category : #'Bloc-Demo'
}

{ #category : #accessing }
BlDemoPresenter >> canva [ 
	^ canva 
]

{ #category : #accessing }
BlDemoPresenter >> canva: aCanva [
	canva := aCanva 
]

{ #category : #layout }
BlDemoPresenter >> defaultLayout [
	^ SpPanedLayout newLeftToRight 
		positionOfSlider: 600;
		add: transmissionPresenter;
		add: canva;
		yourself
]

{ #category : #TOREMOVE }
BlDemoPresenter >> initialExtent [

	| fontWidth rowHeight |
	fontWidth := (StandardFonts defaultFont widthOfString: 'M').
	rowHeight := self class inputTextHeight.

	^ (90@24) * (fontWidth @ rowHeight)
	
]

{ #category : #initialization }
BlDemoPresenter >> initializeCanvaPresenter [ 
	
	canva := SpBlSpaceInMorphPresenter new
]

{ #category : #initialization }
BlDemoPresenter >> initializePresenters [

	self initializeTransmissionPresenter.
	self initializeCanvaPresenter.
	
]

{ #category : #initialization }
BlDemoPresenter >> initializeTransmissionPresenter [ 

	transmissionPresenter := BlDemoTransmissionPresenter new
]

{ #category : #TOREMOVE }
BlDemoPresenter >> title [ 
	^ 'Bloc UI Framework Demo'
]

{ #category : #accessing }
BlDemoPresenter >> transmissionPresenter [ 
	^ transmissionPresenter 
]

{ #category : #accessing }
BlDemoPresenter >> transmissionPresenter: aPresenter [
	transmissionPresenter := aPresenter 
]
