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
**some** *time*. **Fortunately** *there* are **some** *reasons* to
*be* ***greedy!***

```JavaScript
          1         2         3         4         5         6
0123456789012345678901234567890123456789012345678901234567890123
================================================================
We can start with p and q at both ends and make sure that a[p]
and a[q] are not 1 and 3 respectively, and all elements outside
[p,q] range are in correct postitions, than we have 4 variants:
..3..1.. Considering all those variants we can make the minimum
..3..2.. swaps using the fact that if we change the last 1 or
..2..1.. first 3 with 2 the number of minimum exchanges can only
..2..2.. decrease, but I don't think I can give you a prove:)
================================================================
Here is an example from the [cpp] program:
[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 1] </positions>
[2, 3, 1, 2, 1, 2, 3, 1, 2, 2, 3, 1] (0,1)
[3, 2, 1, 2, 1, 2, 3, 1, 2, 2, 3, 1] (0,11)
[1, 2, 1, 2, 1, 2, 3, 1, 2, 2, 3, 3] (1,7)
[1, 1, 1, 2, 1, 2, 3, 2, 2, 2, 3, 3] (6,9)
[1, 1, 1, 2, 1, 2, 2, 2, 2, 3, 3, 3] (3,4)
[1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3]
Total exchanges: 5
```
