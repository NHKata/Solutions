
To run it in a REPL (using [stack][0]):

```
> stack setup
> stack ghci
```

and then

```
> printAll $ (convert :: Natural -> Roman) <$> [1, 2, 1000, 1500, 3853]
Roman "I"
Roman "II"
Roman "M"
Roman "MD"
Roman "MMMDCCCLIII"

> printAll $ (convert :: Roman -> Natural) <$> Roman <$> ["IV", "XXX", "DC", "CD", "MMMDCCCLIII"]
4    
30   
600  
400  
3853

> printAll $ (convert :: Roman -> Urnfield) <$> Roman <$> ["IV", "XXXIV", "L", "V"]
////
////\\\\\\
\\\\\\\\\\
\
```


 [0]: https://www.haskellstack.org/
 