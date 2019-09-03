part of foundation;

class DebugX {
    static warn(String message, [List<String> args]) {
        print(message);
    }
    static log(String message, [List<String> args]) {
       print(message);
    }
    static error(String message, [List<String> args]) {

      print(message);
       
    }

}