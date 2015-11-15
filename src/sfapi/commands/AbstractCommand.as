package sfapi.commands {
    import sfapi.core.AppTreeParser;

    public class AbstractCommand implements Context {
        // Application Tree Parser
        private var _appTreeParser:AppTreeParser;
        // commands object to share across sfapi commands.
        // Used for supporting command which involved in multiple Commands objects.
        // For example, set date within DataGrid, which involved two commands: DateCommands and DataGridCommands.
        private var _context:Commands;

        public function AbstractCommand(aptObj:AppTreeParser, contextObj:Commands) {
            _appTreeParser = aptObj;
            _context = contextObj;
        }

        /**
         * Set context
         * @param context
         */
        public function set context(context:Commands):void {
            this._context = context;
        }

        /**
         * Get context
         * @param context
         */
        public function get context():Commands {
            return _context;
        }

        public function get appTreeParser():AppTreeParser {
            return _appTreeParser;
        }

        public function set appTreeParser(aptObj:AppTreeParser):void {
            _appTreeParser = aptObj;
        }
    }
}