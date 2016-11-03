pulse
stop
	self isRunning ifTrue:[self stopChildren].
	super stop