Extension { #name : #AbstractWorldRenderer }

{ #category : #'*BlocHost-Morphic' }
AbstractWorldRenderer class >> openMorphicWorld [
	| aRenderer aWorld |

	aWorld := self currentWorld.
	
	aWorld worldState worldRenderer class = self
		ifTrue: [ ^ self ].
	
	aRenderer := self forWorld: aWorld.
	
	aWorld isMainWorld 
		ifTrue:[ MainWorldRenderer := aRenderer ].
	
	aWorld worldState worldRenderer: aRenderer.
	Cursor currentCursor: Cursor currentCursor.
		
	WorldMorph currentWorld ifNotNil: [:world | world restoreMorphicDisplay].
	WorldMorph extraWorldList do: #restoreMorphicDisplay.

	SystemProgressMorph enable
]
