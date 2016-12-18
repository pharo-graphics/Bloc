I am an interpolator where the rate of change starts out quickly and and then decelerates.

I am configurable using "factor" - a degree to which the animation should be eased. Setting factor to 1.0f produces an upside-down y=x^2 parabola. Increasing factor above 1.0f makes exaggerates the ease-out effect (i.e., it starts even faster and ends evens slower).

My formula is:
	f(x) = 1 - (1 - x)^n, where n = 2* factor

I meant to be immutable, therefore factor can be only set using factory method #factor: on my class side