/*23456701234567012345670123456701234567012345670123456701234567
 ..............................................
   Problem 4: Sorting a Three-Valued Sequence .
 ............................................................
   Sorting is one of the most frequently done computational .
 ............................................................
   tasks. Consider the special sorting problem, where the .
 ..........................................................
   records to be sorted have at most three different key .
 ...............................................................
   values. This happens for instance when we sort medalists of .
 ...............................................................
   a competition according to medal value, that is, gold .
 .........................................................
   medalists come first, followed by silver, and bronze .
 .............................................................
   medalists come last. In this task the possible key values .
 ..............................................................
   are the integers 1, 2 and 3. The required sorting order is .
 ..............................................................
   non-decreasing. Sorting has to be accomplished by a .
 ...........................................................
   sequence of exchange operations. An exchange operation, .
 ...........................................................
   defined by two position numbers p and q, exchanges the .
 ..............................................................
   elements in positions p and q. You are given a sequence of .
 ..............................................................
   key values. Write a program that computes the minimal . 
 ............................................................
   number of exchange operations that are necessary to make .
 ............................................................
   the sequence sorted. (Subtask A.) Moreover, construct a .
 ..............................................................
   sequence of exchange operations for the respective sorting .
 ..............................................................
   (Subtask B.) .
 .......................................................
   https://ioinformatics.org/files/ioi1996problem4.pdf . 
 .......................................................
 01234567012345670123456701234567012345670123456701234567012345*/
function sor3ing () {
    var a = [2, 3, 1, 2, 2, 1, 3, 2, 3, 2, 1];
    console.log(a);
    var p = -1;
    var q = a.length;
    var n = 0
    function xch(p, q) {
        n++;
        [a[p], a[q]] = [a[q], a[p]];
        console.log(p, q);
        console.log(a.join());
    }
    loop: while (++p < --q) {
        while (a[p] == 1) {
            if (++p == a.length) break loop;
        }        
        while (a[q] == 3) {
            if (--q == -1) break loop;
        }
        if (a[p] == 3) {
            if (a[q] == 2) { // 3 ... 1 ... 2
                             // p     k     q
                let k = a.slice(p + 1, q).lastIndexOf(1);
                if (k != -1) {
                    xch(p + 1 + k, q);
                }
            }
        } else { // a[p] == 2
            if (a[q] == 1) { // 2 ... 3 ... 1
                             // p     k     q
                let k = a.slice(p + 1, q).indexOf(3);
                if (k != -1) {
                    xch(p, p + 1 + k);
                }
            } else { // 2 ... 1 ... 3 ... 2
                     // p     k     m     q
                let k = a.slice(p + 1, q).lastIndexOf(1);
                if (k != -1) {
                    xch(p, p + 1 + k);
                }
                let m = a.slice(p + 1, q).indexOf(3);
                if (m != -1) {
                    xch(p + 1 + m, q);
                }
                if (k == -1 && m == -1) {
                    break; // let'Z Gou! (ZG!)
                }
                continue;
            }
        }
        xch(p, q);
    }
    console.log(`Number of exchanges: ${n}`);
}
sor3ing();
////////////////////////////////////////////////////////////////
// log:
