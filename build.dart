import 'package:polymer/builder.dart';
        
main(args) {
  build(entryPoints: ['src/web/index.html'],
        options: parseOptions(args));
}
