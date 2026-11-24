"
I am a Spec2 widget presenter that displays a Bloc element (`BlElement`).

Set or read the displayed element with `#blocElement:` and `#blocElement`, and observe changes with `#whenBlocElementChangedDo:`.

I resolve my backend through `#BlocAdapter`, so the same presenter works across Spec backends:
- On Morphic, `SpMorphicBlocAdapter` embeds the element in a `BlSpace` hosted by `BlMorphicHost`.
- On Toplo (when `Spec-Toplo` is loaded), `SpToploBlocAdapter` embeds the element directly in the Toplo scene graph.

Unlike `SpBlSpaceInMorphPresenter`, which exposes a Morphic-hosted `BlSpace` directly, I focus on embedding a `BlElement` in a backend-agnostic way.

### Example
```smalltalk
| element |
element :=
	BlElement new
		extent: 150 @ 150;
		background: Color paleBlue;
		yourself.

SpBlocPresenter new
	blocElement: element;
	open
```
"
Class {
	#name : #SpBlocPresenter,
	#superclass : #SpAbstractWidgetPresenter,
	#instVars : [
		'#blocElement => ObservableSlot'
	],
	#category : #'Bloc-Spec2'
}

{ #category : #specs }
SpBlocPresenter class >> adapterName [

	^ #BlocAdapter
]

{ #category : #accessing }
SpBlocPresenter >> blocElement [

	^ blocElement
]

{ #category : #accessing }
SpBlocPresenter >> blocElement: aBlElement [ 

	blocElement := aBlElement
]

{ #category : #initialization }
SpBlocPresenter >> initialize [

	self class initializeSlots: self.
	super initialize.
]

{ #category : #enumerating }
SpBlocPresenter >> whenBlocElementChangedDo: aBlock [ 
	"Inform when Bloc element has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #blocElement whenChangedDo: aBlock
]
