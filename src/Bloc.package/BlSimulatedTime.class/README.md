I am a simulated time that must be progressed manually by setting ===#date:=== directly or by advancing the clock by a duration.

[[[
	| aTime |
	aTime := BlTime simulated.
	aTime date: (DateAndTime year: 2018 month: 3 day: 31).
	aTime wait: 2 seconds. "progress clock by 2 seconds"
	aTime now
]]]