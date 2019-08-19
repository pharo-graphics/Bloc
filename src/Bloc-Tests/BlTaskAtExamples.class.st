Class {
	#name : #BlTaskAtExamples,
	#superclass : #Object,
	#category : #'Bloc-Tests-Examples'
}

{ #category : #tests }
BlTaskAtExamples >> checkQueueOrder [
	"Ensure that tasks are retrieved from the queue in chronological order"
	<gtExample>

	| queue now entries |

	queue := BlTaskAtQueue new.
	now := DateAndTime now.
	queue schedule: 1 at: now + 10 seconds.
	queue schedule: 5 at: now + 50 seconds.
	queue schedule: 3 at: now + 30 seconds.
	queue schedule: 7 at: now + 70 seconds.
	queue schedule: 2 at: now + 20 seconds.

	entries := OrderedCollection new.
	5 timesRepeat: [ entries add: queue next valuable ].

	self
		assert: entries asArray
		equals: #(1 2 3 5 7).

]
