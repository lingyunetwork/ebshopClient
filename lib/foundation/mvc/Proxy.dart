part of foundation;
abstract class Proxy extends AbstractMVHost with IProxy {
  load() {
    //todo;
    this.$isReady = true;
    this.dispatchReayHandle();
  }
}
