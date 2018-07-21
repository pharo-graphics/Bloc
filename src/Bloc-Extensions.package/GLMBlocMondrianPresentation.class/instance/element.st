scripting
element
	<return: #BlElement>
	| view |
	
	"returned a cached created element or create a new one"
	createdElement
		ifNotNil: [ ^ createdElement ].
	
	view := viewInitializer value.
	paintingBlock glamourValue: 
			(view asGlamorousMultiValue, 
			self displayValue asGlamorousMultiValue,
			self asGlamorousMultiValue).
	shouldInstallClicksOnNodes ifTrue: [ 
		view topStep root when: BlClickEvent do: [ :anEvent |
			anEvent target withParentsDo: [ :element |
				element graph isNode
					ifTrue: [
						anEvent consumed: true.
						self selection: element graph model ] ] ] ].
	shouldInstallClicksOnEdges ifTrue: [
		view topStep root when: BlClickEvent do: [ :anEvent |
			anEvent target withParentsDo: [ :element |
				element graph isEdge
					ifTrue: [
						anEvent consumed: true.
						self selection: element graph model ] ] ] ].
	view topStep root 
		when: GLMBlocObjectToSelect 
		do: [:signal | self selection: signal toSelect ].

	^ createdElement := view asPannableElement