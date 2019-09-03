part of app;

class SliverPersistentHeaderDelegateEx extends SliverPersistentHeaderDelegate {
  final Widget _ui;

   double maxHeight;
   double minHeight;

  SliverPersistentHeaderDelegateEx(this._ui);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: _ui,
      color: Colors.white,
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}