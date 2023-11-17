Class {
	#name : #BlDemoPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'transmissionPresenter',
		'canva',
		'errorMessage'
	],
	#category : #'Bloc-Demo-Spec2'
}

{ #category : #running }
BlDemoPresenter class >> run [ 
	<script> 
	self new open
]

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

{ #category : #'as yet unclassified' }
BlDemoPresenter >> drawOnCanva: anElement [

	| root |
	root := self canva space root.
	root removeChildren.
	root addChild: ((anElement isKindOf: BlElement)
		ifTrue: [ anElement ]
		ifFalse: [ self errorMessage ])
]

{ #category : #accessing }
BlDemoPresenter >> errorMessage [

	^ errorMessage ifNil: [
		  BlElement new
			  background: Color lightRed;
			  layout: BlFrameLayout new;
			  constraintsDo: [ :c |
				  c vertical matchParent.
				  c horizontal matchParent ];
			  addChild: (BlTextElement new
					   text:
						   'This method does not return any element for you to see'
							   asRopedText;
					   constraintsDo: [ :c |
						   c frame vertical alignCenter.
						   c frame horizontal alignCenter ]) ]
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

	transmissionPresenter := BlDemoSelectionPresenter new
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
