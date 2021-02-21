## sor3ing
{ Yeeh } , [ B ] ; ( b o o m ) ! < Ok > : **This** is *a* ***nice***
problem **I** *think*, {it} ***has*** *a* **little** *mathematics*.
**The** text *and* ***the*** *link* can *be* found **in** 
< ***sor3ing.js*** >. ***We*** have **an** *array* which ``lmnts`` 
can **have** *only* ***3*** possible *values*, **for** example:
```JavaScript
var a = [2, 2, 1, 3, 3, 1, 1, 2];
```
***Our*** *task* is **to** *sort* it ***with*** *minimum* swaps.

</ **Here** > *again* ***Combinatorics*** and **bfs** *are* **not** an
*option*, cos ***THE*** *execution* **time** ``will`` (**explode** ) at
**some** *point*. **Fortunately** *there* are **some** *reasons* to
*be* ***greedy!***

```JavaScript
          1         2         3         4         5         6
0123456789012345678901234567890123456789012345678901234567890123
================================================================
[Ok] if we look at THE last 1, there are no elements less than
it with bigger positions, and let's denote with n the number of
lmnts greater than it below. If we replace it with 2 than again
there will be no lmnts less than it above, and the number of
lmnts greater than it: n' will decreace, n' <= n; So the number 
of minimum exchanges needed to sort the sequence will decreace 
or not change. The same reasons apply if we look at the first 
occurrences of 3.
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
================================================================
````````
