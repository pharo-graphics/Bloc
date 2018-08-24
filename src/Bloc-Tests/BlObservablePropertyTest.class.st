Class {
	#name : #BlObservablePropertyTest,
	#superclass : #TestCase,
	#category : 'Bloc-Tests-Universe'
}

{ #category : #'as yet unclassified' }
BlObservablePropertyTest >> testBinding [
	|p1 p2|
	p1 := BlObjectProperty new.
	p2 := BlObjectProperty new.
	
	p1 bindOn: p2.
	p2 value: #test.
	
	self assert: p2 value = #test.
	self assert: p1 value = p2 value 
]

{ #category : #'as yet unclassified' }
BlObservablePropertyTest >> testBindingBidirectional [
	|p1 p2|
	p1 := BlObjectProperty new.
	p2 := BlObjectProperty new.
	
	p1 bindOn: p2 bidirectional:true.
	p2 value: #test.
	
	self assert: p2 value = #test.
	self assert: p1 value = p2 value .
	
	p1 value: #test2.
	
	self assert: p1 value = #test2.
	self assert: p2 value = p1 value .

]

{ #category : #'as yet unclassified' }
BlObservablePropertyTest >> testChangeListener [
	| p1 flag1 flag2 |
	p1 := BlObjectProperty new.
	flag1 := flag2 := false.
	p1 addChangeListener: (BlOnChangeListener do: [ flag1 := true ]).
	p1 onChangedDo: [ flag2 := true ].
	p1 value:#test.
	
	self assert: (flag1 and:flag2).
	
	p1 removeAllChangeListeners.
	flag1 := flag2 := false.
	p1 value:#test2.
	
	self assert: (flag1 not and:flag2 not).
]

{ #category : #'as yet unclassified' }
BlObservablePropertyTest >> testDelegate [
	|p1 p2|
	p1 := BlObjectProperty on: nil named: #myProperty default: Association new.
	p2 := BlDelegateProperty on: nil named: #key delegateTo: p1.
	
	p2 value: #test.
	
	self assert: p2 value = #test description:'p1''s value should be equal to #test'.
	self assert: p1 value key = #test description:'the association''s key should be equal to #test'
]
