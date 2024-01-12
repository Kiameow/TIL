## 高阶函数

高阶函数的特征表现为——接受函数作为参数传入，或返回新的函数，或两者都具备。

## js数组对象的高阶函数

js中自带几种非常有用的与数组相关的高阶函数，它们的形式通常表现为`array.method(function)`，下面将介绍三种。

### filter

method 即为 filter，它将会对数组中的每个元素应用`function`，并判断`function`的返回值是否为真，如果为真，就写入新的数组中。最终返回这个新的数组，不会对原数组造成影响。

它的内部实现可以表现为：

```js
function filter(array, test) {
  let passed = [];
  for (let element of array) {
    if (test(element)) {
      passed.push(element);
    }
  }
  return passed;
}
```

实际调用： `console.log(arr.filter(ele => ele > 10))`

输出一个数组，其中包含arr中大于10的数组元素

### map

method 即为 map， 它将会对数组中的每个元素应用`function`，并将返回值直接写入新的数组中。最终返回这个新的数组，不会对原数组造成影响。

它的内部实现可以表现为：

```
function map(array, transform) {
  let mapped = [];
  for (let element of array) {
    mapped.push(transform(element));
  }
  return mapped;
}
```

实际调用：`console.log(arr.map(ele => ele+10))`

如果arr为[10,11,12]，则输出一个数组[20,21,22]。

### reduce

reduce的语法比较特殊，也是三个高阶函数中比较难理解的，它的语法形式为`arr.reduce((accumulator,currentValue) => acumulator+currentValue, initialValue )`

它的内部具体实现请参照 [官方文档](https://262.ecma-international.org/5.1/#sec-15.4.1)

这里贴一个简单的实现，方便理解：

```js
Array.prototype.myReducer = function(callback, initvalue) {
    var len = this.length 
    var pre = initvalue
    var i = 0
    if(pre == undefined) {
        pre = this[0];
        i = 1
    } 
    for(i; i < len; i++) {
        pre = callback(pre, this[i], i, this)
    }
    return pre 
}
// 掘金 - 落魄的开发
```

可以看到，initialValue是可选的，当不被提供时，accumulator会被初始化为第一个元素的值(如果数组中没有元素，也不提供intialValue的话就会报错)

实际调用：

```js
[1,2,3,4].reduce((sum, ele) => {return sum + ele}); // 10
[1,2,3,4].reduce((sum, ele) => {return sum + ele}, 0); // 10
```

记住，内部函数的返回值会作为accumulator新的值。

再看下面一个例子：

```js
 const script = {
  name: "Coptic",
  ranges: [[994, 1008], [11392, 11508], [11513, 11520]],
  direction: "ltr",
  year: -200,
  living: false,
  link: "https://en.wikipedia.org/wiki/Coptic_alphabet"
}
  function characterOf(script) {
    return script.ranges.reduce((acc, ele) => {
      return acc += ele[1]-ele[0];
    },0);
  }
  
  console.log(characterOf(script)); // 137
```

这里的情况就比较特殊，虽然数组不为空，但此时一定需要提供初始值，否则`acc`会被初始化为一个数组对象（`[994,1008]`），这样累加的结果就会出错，为NaN。
