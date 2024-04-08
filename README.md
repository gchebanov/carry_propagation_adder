Carry propagation adders hardware implementations
=================================================

List
1. internal (`assign {cout, y} = a + b + cin;`)
2. Brent Kung ![brent_kung.png](brent_kung.png)
3. Lander Fischer ![ladner_fischer.png](ladner_fischer.png)
4. Koggle stone ![kogge_stone.png](kogge_stone.png)
5. Han Carlson ![han_carlson.png](han_carlson.png)

Results
=======

| name             | fmax         |
|------------------|--------------|
| rtl_bk32         | 1029700000   |
| rtl_bk64         | 720871000    |
| rtl_hc32         | 1029290000   |
| rtl_hc64         | 861524000    |
| rtl_internal32   | 926423000    |
| rtl_ks32         | 915605000    |
| rtl_ks64         | 839028000    |
| rtl_lf32         | 773214000    |
| rtl_lf64         | 649157000    |

