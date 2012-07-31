var Template = function(input) {
    this._text = input["source"];
};




Template.prototype = {
    render: function(variables) {
    	var template = this._text;
    	var keys = '';
    	for ( keys in variables ) {
    		var str = variables[keys];
    		var escapedStr = str.replace(/<|>|&|'|"|\s/g, function(s){
  			 	var map = {"<":"&lt;", ">":"&gt;", "&":"&amp;", "'":"&#39;", "\"":"&quot;", " ":"&nbsp;"};
  			 	return map[s];
  			});
			variables[keys] = escapedStr;
		}
    	var html = template.replace(/{%\s(\w+)\s%}/g, function(m, key) {
    		var text = variables[key] || '';
    		return text;
    	});
    	return html;
    }
};

