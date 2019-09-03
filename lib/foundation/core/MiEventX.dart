part of foundation;

class MiEventX {
  String $mType;
  dynamic $mData;

  MiEventX(this.$mType, this.$mData);

  String get type => $mType;

  dynamic get data {
    return $mData;
  }

  IEventDispatcher $mTarget;

  IEventDispatcher get target => $mTarget;

  $setTarget(IEventDispatcher value) {
    this.$mTarget = value;
  }
}
