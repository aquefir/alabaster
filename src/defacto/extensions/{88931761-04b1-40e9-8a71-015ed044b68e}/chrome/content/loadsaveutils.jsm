var EXPORTED_SYMBOLS=["LSUtils","Cc","Ci","Cu"];
if ("undefined" == typeof (Extdev)) {
	var Extdev = {};
}
const {classes: Cc, interfaces: Ci, utils: Cu} = Components;
Cu.import("resource://gre/modules/Services.jsm");
LSUtils = {
	fp : null,
	setFilters : function(fp, filter){
		switch(filter) {
			case "javascript":
    			fp.appendFilter("JavaScript files", "*.js");
			break;
			case "xul":
				fp.appendFilters(Ci.nsIFilePicker.filterXUL);
			break;
			case "xml":
				fp.appendFilters(Ci.nsIFilePicker.filterXML);
			break;
			case "html":
				fp.appendFilters(Ci.nsIFilePicker.filterHTML);
			break;
		}
		fp.appendFilters(Ci.nsIFilePicker.filterAll);
	},
	initFP : function(filter){
		LSUtils.fp = Cc["@mozilla.org/filepicker;1"].createInstance(Ci.nsIFilePicker);
		LSUtils.setFilters(LSUtils.fp, filter);
	},
	readEntireFile : function(file){
		var data = '';
		var fstream = Cc["@mozilla.org/network/file-input-stream;1"].createInstance(Ci.nsIFileInputStream);
		fstream.init(file, -1, 0, 0);
		var charset = "UTF-8"; // sux
		const replacementChar = Ci.nsIConverterInputStream.DEFAULT_REPLACEMENT_CHARACTER;
		var is = Cc["@mozilla.org/intl/converter-input-stream;1"].createInstance(Ci.nsIConverterInputStream);
		is.init(fstream, charset, 1024, replacementChar);
		var str = {};
		while (is.readString(4096, str) != 0) {
			data += str.value;
		}
		is.close();
 		return data;
	},
	writeFile : function(file, text){
		var ostream = Cc["@mozilla.org/network/file-output-stream;1"].createInstance(Ci.nsIFileOutputStream);
		ostream.init(file, 0x02 | 0x08 | 0x20, 0664, 0);
		var charset = "UTF-8"; // sux
		var os = Cc["@mozilla.org/intl/converter-output-stream;1"].createInstance(Ci.nsIConverterOutputStream);
		os.init(ostream, charset, 4096, 0x0000);
		os.writeString(text);
		os.close();
	},
	loadFileToTextbox : function(win, textbox, filter){
		if(!LSUtils.fp) {
			LSUtils.initFP(filter);
		}
		LSUtils.fp.init(win, "Select a File", Ci.nsIFilePicker.modeOpen);
		var res = LSUtils.fp.show();
		if(res == Ci.nsIFilePicker.returnOK) {
			textbox.value = LSUtils.readEntireFile(LSUtils.fp.file);
		}
	},
	saveFileFromTextbox : function(win, textbox, filter){
		if(!LSUtils.fp){
			LSUtils.initFP(filter);
		}
		LSUtils.fp.init(win, "Save As", Ci.nsIFilePicker.modeSave);
		var res = LSUtils.fp.show();
		if(res == Ci.nsIFilePicker.returnOK || res == Ci.nsIFilePicker.returnReplace) {
			LSUtils.writeFile(LSUtils.fp.file, textbox.value);
		}
	},
	loadFileFromPrefToTextbox : function(aPrefName, textbox) {
		var file = Services.prefs.getComplexValue(aPrefName, Ci.nsILocalFile);
		textbox.value = LSUtils.readEntireFile(file);
	},
	browseForPrefFile : function(win, prefbutton, filter){
		if(!LSUtils.fp){
			LSUtils.initFP(filter);
		} else {
			LSUtils.setFilters(LSUtils.fp, filter);
		}
		var pref = win.document.getElementById(prefbutton.getAttribute('preference'));
		if(pref.value){
			LSUtils.fp.displayDirectory = pref.value.parent;
		}
		LSUtils.fp.init(win, "Select File", Ci.nsIFilePicker.modeOpen);
		var res = LSUtils.fp.show();
		if(res == Ci.nsIFilePicker.returnOK) {
			if(LSUtils.fp.file instanceof Ci.nsILocalFile) {
				pref.value = LSUtils.fp.file;
			}
		}
	}
}