api - adding / removing
removeAllSuchThat: aBlock
	"Remove all event handlers for which aBlock returns true.
	Return a collection of removed handlers"
	<return: #SequenceableCollection of: #BlBasicEventHandler>
	| toBeRemoved |

	toBeRemoved := #().
	self announcer subscriptions protected: [
		toBeRemoved := self announcer subscriptions subscriptions select: [ :aSubscription | aBlock value: aSubscription subscriber ].
		self announcer subscriptions subscriptions removeAllSuchThat: [ :aSubscription | aBlock value: aSubscription subscriber ] ].

	^ toBeRemoved asArray