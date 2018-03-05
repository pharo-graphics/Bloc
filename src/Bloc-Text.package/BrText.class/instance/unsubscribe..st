text - notifying
unsubscribe: anObject
	"Unsubscribe all subscriptions of anObject from the receiver"
	self announcerDo: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]