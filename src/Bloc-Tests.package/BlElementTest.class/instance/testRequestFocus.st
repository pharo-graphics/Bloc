focus requesting
testRequestFocus
	| element child another elementEvents childEvents anotherEvents |
	
	elementEvents := OrderedCollection new.
	childEvents := OrderedCollection new.
	anotherEvents := OrderedCollection new.
	
	element := self element.
	element addEventHandlerOn: BlFocusEvent do: [ :anEvent | elementEvents add: anEvent ].
	element addEventHandlerOn: BlBlurEvent do: [ :anEvent | elementEvents add: anEvent ].
	child := self element.
	child addEventHandlerOn: BlFocusEvent do: [ :anEvent | childEvents add: anEvent ].
	child addEventHandlerOn: BlBlurEvent do: [ :anEvent | childEvents add: anEvent ].
	another := self element.
	another addEventHandlerOn: BlFocusEvent do: [ :anEvent | anotherEvents add: anEvent ].
	another addEventHandlerOn: BlBlurEvent do: [ :anEvent | anotherEvents add: anEvent ].

	another addChild: child.
	space root addChildren: { element . another }.
	
	self assert: element isFocused not.
	self assert: child isFocused not.
	self assert: another isFocused not.
	self assert: elementEvents size equals: 0.
	self assert: anotherEvents size equals: 0.
	self assert: childEvents size equals: 0.

	element requestFocus.
	self assert: element isFocused.
	self assert: child isFocused not.
	self assert: another isFocused not.
	self assert: elementEvents size equals: 1.
	self assert: elementEvents first isFocus.
	self assert: elementEvents first target == element.
	self assert: anotherEvents size equals: 0.
	self assert: childEvents size equals: 0.
	elementEvents removeAll.
	
	another requestFocus.
	self assert: element isFocused not.
	self assert: child isFocused not.
	self assert: another isFocused.
	self assert: elementEvents size equals: 1.
	self assert: elementEvents first isBlur.
	self assert: elementEvents first target == element.
	self assert: anotherEvents size equals: 1.
	self assert: anotherEvents first isFocus.
	self assert: anotherEvents first target == another.
	self assert: childEvents size equals: 0.
	elementEvents removeAll.
	anotherEvents removeAll.
	
	child requestFocus.
	self assert: element isFocused not.
	self assert: child isFocused.
	self assert: another isFocused not.
	self assert: elementEvents size equals: 0.
	self assert: anotherEvents size equals: 1.
	self assert: anotherEvents first isBlur.
	self assert: anotherEvents first target == another.
	self assert: childEvents size equals: 1.
	self assert: childEvents first isFocus.
	self assert: childEvents first target == child.