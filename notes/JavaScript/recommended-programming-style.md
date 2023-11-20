### block
always using bracket after the cycle, judge or any other block.
also, the left bracket should be right after the statement in case of automatic semi-colon insertion causing some error.

like this: 
```js
return {
    key : value
};
```

### semi-colon
at the very beginning of first line of statement, add a semi-colon, which can avoid some error
happens when scripts get integrated through uglifier.

and although there is automatic semi-colon insertion, adding semi-colon by hand is still a good
habit, preventing you from making mistakes.

### switch...case
replace your switch...case block with object structure!

like this:
```js
// not recommended
function doAction(action) {
  switch (action) {
    case 'hack':
      return 'hack';
    case 'slash':
      return 'slash';
    case 'run':
      return 'run';
    default:
      throw new Error('Invalid action.');
  }
}
// recommended
function doAction(action) {
  var actions = {
    'hack': function () {
      return 'hack';
    },
    'slash': function () {
      return 'slash';
    },
    'run': function () {
      return 'run';
    }
  };

  if (typeof actions[action] !== 'function') {
    throw new Error('Invalid action.');
  }

  return actions[action]();
}
```
