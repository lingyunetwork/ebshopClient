part of app;

class FromItem extends StatefulWidget {
  final String hintText;
  final String text;
  final bool isPassword;
  final double fontSize;
  final bool autofocus;
  final FontWeight fontWeight;
  final TextEditingController controller;
  final int maxChar;
  final List<TextInputFormatter> inputFormatters;

  FromItem(
      {Key key,
      this.hintText,
      this.text,
      this.isPassword:false,
      this.maxChar,
      this.controller,
      this.fontSize:20,
      this.autofocus:false,
      this.fontWeight:FontWeight.bold,
      this.inputFormatters})
      : super(key: key);

  _FromItemState createState() => _FromItemState();
}

class _FromItemState extends StateEvent<FromItem>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        inputFormatters: widget.inputFormatters,
        controller: widget.controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: widget.hintText,
            border: InputBorder.none,
            suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  widget.controller.clear();
                  this.invalidate();
                })),
        style: TextStyle(
          color: Colors.grey,
          fontSize: widget.fontSize,
          fontWeight: widget.fontWeight,
        ),
        maxLines: 1,
        obscureText: widget.isPassword,
        //maxLength: 11,
        maxLengthEnforced: true,
        autocorrect: false,
        autofocus: widget.autofocus,
        onChanged: (v) => this.invalidate(),
      ),
    );
  }
}
