rendering
morphFrom: aBlocPresentation
	| container element   |

	container := GLMMorphicBlocWrapperMorph new.
	container color: Color transparent.
	container changeTableLayout.
	container vResizing: #spaceFill.
	container hResizing: #spaceFill.

	element := aBlocPresentation element.
	
	element isAttachedToSceneGraph
		ifFalse: [
			| aHost aSpace |
			aHost := BlMorphicHost new.
			aHost containerMorph: container.
	
			aSpace := BlSpace new.
			aSpace host: aHost.
			
			aSpace root addChild: element.
			aSpace root addEventHandler:
				(BlEventHandler
					on: BlDoubleClickEvent
					do: [ :evt | evt modifiers isShift ifTrue: [ BlElementSelection on: evt target ] ]).

			container space: aSpace.
			aSpace show ].

	^ container