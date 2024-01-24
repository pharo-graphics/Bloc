Extension { #name : #BlElement }

{ #category : #'*Bloc-Deprecated' }
BlElement >> boundsInParent [
	self deprecated: 'Use `element bounds inParent` instead'.

	^ self bounds inParent asRectangle
]

{ #category : #'*Bloc-Deprecated' }
BlElement >> boundsInParent: aBounds [
	<return: #BlBounds>
	
	self deprecated: 'Use `element bounds inParent` instead'.
	
	^ self localBoundsToParent: (self boundsInLocal: aBounds)
]

{ #category : #'*Bloc-Deprecated' }
BlElement >> childNamed: aChildName [
	<return: #BlElement>
	
	self 
		deprecated:  'Use childWithId: instead' 
		transformWith: '`@receiver childNamed: `@statements1' -> '`@receiver childWithId: `@statements1'.

	^ self childWithId: aChildName
]

{ #category : #'*Bloc-Deprecated' }
BlElement >> childNamed: aContainerName ifFound: ifFoundBlock [
	<return: #BlElement>
	
	self 
		deprecated:  'Use childWithId:ifFound: instead' 
		transformWith: '`@receiver childNamed: `@statements1 ifFound: `@statements2' -> '`@receiver childWithId: `@statements1 ifFound: `@statements2'.

	^ self
		childWithId: aContainerName
		ifFound: ifFoundBlock
]

{ #category : #'*Bloc-Deprecated' }
BlElement >> childNamed: aContainerName ifFound: ifFoundBlock ifNone: ifNoneBlock [
	<return: #BlElement>
	
	self 
		deprecated:  'Use childWithId:ifFound:ifNone: instead' 
		transformWith: '`@receiver childNamed: `@statements1 ifFound: `@statements2 ifNone: `@statements3' -> '`@receiver childWithId: `@statements1 ifFound: `@statements2 ifNone: `@statements3'.

	^ self
		childWithId: aContainerName
		ifFound: ifFoundBlock
		ifNone: ifNoneBlock
]

{ #category : #'*Bloc-Deprecated' }
BlElement >> containerName [
	<return: #Symbol or: nil>

	self deprecated: 'Use #id instead. Cannot use auto rewriting because of very used method, see https://github.com/pharo-graphics/Bloc/issues/207'.
	
	^ self id
]

{ #category : #'*Bloc-Deprecated' }
BlElement >> containerName: aSymbol [
	"Give this element a container name (a Symbol) which can be used to find an element by its name"

	self deprecated: 'Use #id: instead. Cannot use auto rewriting because of very used method, see https://github.com/pharo-graphics/Bloc/issues/207'.

	self id: aSymbol
]

{ #category : #'*Bloc-Deprecated' }
BlElement >> directChildNamed: aContainerName ifFound: ifFoundBlock ifNone: ifNoneBlock [
	<return: #Object>
		
	self 
		deprecated:  'Use directChildNamed:ifFound:ifNone: instead' 
		transformWith: '`@receiver directChildNamed: `@statements1 ifFound: `@statements2 ifNone: `@statements3' -> '`@receiver directChildWithId: `@statements1 ifFound: `@statements2 ifNone: `@statements3'.

	^ self directChildWithId: aContainerName ifFound: ifFoundBlock ifNone: ifNoneBlock
]

{ #category : #'*Bloc-Deprecated' }
BlElement >> extent: aPoint [ 
	self 
		deprecated: 'Use size: instead'
		on: 	'1 October 2017' 
		in: 'Pharo-7.0-alpha.build.132.sha.4ea2f39a9f43185d31b844be5ad33b677f43bf17'.
	^ self size: aPoint 
]

{ #category : #'*Bloc-Deprecated' }
BlElement >> looseFocus [
	self
		deprecated: 'Use #loseFocus instead.'
		transformWith: '`@receiver looseFocus' -> '`@receiver loseFocus'.

	self loseFocus
]

{ #category : #'*Bloc-Deprecated' }
BlElement >> looseFocus: aChildElement [
	self
		deprecated: 'Please use loseFocus: instead.'
		transformWith:
			'`@receiver looseFocus: `@statements1'
				-> '`@receiver loseFocus: `@statements1'.

	self loseFocus: aChildElement
]

{ #category : #'*Bloc-Deprecated' }
BlElement >> openInOBlSpace [
	"Add self to a new BlSpace and show it. Answer such space."
	
	self 
		deprecated:  'Use #openInSpace instead' 
		transformWith: '`@receiver openInOBlSpace' -> '`@receiver openInSpace'.
	
	^ self openInSpace

]

{ #category : #'*Bloc-Deprecated' }
BlElement >> relocate: aPoint [
	
	self 
		deprecated:  'Use position:' 
		transformWith: '`@receiver relocate: `@point' -> '`@receiver position: `@point'.
	self position: aPoint
]

{ #category : #'*Bloc-Deprecated' }
BlElement >> removeChildNamed: aContainerName [

	self 
		deprecated:  'Use removeChildWithId: instead' 
		transformWith: '`@receiver removeChildNamed: `@statements1' -> '`@receiver removeChildWithId: `@statements1'.

	self removeChildWithId: aContainerName
]

{ #category : #'*Bloc-Deprecated' }
BlElement >> style [
	self
		deprecated: 'Please use #styles instead'
		transformWith: '`@receiver style' -> '`@receiver styles'.

	^ self styles
]

{ #category : #'*Bloc-Deprecated-Theme' }
BlElement >> theme [

	self deprecated: 'To be removed'.

	^ self userData
		at: #BlTheme
		ifAbsent: [ self hasParent
				ifTrue: [ self parent theme ]
				ifFalse: [ BlTheme default ] ]
]

{ #category : #'*Bloc-Deprecated-Theme' }
BlElement >> theme: aTheme [

	self deprecated: 'To be removed'.

	self userData at: #BlTheme put: aTheme.
	self properties
		addProperty:
			(BlThemeElementProperty new
				theme: aTheme;
				yourself)
]
