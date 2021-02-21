#include <iostream>
#include <vector>
#include <cstdio>
#include <iterator>  // ostream_iterator
#include <algorithm> // copy, swap
using namespace std;

template <typename T>
ostream& operator<< (ostream& strm, const vector<T>& vec)
{
  strm << "[";
  if (!vec.empty()) {
    copy(vec.begin(), vec.end() - 1, ostream_iterator<T>(strm, ", "));
    strm << vec.back();
  }
  return strm << "]";
}

typedef vector<int> vint_t;

int xch(vint_t& a, int p, int q)
{
  static int n = 0;
  cout << a;
  printf(" (%d,%d)\n", p, q);
  swap(a[p], a[q]);
  return ++n;
}
int indexOf(const vint_t& a, int b, int e, int value)
{ /** [b, e) */
  for (int j = b; j < e; ++j) {
    if (a[j] == value) return j;
  }
  return -1;
}
int lastIndexOf(const vint_t& a, int b, int e, int value)
{
  --b; --e;
  for (int j = e; j > b; --j) {
    if (a[j] == value) return j;
  }
  return -1;
}
void sor3ing(vint_t& a)
{
  const int size = a.size();
  int p = -1;
  int q = size;
  int n = 0;

  while (++p < --q) {
    // position p,q over (3|2),(1|2) values
    while (a[p] == 1) {
      if (++p == size) goto spit;
    }
    while (a[q] == 3) {
      if (--q == -1) goto spit;
    }
    // consider all four variants
    if (a[p] == 3) {
      if (a[q] == 2) { // 3 .. 1 .. 2
                       // p    k    q
        int k = lastIndexOf(a, p + 1, q, 1);
        if (k != -1) n = xch(a, k, q);
      }
    } else { // a[p] == 2
      if (a[q] == 1) { // 2 .. 3 .. 1
                       // p    m    q
        int m = indexOf(a, p + 1, q, 3);
        if (m != -1) n = xch(a, p, m);
      } else { // 2 .. 1 .. 3 .. 2
               // p    k    m    q
        int k = lastIndexOf(a, p + 1, q, 1);
        if (k != -1) n = xch(a, p, k);

        int m = indexOf(a, p + 1, q, 3);
        if (m != -1) n = xch(a, m, q);

        if (k == -1 && m == -1) goto spit;
        continue; 
      }
    }
    n = xch(a, p, q);
  }
spit:
  cout << a << endl;
  printf("Total exchanges: %d\n", n);
}
vint_t getpos(int size)
{
  vint_t pos;
  for (int j = 0; j < size; ++j) {
    pos.push_back(j%10);
  }
  return pos;
}
int main()
{
  vint_t a{ 2, 3, 1, 2, 1, 2, 3, 1, 2, 2, 3, 1 };
  cout << getpos(a.size()) << " </positions>\n";
  sor3ing(a);
}
// log:
