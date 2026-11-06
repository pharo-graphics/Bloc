Extension { #name : #BlElementGeometry }

{ #category : #'*Bloc-Spec2' }
BlElementGeometry >> inspectionElement [
	"Answer an element showing a copy of me in a white frame, for the inspector.
	The copy is used because an element adapts its geometry to its extent (`matchElement:`),
	which would change me."

	| element |
	element := self copy asElement.
	element extent: self inspectionExtent.
	^ BlElement new
		  layout: BlFrameLayout new;
		  padding: (BlInsets all: 10);
		  background: Color white;
		  constraintsDo: [ :each |
			  each horizontal fitContent.
			  each vertical fitContent ];
		  addChild: element;
		  yourself
]

{ #category : #'*Bloc-Spec2' }
BlElementGeometry >> inspectionExtent [
	"Answer the extent of the element showing me in the inspector."

	^ 150 @ 100
]

{ #category : #'*Bloc-Spec2' }
BlElementGeometry >> inspectionGeometry: aBuilder [
	"Show a preview of me, drawn on an element with the default look of `asElement`."

	<inspectorPresentationOrder: 0 title: 'Geometry'>
	^ aBuilder newMorph
		  morph: self inspectionElement asPreviewMorph;
		  yourself
]
