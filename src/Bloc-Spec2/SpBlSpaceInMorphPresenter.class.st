"
I'm a Spec2 presenter with a Bloc space ready to work.

I provide a space that is already shown using a `BlMorphicHost` to embed it in a `Morph`, which is added via `SpMorphPresenter`.

See class-side for an example.
"
Class {
	#name : #SpBlSpaceInMorphPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'space',
		'morphPresenter'
	],
	#category : #'Bloc-Spec2'
}

{ #category : #layout }
SpBlSpaceInMorphPresenter class >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		add: #morphPresenter;
		yourself
]

{ #category : #examples }
SpBlSpaceInMorphPresenter class >> example [

	| spacePresenter aSpace |
	spacePresenter := SpBlSpaceInMorphPresenter new.

	"The space is ready to play with it"
	aSpace := spacePresenter space.

	aSpace root
		background: Color paleBlue;
		layout: BlFlowLayout horizontal.

	50 timesRepeat: [ 
		aSpace root addChild:
			(BlElement new
				background: Color random translucent;
				addEventHandlerOn: BlMouseEnterEvent
					do: [ :evt | evt target
						background: Color random ];
				yourself) ].

	spacePresenter open.

	^ spacePresenter
]

{ #category : #initialization }
SpBlSpaceInMorphPresenter >> initializePresenters [

	super initializePresenters.
	
	morphPresenter := self newMorph
		morph:
			(Morph new
				color: Color transparent;
				layoutPolicy: TableLayout new;
				yourself);
		yourself.

	space := BlSpace new
		host: (BlMorphicHost new
			containerMorph: morphPresenter morph;
			yourself);
		show;
		yourself.

]

{ #category : #accessing }
SpBlSpaceInMorphPresenter >> space [
	"Answer a space ready to work."

	^ space
]
