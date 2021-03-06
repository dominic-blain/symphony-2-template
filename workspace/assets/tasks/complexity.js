'use strict';

module.exports = function jshint (grunt) {
	grunt.gruntLoad(grunt.task.current.name);
	grunt.config.merge({
		complexity: {
			generic: {
				src: '<%= src.js.src %>',
				exclude: [
					'./js/utils/keys.js'
				],
				options: {
					//jsLintXML: 'report.xml', // create XML JSLint-like report
					errorsOnly: false, // show only maintainability errors
					cyclomatic: 15,
					halstead: 25,
					maintainability: 100
				}
			}
		}
	});
};
