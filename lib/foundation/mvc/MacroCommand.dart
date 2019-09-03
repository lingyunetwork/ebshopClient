part of foundation;
class MacroCommand implements ICommand {
  List<ClassT<ICommand>> subCommands;

  addSubCommand<T extends ICommand>(ClassT<T> commandClassRef) {
    this.subCommands.add(commandClassRef);
  }

  execute(EventX e) {
    var subCommands = this.subCommands;
    var len = this.subCommands.length;
    for (int i = 0; i < len; i++) {
      var commandClassRef = subCommands[i];
      var commandInstance = commandClassRef();
      commandInstance.execute(e);
    }
    this.subCommands.clear();
  }
}
