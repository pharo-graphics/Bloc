accessing
subscriptions
	<return: #Set of: #AnnouncementSubscription>

	^ self announcer subscriptions protected: [ self announcer subscriptions subscriptions copy asArray ]