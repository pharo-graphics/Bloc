instance creation - ticks
minuteTicks
	<gtExample>

	^ 60 timesCollect: [ :anHour | self minuteTickAt: anHour ]