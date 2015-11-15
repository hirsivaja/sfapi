package sfapi.commands {
    public interface Context {
        /**
         * Set context
         * @param context - Commands objects
         */
        function set context(context:Commands):void;

        /**
         * Get context
         */
        function get context():Commands;
    }
}