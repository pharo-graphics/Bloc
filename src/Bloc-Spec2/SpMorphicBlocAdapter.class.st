"
I'm a Spec adapter for `SpBlocPresenter` to the Morphic backend.
"
Class {
	#name : #SpMorphicBlocAdapter,
	#superclass : #SpAbstractMorphicAdapter,
	#instVars : [
		'space'
	],
	#category : #'Bloc-Spec2'
}

{ #category : #factory }
SpMorphicBlocAdapter >> buildWidget [

	widget :=
		Morph new
			color: Color transparent;
			layoutPolicy: TableLayout new;
			hResizing: #spaceFill;
			vResizing: #spaceFill;
			yourself.

	space := BlSpace new.
	space host:
		(BlMorphicHost new
			containerMorph: widget;
			yourself).
	space show.

	self refreshBlocElement.
	model whenBlocElementChangedDo: [ self refreshBlocElement ].
	model withWindowDo: [ :aWindow | aWindow whenClosedDo: [ self closeSpace ] ].

	^ widget
]

{ #category : #releasing }
SpMorphicBlocAdapter >> closeSpace [

	space ifNil: [ ^ self ].
	space close.
	space := nil
]

{ #category : #'spec protocol' }
SpMorphicBlocAdapter >> delete [

	self closeSpace.
	super delete
]

{ #category : #'widget API' }
SpMorphicBlocAdapter >> refreshBlocElement [

	space ifNil: [ ^ self ].
	space root removeChildren.

	model blocElement ifNotNil: [ :e | space root addChild: e ]
]

{ #category : #accessing }
SpMorphicBlocAdapter >> space [

	^ space
]

{ #category : #releasing }
SpMorphicBlocAdapter >> unsubscribe [

	self closeSpace.
	super unsubscribe
]
