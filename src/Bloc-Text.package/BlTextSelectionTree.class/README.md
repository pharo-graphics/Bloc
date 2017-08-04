I represent an augmented search binary tree to store intervals  described in Cormen et al. (2009, Section 14.3: Interval trees, pp. 348–354)[1]

I do not allow overlapping intervals to be stored in the same tree. Before every insertions I find overlapping and neighbouring intervals, merge them and replace all merged intervals with a single one.

For example if tree contains the following intervals: [1,2] [5, 10] and user inserts a new one [3,4] then resulting tree will only consist of a single [1,10] interval.

Both insertions and deletion have logarithmic complexity O(logN) where N is current amount of intervals stored.

[1] Cormen, Thomas H.; Leiserson, Charles E.; Rivest, Ronald L.; Stein, Clifford (2009), Introduction to Algorithms (3rd ed.), MIT Press and McGraw-Hill, ISBN 978-0-262-03384-8