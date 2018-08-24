Class {
	#name : #BlStyleRule,
	#superclass : #Object,
	#instVars : [
		'selectors',
		'declarations',
		'stylesheet',
		'transitions'
	],
	#category : 'Bloc-Style-CSS'
}

{ #category : #'adding/removing' }
BlStyleRule >> addTo: aStylesheet [
	self stylesheet: aStylesheet.
	aStylesheet rules add: self
]

{ #category : #accessing }
BlStyleRule >> declarations [
	^ declarations
]

{ #category : #accessing }
BlStyleRule >> declarations: aDeclarationList [
	aDeclarationList
		do: [ :d | 
			d rule: self.
			d addTo: self ]
]

{ #category : #'as yet unclassified' }
BlStyleRule >> declare: anAssoc [
	self declare: anAssoc important: false
]

{ #category : #'as yet unclassified' }
BlStyleRule >> declare: anAssoc important: aBoolean [
	self declarations
		add:
			(BlStylePropertyDeclaration new
				property: anAssoc key;
				value: anAssoc value asBlStyleValue;
				rule: self;
				important: aBoolean;
				yourself)
]

{ #category : #'as yet unclassified' }
BlStyleRule >> declareTransition: anAssoc [
	self transitions
		add:
			(BlStyleTransitionDeclaration new
				property: anAssoc key;
				valuesFromArray: anAssoc value;
				rule: self;
				yourself)
]

{ #category : #'initialize-release' }
BlStyleRule >> initialize [
	super initialize.
	selectors := SortedCollection sortBlock: [ :s1 :s2 | s1 specificity >= s2 specificity ].
	declarations := OrderedCollection new.
	transitions := OrderedCollection new
]

{ #category : #accessing }
BlStyleRule >> origin [
	^ stylesheet origin
]

{ #category : #accessing }
BlStyleRule >> selectors [
	^ selectors
]

{ #category : #accessing }
BlStyleRule >> selectors: anObject [
	selectors := anObject.
	selectors do: [ :s | s rule: self ]
]

{ #category : #accessing }
BlStyleRule >> stylesheet [
	^ stylesheet
]

{ #category : #accessing }
BlStyleRule >> stylesheet: anObject [
	stylesheet := anObject
]

{ #category : #accessing }
BlStyleRule >> transitions [
	^ transitions
]

{ #category : #accessing }
BlStyleRule >> transitions: aTransitionList [
	aTransitionList
		do: [ :d | 
			d rule: self.
			d addTo: self ]
]
