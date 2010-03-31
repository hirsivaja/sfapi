
function doFireFlexClick(id, target, value) {
	alert("gotcha");
    var newEvt = document.createEventObject();
    document.all(objID).fireEvent("flexClick", newEvt);
}

/*
Recorder.decorateEventHandler(
    'flexClick',
    function (handler) {
        return function (event) {
            this.record('flexClick', 'arg1', 'arg2');
            handler.call( this, event );
        };
    },
    { capture : true }
);
*/