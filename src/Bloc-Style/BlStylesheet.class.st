Class {
	#name : #BlStylesheet,
	#superclass : #Object,
	#instVars : [
		'name',
		'file',
		'rules',
		'medias',
		'origin'
	],
	#category : 'Bloc-Style-CSS'
}

{ #category : #'as yet unclassified' }
BlStylesheet class >> origin: anOrigin [
	^ self new
		origin: anOrigin;
		yourself
]

{ #category : #comparing }
BlStylesheet >> <= aStylesheet [
	^ self origin <= aStylesheet origin
]

{ #category : #comparing }
BlStylesheet >> >= aStylesheet [
	^ self origin >= aStylesheet origin
]

{ #category : #accessing }
BlStylesheet >> file [
	^ file
]

{ #category : #accessing }
BlStylesheet >> file: anObject [
	file := anObject
]

{ #category : #'as yet unclassified' }
BlStylesheet >> for: aSelectorString style: aBlock [
	| theSelectors theRule |
	theSelectors := BlStylesheetLoader parseSelectors: aSelectorString.
	theRule := BlStyleRule new.
	theRule
		selectors: theSelectors;
		stylesheet: self.
	aBlock value: theRule.
	self rules add: theRule
]

{ #category : #'initialize-release' }
BlStylesheet >> initialize [
	super initialize.
	rules := OrderedCollection new.
	medias := OrderedCollection new.
	origin := BlStyleOrigin USER
]

{ #category : #'as yet unclassified' }
BlStylesheet >> matchingMediaRulesFor: aStyleable [
	| matchedRules |
	matchedRules := SortedCollection sortBlock: [ :r1 :r2 | r1 specificity <= r2 specificity ].
	self medias do: [ :m |  m rules do: [ :r | 
					r selectors
						detect: [ :s | s matchesStyleable: aStyleable ]
						ifFound: [ :s |  matchedRules add:
									(BlMatchedRule new
										selector: s;
										declarations: r declarations;
										transitions: r transitions;
										conditions: m conditions;
										yourself) ] ] ].
	^ matchedRules
]

{ #category : #'as yet unclassified' }
BlStylesheet >> matchingRulesFor: aStyleable [
	| matchedRules |
	matchedRules := SortedCollection sortBlock: [ :r1 :r2 | r1 specificity <= r2 specificity ].
	self rules do: [ :r |  r selectors
				select: [ :s | s matchesStyleable: aStyleable ]
				thenDo: [ :s |  matchedRules add:
							(BlMatchedRule new
								selector: s;
								declarations: r declarations;
								transitions: r transitions;
								yourself) ] ].
	matchedRules addAll: (self matchingMediaRulesFor: aStyleable).
	^ matchedRules
]

{ #category : #accessing }
BlStylesheet >> medias [
	^ medias
]

{ #category : #accessing }
BlStylesheet >> medias: aCollection [
	aCollection
		do: [ :r | 
			r stylesheet: self.
			self medias add: r ]
]

{ #category : #accessing }
BlStylesheet >> name [
	^ name
]

{ #category : #accessing }
BlStylesheet >> name: anObject [
	name := anObject
]

{ #category : #accessing }
BlStylesheet >> origin [
	^ origin
]

{ #category : #accessing }
BlStylesheet >> origin: anObject [
	origin := anObject
]

{ #category : #accessing }
BlStylesheet >> rules [
	^ rules
]

{ #category : #accessing }
BlStylesheet >> rules: aCollection [
	aCollection
		do: [ :r | 
			r stylesheet: self.
			self rules add: r ]
]
