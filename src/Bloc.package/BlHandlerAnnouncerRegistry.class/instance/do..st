api - enumerating
do: aBlock
	"Evaluate aBlock with each registered handler as the argument"

	self announcer subscriptions protected: [
		self announcer subscriptions subscriptions do: [ :aSubscription | aBlock value: aSubscription subscriber ] ]