if ("undefined" == typeof (Extdev)) {
	var Extdev = {};
}
Components.utils.import("chrome://extensiondev/content/loadsaveutils.jsm",Extdev);
Components.utils.import("resource://gre/modules/Services.jsm");
Extdev.XULEdit = {
	old: '',
	timeout: -1,
	xwin: null,
	newwin: false,
	inwindow: false,
	cmdstrip : null,
	cmdopen : null,
	cmdload : null,
	cmdsave : null,
	textarea : null,
	init : function() {
		// for some reason onload gets called when the browser refreshes???
		if (Extdev.XULEdit.xwin)  {
			return;	
		}
		Extdev.XULEdit.cmdopen = document.getElementById("cmdExtDevOpen");
		Extdev.XULEdit.cmdsave = document.getElementById("cmdExtDevSave");
		Extdev.XULEdit.cmdload = document.getElementById("cmdExtDevLoad")
		Extdev.XULEdit.cmdstrip = document.getElementById("cmdExtDevStrip")
		Extdev.XULEdit.textarea = document.getElementById("ta");
		// read startup XUL from a file
		try {
			Extdev.LSUtils.loadFileFromPrefToTextbox("extensions.extensiondev.xuledit.startup", Extdev.XULEdit.textarea);
		} catch (e) {
			// the pref may not exist
			dump(e + '\n');
		}
		Extdev.XULEdit.update();
		Extdev.XULEdit.textarea.select();
		Extdev.XULEdit.cmdopen.addEventListener("command",Extdev.XULEdit.openwin,false);
		Extdev.XULEdit.cmdsave.addEventListener("command",Extdev.XULEdit.save,false);
		Extdev.XULEdit.cmdload.addEventListener("command",Extdev.XULEdit.load,false);
		Extdev.XULEdit.cmdstrip.addEventListener("command",Extdev.XULEdit.stripentities,false);
	},
	enableButton: function() {
		Extdev.XULEdit.toggleBrowser(true);
		Extdev.XULEdit.xwin.removeEventListener("close", Extdev.XULEdit.enableButton);
	},
	openwin: function() {
		Extdev.XULEdit.toggleBrowser(false);
		Extdev.XULEdit.xwin = window.openDialog('about:blank', 'xulwin', 
		'chrome,all=no,resizable=yes,width='+window.screen.width * 0.3+',height='+window.screen.height * 0.3+',centerscreen');
		Extdev.XULEdit.xwin.addEventListener("close", Extdev.XULEdit.enableButton, false);
		Extdev.XULEdit.newwin = true;
		Extdev.XULEdit.inwindow = true;
		Extdev.XULEdit.update();
	},
	toggleBrowser: function(show) {
		document.getElementById("split").collapsed = !show;
		document.getElementById("content").collapsed = !show;
		show ? Extdev.XULEdit.cmdopen.removeAttribute("disabled") : Extdev.XULEdit.cmdopen.setAttribute("disabled", "true");
	},
	update : function() {
		var textarea = document.getElementById("ta");
		// either this is the first time, or
		// they closed the window
		if (Extdev.XULEdit.xwin == null || Extdev.XULEdit.xwin.document == null) {
			Extdev.XULEdit.toggleBrowser(true);
			Extdev.XULEdit.xwin = document.getElementById("content").contentWindow;
			Extdev.XULEdit.newwin = true;
			Extdev.XULEdit.inwindow = false;
		}
		if (Extdev.XULEdit.old != textarea.value || Extdev.XULEdit.newwin) {
			Extdev.XULEdit.old = textarea.value;
			Extdev.XULEdit.newwin = false;
			Extdev.XULEdit.xwin.document.location = "data:application/vnd.mozilla.xul+xml," + encodeURIComponent(Extdev.XULEdit.old);
		}
		Extdev.XULEdit.timeout = window.setTimeout(Extdev.XULEdit.update, 500);
	},
	resetTimeout : function() {
		if (Extdev.XULEdit.timeout != -1)
		window.clearTimeout(Extdev.XULEdit.timeout);
		Extdev.XULEdit.timeout = window.setTimeout(Extdev.XULEdit.update, 500);
	},
	save : function() {
		Extdev.LSUtils.saveFileFromTextbox(window, Extdev.XULEdit.textarea, "xul");
	},
	load : function() {
		Extdev.LSUtils.loadFileToTextbox(window, Extdev.XULEdit.textarea, "xul");
	},
	stripentities : function(){
		Extdev.XULEdit.textarea.value = Extdev.XULEdit.textarea.value.replaceAll("&","").replaceAll(";",""); 
	},
	cleanup : function(){
		Extdev.XULEdit.cmdstrip.removeEventListener("command",Extdev.XULEdit.stripentities);
		Extdev.XULEdit.cmdload.removeEventListener("command",Extdev.XULEdit.load);
		Extdev.XULEdit.cmdsave.removeEventListener("command",Extdev.XULEdit.save);
		Extdev.XULEdit.cmdopen.removeEventListener("command",Extdev.XULEdit.openwin);
	}
}
window.addEventListener("load", Extdev.XULEdit.init, false);
window.addEventListener("unload", Extdev.XULEdit.cleanup, false);