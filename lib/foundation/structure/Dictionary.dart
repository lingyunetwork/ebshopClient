part of foundation;
///Dictionary其实就是含有两个对位关系数组的而已
///接口尽量符合C#,因为我要靠一些类过来方便
class Dictionary<K, V> {
  List<K> _keys = new List<K>();
  List<V> _values = new List<V>();
  List<V> get values => _values;

  add(K key, V value) {
    var i = _keys.indexOf(key);
    if (i == -1) {
      _keys.add(key);
      _values.add(value);
    } else {
      this.values[i] = value;
    }
  }

  bool containsKey(K key) {
    return _keys.indexOf(key) != -1;
  }

  bool containsValue(V value) {
    return this.values.indexOf(value) != -1;
  }

  bool remove(K key) {
    var i = _keys.indexOf(key);
    if (i != -1) {
      _keys.removeAt(i);
      _values.removeAt(i);
      return true;
    }
    return false;
  }

  V get(K key) {
    var i = _keys.indexOf(key);
    if (i == -1) {
      return null;
    }
    return this.values[i];
  }

  num get count {
    return _keys.length;
  }
}

/**
 * 两个对像组合当Key的情况,应该仅仅只有js里面的函数会丢失this所以才需要的吧
 * 所以没有必要 更多Key的组合
 */
class TwoKeyDictionary<K, K1, V> {
  List<K> keys = new List<K>();
  List<K1> key1s = new List<K1>();
  List<V> values = new List<V>();

  add(K key, K1 key1, V value) {
    var i = this.keys.indexOf(key);

    if (i == -1 || this.key1s[i] != key1) {
      this.keys.add(key);
      this.key1s.add(key1);
      this.values.add(value);
      return;
    }
    this.values[i] = value;
  }

  bool containsKey(K key, K1 key1) {
    var i = this.keys.indexOf(key);
    if (i == -1) {
      return false;
    }
    return this.key1s[i] != key1;
  }

  bool containsValue(V value) {
    return values.indexOf(value) != -1;
  }

  bool remove(K key, K1 key1) {
    var i = this.keys.indexOf(key);
    if (i == -1) {
      return false;
    }
    if (this.key1s[i] != key1) {
      return false;
    }

    this.keys.removeAt(i);
    this.key1s.removeAt(i);
    this.values.removeAt(i);
    return true;
  }

  V get(K key, K1 key1) {
    var i = this.keys.indexOf(key);
    if (i == -1) {
      return null;
    }

    if (this.key1s[i] != key1) {
      return null;
    }

    return this.values[i];
  }

  dynamic getIndex(num i) {
    //return { k: this.keys[i], k1: this.key1s[i], v: this.values[i] };
  }

  num get count {
    return keys.length;
  }
}
