
import sys.FileSystem;
import sys.io.Inotify;

class App {

	static function main() {

		if( Sys.systemName() != 'Linux' ) {
			Sys.println( 'Inotify is only available on linux' );
			Sys.exit(1);
		}

		var path = Sys.args()[0];
		if( path == null ) {
			Sys.println( 'missing watch path argument' );
			Sys.exit(1);
		}
		if( !FileSystem.exists( path ) ) {
			Sys.println( 'watch path not found [$path]' );
			Sys.exit(1);
		}

		var inotify = new Inotify();
		var mask = MODIFY;
		var wd = inotify.addWatch( path, mask );
		while( true ) {
			var events = inotify.read();
			for( e in events ) {
				Sys.println( e );
			}
		}
		inotify.removeWatch( wd );
		inotify.close();
	}

}
