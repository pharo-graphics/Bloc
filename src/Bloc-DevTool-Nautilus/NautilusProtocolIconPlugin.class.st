"
I make nautilus protocol icon to be customizable
"
Class {
	#name : #NautilusProtocolIconPlugin,
	#superclass : #Object,
	#classInstVars : [
		'link'
	],
	#category : 'Bloc-DevTool-Nautilus'
}

{ #category : #protocols }
NautilusProtocolIconPlugin class >> apiIconFor: aString in: aValueHolder [
	<nautilusProtocolIcon: 10>
	
	(aString beginsWith: 'api')
		ifTrue: [ aValueHolder contents: (self iconNamed: #protocolPublicIcon) ]
]

{ #category : #icon }
NautilusProtocolIconPlugin class >> categoryIconFor: aString [
	<return: #Form>
	| thePragmas |
	
	thePragmas := Pragma
		allNamed: #nautilusProtocolIcon:
		from: self class
		to: Object
		sortedByArgument: 1.
		
	thePragmas do: [ :aPragma |
		| aValueHolder |
		aValueHolder := ValueHolder new.
		aPragma method
			valueWithReceiver: aPragma methodClass
			arguments: { aString . aValueHolder }.
		aValueHolder contents
			ifNotNil: [ ^ aValueHolder contents ] ].

	^ self iconNamed: #protocolNoneIcon
]

{ #category : #protocols }
NautilusProtocolIconPlugin class >> childrenIconFor: aString in: aValueHolder [
	<nautilusProtocolIcon: 10>
	
	(aString beginsWith: 'children')
		ifTrue: [ aValueHolder contents: ((Form extent: 16@16 depth: 32)
				copy: (2@2 extent: 16@16)
				from: 0@0
				in: (self iconNamed: #smallHierarchyBrowser)
				rule: Form over) ]
]

{ #category : #cleanup }
NautilusProtocolIconPlugin class >> cleanUp [
	super cleanUp.
	
	self uninstall
]

{ #category : #protocols }
NautilusProtocolIconPlugin class >> debugIconFor: aString in: aValueHolder [
	<nautilusProtocolIcon: 10>
	
	(aString beginsWith: 'debug')
		ifTrue: [ aValueHolder contents: (self iconNamed: #smallDebug) ]
]

{ #category : #protocols }
NautilusProtocolIconPlugin class >> geometryIconFor: aString in: aValueHolder [
	<nautilusProtocolIcon: 10>
	
	(aString beginsWith: 'geometry')
		ifTrue: [ aValueHolder contents:
			((Form extent: 16@16 depth: 32)
				copy: (2@2 extent: 16@16)
				from: 0@0
				in: (self iconNamed: #objects)
				rule: Form over) ]
]

{ #category : #protocols }
NautilusProtocolIconPlugin class >> hookIconFor: aString in: aValueHolder [
	<nautilusProtocolIcon: 10>
	
	(aString beginsWith: 'hook')
		ifTrue: [ aValueHolder contents: (self iconNamed: #glamorousInto) ]
]

{ #category : #initialization }
NautilusProtocolIconPlugin class >> initialize [
	super initialize.
	
	self install
]

{ #category : #installation }
NautilusProtocolIconPlugin class >> install [
	| aNode |
	<script: 'self install'>
	
	self uninstall.

	link := MetaLink new
		metaObject: [
			| aProtocolName |
			aProtocolName := thisContext sender arguments first.
			NautilusProtocolIconPlugin categoryIconFor: aProtocolName ];
		control: #instead;
		selector: #value.
		
	aNode := (CategoryWidget >> #categoryIconFor:) ast statements last value.
	aNode link: link
]

{ #category : #installation }
NautilusProtocolIconPlugin class >> uninstall [
	<script: 'self uninstall'>

	link ifNotNil: [ link uninstall ].
	link := nil
]

{ #category : #protocols }
NautilusProtocolIconPlugin class >> updateIconFor: aString in: aValueHolder [
	<nautilusProtocolIcon: 10>
	
	(aString beginsWith: 'update')
		ifTrue: [ aValueHolder contents: (self iconNamed: #smallUpdate) ]
]
