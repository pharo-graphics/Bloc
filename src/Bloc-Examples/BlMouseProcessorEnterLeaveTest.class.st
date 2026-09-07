Class {
	#name : #BlMouseProcessorEnterLeaveTest,
	#superclass : #TestCase,
	#instVars : [
		'scripter'
	],
	#category : #'Bloc-Examples-EventHandling'
}

{ #category : #running }
BlMouseProcessorEnterLeaveTest >> newScripterElement [

	^ BlEventCountingElement new
		  extent: 100 @ 75;
		  position: 50 @ 50;
		  yourself
]

{ #category : #running }
BlMouseProcessorEnterLeaveTest >> setUp [

	super setUp.
	scripter := BlDevScripter new.
	scripter element: self newScripterElement
]

{ #category : #running }
BlMouseProcessorEnterLeaveTest >> tearDown [

	scripter close.
	super tearDown
]

{ #category : #tests }
BlMouseProcessorEnterLeaveTest >> testMouseEnter [

	scripter substeps: 'Mouse Enter' do: [ :aStep |
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
					scripter element.
					scripter root };
			onMouseProcessor ].
	scripter syncContinue
]

{ #category : #tests }
BlMouseProcessorEnterLeaveTest >> testMouseLeave [

	self testMouseEnter.

	scripter substeps: 'Mouse Leave' do: [ :aStep |
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
			equals: { scripter root };
			onMouseProcessor ].

	scripter syncContinue
]

{ #category : #tests }
BlMouseProcessorEnterLeaveTest >> testMouseLeaveDueToRemovalFromScene [

	self testMouseEnter.

	scripter substeps: 'Remove from scene graph' do: [ :aStep |
		aStep do
			block: [ :anElement | anElement removeFromParent ];
			onSelf ].

	scripter
		substeps: 'Wait for pending work to generate mouse leave events'
		do: [ :aStep |
			aStep do
				block: [ :theScripter | theScripter settle ];
				onScripter ].

	scripter substeps: 'Check that events are fired' do: [ :aStep |
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
			equals: { scripter root };
			onMouseProcessor ].

	scripter syncContinue
]
