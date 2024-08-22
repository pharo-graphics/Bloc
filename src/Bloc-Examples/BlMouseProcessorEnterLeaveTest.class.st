Class {
	#name : #BlMouseProcessorEnterLeaveTest,
	#superclass : #TestCase,
	#category : #'Bloc-Examples-Event-Scripter'
}

{ #category : #running }
BlMouseProcessorEnterLeaveTest >> newScripterElement [

	^ BlEventCountingElement new
		  size: 100 @ 75;
		  position: 50 @ 50;
		  yourself
]

{ #category : #tests }
BlMouseProcessorEnterLeaveTest >> testMouseEnter [

	| aScripter |
	aScripter := BlDevScripter new.
	aScripter element: self newScripterElement.

	aScripter substeps: 'Mouse Enter' do: [ :aStep |
		aStep mouseMove by: 30 @ 30.

		aStep mouseMove by: 70 @ 60.

		aStep check
			label: 'Check mouse enter fired';
			value: [ :anElement | anElement mouseEnterCount ] equals: 1;
			onSelf.

		aStep check
			label: 'Check mouse over fired';
			value: [ :anElement | anElement mouseOverCount ] equals: 1;
			onSelf.

		aStep check
			label: 'Check mouse move fired';
			value: [ :anElement | anElement mouseMoveCount ] equals: 1;
			onSelf.

		aStep check
			label: 'Check entered targets';
			value: [ :aMouseProcessor | aMouseProcessor enteredTargets ]
			equals: {
					aScripter element.
					aScripter root };
			onMouseProcessor ].
	aScripter syncContinue.

	^ aScripter
]

{ #category : #tests }
BlMouseProcessorEnterLeaveTest >> testMouseLeave [

	| aScripter |
	aScripter := self testMouseEnter.

	aScripter substeps: 'Mouse Leave' do: [ :aStep |
		aStep mouseMove by: 100 @ 20.

		aStep check
			label: 'Check mouse leave fired';
			value: [ :anElement | anElement mouseLeaveCount ] equals: 1;
			onSelf.

		aStep check
			label: 'Check mouse out fired';
			value: [ :anElement | anElement mouseOutCount ] equals: 1;
			onSelf.

		aStep check
			label: 'Check mouse move not fired';
			value: [ :anElement | anElement mouseMoveCount ] equals: 1;
			onSelf.

		aStep check
			label: 'Check entered targets';
			value: [ :aMouseProcessor | aMouseProcessor enteredTargets ]
			equals: { aScripter root };
			onMouseProcessor ].

	^ aScripter syncContinue
]

{ #category : #tests }
BlMouseProcessorEnterLeaveTest >> testMouseLeaveDueToRemovalFromScene [

	| aScripter |
	aScripter := self testMouseEnter.

	aScripter substeps: 'Remove from scene graph' do: [ :aStep |
		aStep do
			block: [ :anElement | anElement removeFromParent ];
			onSelf ].

	aScripter
		substeps: 'Pulse one time to generate mouse leave events'
		do: [ :aStep |
			aStep do
				block: [ :theScripter | theScripter pulse ];
				onScripter ].

	aScripter substeps: 'Check that events are fired' do: [ :aStep |
		aStep check
			label: 'Check mouse leave fired';
			value: [ :anElement | anElement mouseLeaveCount ] equals: 1;
			onSelf.

		aStep check
			label: 'Check mouse out fired';
			value: [ :anElement | anElement mouseOutCount ] equals: 1;
			onSelf.

		aStep check
			label: 'Check mouse move not fired';
			value: [ :anElement | anElement mouseMoveCount ] equals: 1;
			onSelf.

		aStep check
			label: 'Check entered targets';
			value: [ :aMouseProcessor | aMouseProcessor enteredTargets ]
			equals: { aScripter root };
			onMouseProcessor ].

	^ aScripter syncContinue
]
